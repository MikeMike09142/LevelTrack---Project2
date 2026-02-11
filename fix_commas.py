
import os

file_path = r'c:\Users\migue\Desktop\project2\lib\data\sample_data.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Fix missing comma before items
content = content.replace("'''\n    items:", "''',\n    items:")

# Fix missing comma before version
content = content.replace("'''\n    version:", "''',\n    version:")

# Also handle cases where there might be extra newlines or different indentation
# But based on the read output, it seems consistent. 
# Let's also check for version before theory (Level 7) which I did manually.
# Level 7: version: 7, theory: '''...''' items:
# So for Level 7, we need comma after ''' before items. Covered by first replace.
# Levels 8-15: theory: '''...''' version: 7, items:
# So we need comma after ''' before version. Covered by second replace.

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Fixed commas in sample_data.dart")
