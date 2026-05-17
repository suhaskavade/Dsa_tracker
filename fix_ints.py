import os, re
pattern = re.compile(r'id:\s*(-?\d{16,}),')
def replacer(match):
    num = match.group(1)
    num_f = float(num)
    return f"id: {int(num_f)},"

for root, dirs, files in os.walk('lib/data/models'):
    for file in files:
        if file.endswith('.g.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            new_content = pattern.sub(replacer, content)
            if new_content != content:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                print(f"Fixed ints in {filepath}")
