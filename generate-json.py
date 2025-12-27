#!/usr/bin/env python3
"""
Generate gSender macro JSON from .macro.nc files.
"""

import json
import uuid
import glob
from pathlib import Path


def generate_macro_id():
    return str(uuid.uuid4())


def read_macro_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        return f.read()


def get_macro_name(filepath):
    name = Path(filepath).stem
    if name.endswith('.macro'):
        name = name[:-6]
    
    # Handle numbered prefix (e.g., "00-machine-config")
    if name[:2].isdigit() and name[2] == '-':
        name = name[3:]
    
    name = name.replace('-', ' ').title()
    
    # Fix common terms
    replacements = {
        'Bitsetter': 'BitSetter',
        'Bitzero': 'BitZero',
        'Xyz': 'XYZ',
        'Xy': 'XY',
        'X0y0': 'X0 Y0',
        'Goto': 'Go To',
        'V2': 'V2',
        'Config': 'Config ⚙️',
    }
    for old, new in replacements.items():
        name = name.replace(old, new)
    
    return name


def get_sort_key(filepath):
    """Sort with 00-machine-config first, then alphabetically."""
    name = Path(filepath).stem
    if name.startswith('00-'):
        return '0' + name
    return '1' + name


def main():
    macro_files = sorted(glob.glob('*.macro.nc'), key=get_sort_key)
    
    if not macro_files:
        print("No .macro.nc files found")
        return
    
    print(f"Found {len(macro_files)} macro files:")
    
    macros = []
    for filepath in macro_files:
        name = get_macro_name(filepath)
        content = read_macro_file(filepath)
        
        macro = {
            "id": generate_macro_id(),
            "name": name,
            "content": content
        }
        macros.append(macro)
        print(f"  - {name}")
    
    output_file = 'shapeoko5-macros.json'
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(macros, f, indent=2)
    
    print(f"\nGenerated {output_file}")
    print("\nIMPORTANT: Run 'Machine Config' macro first after importing!")


if __name__ == '__main__':
    main()
