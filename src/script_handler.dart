import 'dart:io';
import 'package:shelf/shelf.dart';
import 'headers.dart';

Future<Response> scriptHandler(Request request, String name) async => Response(
      200,
      headers: jsHeaders,
      body: await File("static/scripts/$name.js").readAsString(),
    );
