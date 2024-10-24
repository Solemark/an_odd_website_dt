import 'dart:io';
import 'src/client_handler.dart';
import 'src/icon_handler.dart';
import 'src/script_handler.dart';
import 'src/style_handler.dart';
import 'src/webpage_handler.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

final _router = shelf_router.Router()
  ..get("/", indexHandler)
  ..get("/favicon.ico", iconHandler)
  ..get("/<name>", webpageHandler)
  ..get("/styles/<name>", styleHandler)
  ..get("/scripts/<name>", scriptHandler)
  ..get("/data/clients", getClientsHandler)
  ..get("/data/clients/new", newClientHandler)
  ..get("/data/clients/update", updateClientHandler)
  ..get("/data/clients/remove", removeClientHandler);

Future<void> main() async {
  final int port = 8080;
  final cascade = Cascade().add(_router.call);
  final server = await shelf_io.serve(
    logRequests().addHandler(cascade.handler),
    InternetAddress.anyIPv4,
    port,
  );
  print('Serving at http://${server.address.host}:${server.port}');
}
