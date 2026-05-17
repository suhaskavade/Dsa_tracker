import os

replacements = {
    "package:dsa_tracker/models/": "package:dsa_tracker/data/models/",
    "package:dsa_tracker/datasources/": "package:dsa_tracker/data/datasources/",
    "package:dsa_tracker/entities/": "package:dsa_tracker/domain/entities/",
    "package:dsa_tracker/providers/": "package:dsa_tracker/presentation/providers/",
    "package:dsa_tracker/repositories/i_": "package:dsa_tracker/domain/repositories/i_",
    "package:dsa_tracker/repositories/question_": "package:dsa_tracker/data/repositories/question_",
    "package:dsa_tracker/repositories/progress_": "package:dsa_tracker/data/repositories/progress_",
    "package:dsa_tracker/features/": "package:dsa_tracker/presentation/features/",
    "package:dsa_tracker/theme/": "package:dsa_tracker/core/theme/",
    "package:dsa_tracker/utils/": "package:dsa_tracker/core/utils/",
    "package:dsa_tracker/widgets/": "package:dsa_tracker/presentation/features/solver/widgets/"
}

for root, dirs, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            new_content = content
            for k, v in replacements.items():
                new_content = new_content.replace(k, v)
                
            if "app_theme.dart" in filepath:
                new_content = new_content.replace("cardTheme: CardTheme(", "cardTheme: CardThemeData(")
                
            if new_content != content:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                print("Fixed " + filepath)
