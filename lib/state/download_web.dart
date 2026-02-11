import 'dart:convert';
import 'dart:js_interop';
import 'package:web/web.dart' as web;

void downloadJson(String name, String data) {
  final bytes = utf8.encode(data);
  final blob = web.Blob([bytes.toJS].toJS, web.BlobPropertyBag(type: 'application/json'));
  final url = web.URL.createObjectURL(blob);
  
  final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
  anchor.href = url;
  anchor.download = name;
  anchor.style.display = 'none';
  
  web.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
  web.URL.revokeObjectURL(url);
}