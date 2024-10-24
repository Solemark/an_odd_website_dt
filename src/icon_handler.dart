import 'dart:io';
import 'package:shelf/shelf.dart';
import 'headers.dart';

Future<Response> iconHandler(Request request) async => Response(
      200,
      headers: imageHeaders,
      body: await File("static/favicon.ico").readAsBytes(),
    );
