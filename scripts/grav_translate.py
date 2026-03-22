import os
import re
import yaml
import time
from deep_translator import GoogleTranslator

CYRILLIC_PATTERN = re.compile(r'[а-яА-ЯёЁөүӨҮ]+')
SHORTCODE_PATTERN = re.compile(r'\[/?\w+.*?\]')

def is_cyrillic(text):
    return bool(CYRILLIC_PATTERN.search(str(text)))

def translate_text(text, target_lang):
    if not text or not is_cyrillic(text):
        return text
    
    # Simple extraction of translatable parts
    # For now, we translate the whole string if it contains Cyrillic
    try:
        translator = GoogleTranslator(source='auto', target=target_lang)
        translated = translator.translate(text)
        return translated
    except Exception as e:
        print(f"Translation Error: {e}")
        return text

def translate_frontmatter(data, target_lang):
    # Ensure HTML processing is enabled for notices/shortcodes
    if 'process' not in data:
        data['process'] = {}
    data['process']['html'] = True
    
    fields_to_translate = [
        'title', 'subtitle'
    ]
    
    for field in fields_to_translate:
        if field in data:
            data[field] = translate_text(data[field], target_lang)
            
    if 'aura' in data and 'description' in data['aura']:
        data['aura']['description'] = translate_text(data['aura']['description'], target_lang)
        
    if 'metadata' in data:
        meta = data['metadata']
        m_fields = ['description', 'og:title', 'og:description', 'twitter:title', 'twitter:description']
        for mf in m_fields:
            if mf in meta:
                meta[mf] = translate_text(meta[mf], target_lang)
        # Author name is usually 'Цэнгэл😁'
        for mf in ['og:author', 'article:author']:
            if mf in meta and 'Цэнгэл' in meta[mf]:
                meta[mf] = meta[mf].replace('Цэнгэл', 'Tsengel')
                
    if 'taxonomy' in data and 'tag' in data['taxonomy']:
        tags = data['taxonomy']['tag']
        data['taxonomy']['tag'] = [translate_text(t, target_lang) for t in tags]
                
    return data

def translate_body(body, target_lang):
    translated_lines = []
    
    for line in body.split('\n'):
        if not line or not is_cyrillic(line):
            translated_lines.append(line)
            continue
            
        if line.strip().startswith('```'):
            translated_lines.append(line)
            continue
            
        text_to_process = line
        prefix = ""
        
        # Handle Grav Notice Plugin (!!!, !!, ! followed by space)
        # Avoid matching image markers ![
        notice_match = re.match(r'^(!{2,3}|!\s)\s*(.*)', text_to_process)
        if notice_match:
            prefix = notice_match.group(1).strip() + " "
            text_to_process = notice_match.group(2)
            
        # 1. Identify and extract technical markers (Images and Shortcodes)
        # We'll use a list of tokens (either a string or a dict representing a technical marker)
        tokens = []
        last_end = 0
        
        # Combined pattern for:
        # 1. Images: !\[(.*?)\]\((.*?)\)
        # 2. Shortcodes: \[/?\w+.*?\]
        # 3. Links: \[(?!/?\w+.*\])(.*?)\]\((.*?)\)  (careful not to match shortcodes)
        # 4. URLs: https?://\S+
        pattern = re.compile(r'(!\[(?P<img_alt>.*?)\]\((?P<img_url>.*?)\))|(?P<sc>\[/?\w+.*?\])|(\[(?!/?\w+.*\])(?P<link_text>.*?)\]\((?P<link_url>.*?)\))|(?P<url>https?://\S+)')
        
        for match in pattern.finditer(text_to_process):
            # Text before the match
            if match.start() > last_end:
                tokens.append({'type': 'text', 'value': text_to_process[last_end:match.start()]})
            
            # The match itself
            if match.group('img_alt') is not None:
                alt = match.group('img_alt')
                url_part = match.group('img_url')
                # url_part might contain a title in quotes
                title_match = re.search(r'"(.*)"', url_part)
                title = title_match.group(1) if title_match else None
                # Construct the full image text for the 'original' field if needed
                tokens.append({'type': 'image', 'alt': alt, 'url_part': url_part, 'title': title, 'original': match.group(0)})
            elif match.group('sc') is not None:
                tokens.append({'type': 'sc', 'value': match.group('sc')})
            elif match.group('link_text') is not None:
                tokens.append({'type': 'link', 'text': match.group('link_text'), 'url': match.group('link_url'), 'original': match.group(0)})
            elif match.group('url') is not None:
                tokens.append({'type': 'url', 'value': match.group('url')})
            
            last_end = match.end()
            
        # Remaining text
        if last_end < len(text_to_process):
            tokens.append({'type': 'text', 'value': text_to_process[last_end:]})
            
        # 2. Process tokens
        translated_segments = []
        for token in tokens:
            if token['type'] == 'text':
                val = token['value']
                if is_cyrillic(val):
                    translated_segments.append(translate_text(val, target_lang))
                else:
                    translated_segments.append(val)
            elif token['type'] == 'image':
                alt = token['alt']
                url_part = token['url_part']
                title = token['title']
                
                new_alt = translate_text(alt, target_lang) if is_cyrillic(alt) else alt
                new_url_part = url_part
                if title:
                    new_title = translate_text(title, target_lang) if is_cyrillic(title) else title
                    new_url_part = re.sub(r'"(.*)"', f'"{new_title}"', url_part)
                
                translated_segments.append(f'![{new_alt}]({new_url_part})')
            elif token['type'] == 'link':
                text = token['text']
                url = token['url']
                new_text = translate_text(text, target_lang) if is_cyrillic(text) else text
                translated_segments.append(f'[{new_text}]({url})')
            elif token['type'] == 'url':
                translated_segments.append(token['value'])
            else:
                # Shortcode, keep as is
                translated_segments.append(token['value'])
                
        translated_lines.append(prefix + "".join(translated_segments))
           
    return '\n'.join(translated_lines)

def process_file(source_file, target_lang):
    print(f"Processing {source_file} -> {target_lang}")
    try:
        with open(source_file, 'r', encoding='utf-8') as f:
            content = f.read()
            
        parts = content.split('---', 2)
        if len(parts) < 3:
            print(f"Invalid Grav file format for {source_file}")
            return
            
        front_raw = parts[1]
        body = parts[2]
        
        data = yaml.safe_load(front_raw)
        translated_data = translate_frontmatter(data, target_lang)
        
        # Use explicit Dumper settings to match Grav style somewhat
        new_front = yaml.dump(translated_data, allow_unicode=True, default_flow_style=False, sort_keys=False)
        
        translated_body = translate_body(body, target_lang)
        
        target_file = source_file.replace('.mn.md', f'.{target_lang}.md')
        
        with open(target_file, 'w', encoding='utf-8') as f:
            f.write('---\n')
            f.write(new_front)
            f.write('---\n')
            f.write(translated_body)
            
        print(f"Saved {target_file}")
    except Exception as e:
        print(f"Error processing {source_file}: {e}")

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('files', nargs='+', help='Paths to item.mn.md files')
    parser.add_argument('--lang', nargs='+', default=['de', 'en'], help='Target languages')
    args = parser.parse_args()
    
    for file_path in args.files:
        for lang in args.lang:
            process_file(file_path, lang)
            time.sleep(1) # Modest sleep between calls
