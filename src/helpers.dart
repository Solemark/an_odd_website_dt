import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';

final Map<String, String> jsonHeaders = {'content-type': 'application/json'};
final Map<String, String> htmlHeaders = {'content-type': 'text/html'};
final Map<String, String> imageHeaders = {'content-type': 'image/x-icon'};
final Map<String, String> cssHeaders = {'content-type': 'text/css'};
final Map<String, String> jsHeaders = {'content-type': 'text/javascript'};

Future<Map<String, String>> decodeResponse(Request req) async {
  Map<String, String> output = {};
  final String msg = await req.readAsString();
  final List<String> paramList = msg.split('&');
  for (String item in paramList) {
    final List<String> i = item.split('=');
    output[i[0]] = i[1];
  }
  return output;
}

Future<Response> sendHTML(String page) async =>
    Response(200, headers: htmlHeaders, body: await File("static/$page.html").readAsString());
Future<Response> sendIcon() async =>
    Response(200, headers: imageHeaders, body: await File("static/favicon.ico").readAsBytes());
Future<Response> sendStyle(String name) async =>
    Response(200, headers: cssHeaders, body: await File("static/styles/$name.css").readAsString());
Future<Response> sendJS(String name) async =>
    Response(200, headers: jsHeaders, body: await File("static/scripts/$name.js").readAsString());
Future<Response> sendJson(Object msg) async => Response(200, headers: jsonHeaders, body: jsonEncode(msg));
Future<Response> sendRedirect(String page) async => Response(302, headers: {"location": page});
