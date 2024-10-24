import 'dart:convert';

String jsonEncode(List<Object> data) => JsonEncoder.withIndent(' ').convert(data);
