import 'dart:io';
import 'data_handler.dart';
import 'icon_handler.dart';
import 'script_handler.dart';
import 'style_handler.dart';
import 'webpage_handler.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

class Router {
  final _router = shelf_router.Router()
    ..get("/", indexHandler)
    ..get("/favicon.ico", iconHandler)
    ..get("/<name>", webpageHandler)
    ..get("/styles/<name>", styleHandler)
    ..get("/scripts/<name>", scriptHandler)
    ..get("/data/<name>", getDataHandler)
    ..get("/data/<name>/new", newDataHandler)
    ..get("/data/<name>/update", updateDataHandler)
    ..get("/data/<name>/remove", removeDataHandler);

  Future<void> start() async {
    await this.verifyDB();
    final int port = 8080;
    final cascade = Cascade().add(_router.call);
    final server = await shelf_io.serve(
      logRequests().addHandler(cascade.handler),
      InternetAddress.anyIPv4,
      port,
    );
    print('Serving at http://${server.address.host}:${server.port}');
  }

  Future<void> verifyDB() async {
    if (!await Directory("data").exists()) await Directory("data").create();
    if (!await File("data/clients.csv").exists()) await File("data/clients.csv").create();
    if (!await File("data/employees.csv").exists()) await File("data/employees.csv").create();
    if (!await File("data/test.csv").exists()) await File("data/test.csv").create();
  }
}
