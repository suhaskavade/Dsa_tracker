import os, re
pattern = re.compile(r"import\s+'(\.\./)+([^']+)\.dart';")
for root, dirs, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            new_content = pattern.sub(lambda m: "import 'package:dsa_tracker/" + m.group(2) + ".dart';", content)
            if new_content != content:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                print("Fixed " + filepath)
