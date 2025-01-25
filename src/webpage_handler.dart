import 'dart:io';
import 'package:shelf/shelf.dart';
import 'headers.dart';

/// Get the homepage (index.html)
Future<Response> indexHandler(Request req) async =>
    Response(200, headers: htmlHeaders, body: await File("static/index.html").readAsString());

/// Get the webpage favicon (favicon.ico)
Future<Response> iconHandler(Request req) async =>
    Response(200, headers: imageHeaders, body: await File("static/favicon.ico").readAsBytes());

/// Get a webpage dynamically (webpage_name.html)
Future<Response> webpageHandler(Request req, String name) async =>
    Response(200, headers: htmlHeaders, body: await File("static/$name.html").readAsString());

/// Get a style page (style_name.css)
Future<Response> styleHandler(Request req, String name) async =>
    Response(200, headers: cssHeaders, body: await File("static/styles/$name.css").readAsString());

/// Get a script file (script_name.js)
Future<Response> scriptHandler(Request req, String name) async =>
    Response(200, headers: jsHeaders, body: await File("static/scripts/$name.js").readAsString());
