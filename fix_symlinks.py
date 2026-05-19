import os

def make_relative(root_dir):
    for root, dirs, files in os.walk(root_dir):
        for name in files:
            path = os.path.join(root, name)
            if os.path.islink(path):
                target = os.readlink(path)
                if target.startswith('/home/tsengel/grav-blog/grav/') or target.startswith('/home/pi/www/grav/'):
                    # Get the relative path from the symlink location to the user_media folder
                    # But actually, most symlinks point to user_media.
                    # Let's just find the relative path to the target.
                    
                    # Convert legacy target to new target
                    new_target = target.replace('/home/pi/www/grav/', root_dir + '/')
                    new_target = new_target.replace('/home/tsengel/grav-blog/grav/', root_dir + '/')
                    
                    if os.path.exists(new_target):
                        rel_path = os.path.relpath(new_target, root)
                        os.remove(path)
                        os.symlink(rel_path, path)
                        print(f"Fixed {path} -> {rel_path}")

import sys; make_relative(sys.argv[1])
