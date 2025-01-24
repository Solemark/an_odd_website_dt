import 'dart:io';
import 'client_handler.dart';
import 'employee_handler.dart';
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
    ..get("/data/clients", getClientHandler)
    ..get("/data/clients/new", newClientHandler)
    ..get("/data/clients/update", updateClientHandler)
    ..get("/data/clients/remove", removeClientHandler)
    ..get("/data/employees", getEmployeeHandler)
    ..get("/data/employees/new", newEmployeeHandler)
    ..get("/data/employees/update", updateEmployeeHandler)
    ..get("/data/employees/remove", removeEmployeeHandler);

  Future<void> start() async {
    final int port = 8080;
    final cascade = Cascade().add(_router.call);
    final server = await shelf_io.serve(
      logRequests().addHandler(cascade.handler),
      InternetAddress.anyIPv4,
      port,
    );
    print('Serving at http://${server.address.host}:${server.port}');
  }
}
