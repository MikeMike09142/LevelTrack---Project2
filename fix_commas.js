
const fs = require('fs');
const path = 'lib/data/sample_data.dart';

try {
  let content = fs.readFileSync(path, 'utf8');
  
  // Fix: ''' followed by newline and items:
  // We use a regex that looks for ''' followed by whitespace and then items:
  // and we insert a comma.
  // Regex explanation:
  // (''')       - Group 1: The closing triple quotes
  // (\s+)       - Group 2: Whitespace (newlines/spaces)
  // (items:)    - Group 3: The items key
  // Replacement: $1,$2$3
  
  // Note: We need to be careful not to double commas if they exist.
  // But strictly speaking, the user missed them.
  // A safer regex: '''(?!\s*,)\s+(items:|version:)
  
  // Pattern 1: theory ending, then items
  content = content.replace(/'''(\s+items:)/g, "''',$1");
  
  // Pattern 2: theory ending, then version
  content = content.replace(/'''(\s+version:)/g, "''',$1");
  
  fs.writeFileSync(path, content, 'utf8');
  console.log('Successfully fixed commas in sample_data.dart');
  
} catch (err) {
  console.error('Error fixing file:', err);
  process.exit(1);
}
