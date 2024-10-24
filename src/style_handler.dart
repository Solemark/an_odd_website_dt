import 'dart:io';
import 'package:shelf/shelf.dart';
import 'headers.dart';

Future<Response> styleHandler(Request request, String name) async => Response(
      200,
      headers: cssHeaders,
      body: await File("static/styles/$name.css").readAsString(),
    );
