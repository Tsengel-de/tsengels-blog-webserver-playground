from deep_translator import GoogleTranslator
import sys

text = "Алтан загас хүйтэн усанд"
try:
    translated = GoogleTranslator(source='auto', target='de').translate(text)
    print(f"DE: {translated}")
    translated_en = GoogleTranslator(source='auto', target='en').translate(text)
    print(f"EN: {translated_en}")
except Exception as e:
    print(f"Error: {e}")
