import 'package:shelf/shelf.dart';
import 'helpers.dart';

/// Get the homepage (index.html)
Future<Response> indexHandler(Request req) async => sendHTML("index");

/// Get the webpage favicon (favicon.ico)
Future<Response> iconHandler(Request req) async => sendIcon();

/// Get a webpage dynamically (webpage_name.html)
Future<Response> webpageHandler(Request req, String name) async => sendHTML(name);

/// Get a style page (style_name.css)
Future<Response> styleHandler(Request req, String name) async => sendStyle(name);

/// Get a script file (script_name.js)
Future<Response> scriptHandler(Request req, String name) async => sendJS(name);
