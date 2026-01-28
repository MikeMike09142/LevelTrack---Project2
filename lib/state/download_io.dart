import 'dart:io';

void downloadJson(String name, String data) {
  // Save in project directory if run as a desktop app.
  final file = File('lib/data/$name');
  file.createSync(recursive: true);
  file.writeAsStringSync(data);
}