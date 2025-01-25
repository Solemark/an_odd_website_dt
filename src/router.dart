import 'dart:io';
import 'data_handler.dart';
import 'webpage_handler.dart';
import 'settings_handler.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

class WebServer {
  final List<String> db = ["clients", "employees", "settings"];

  final Router _router = Router()
    ..get("/", indexHandler)
    ..get("/favicon.ico", iconHandler)
    ..get("/<name>", webpageHandler)
    ..get("/styles/<name>", styleHandler)
    ..get("/scripts/<name>", scriptHandler)
    ..get("/data/settings", getSettingsHandler)
    ..post("/data/settings/update", updateSettingHandler)
    ..get("/data/<name>", getDataHandler)
    ..post("/data/<name>/new", newDataHandler)
    ..post("/data/<name>/update", updateDataHandler)
    ..post("/data/<name>/remove", removeDataHandler);

  /// Start the [Server]
  Future<void> start([int port = 8080]) async {
    await this.verifyDB();
    final Cascade cascade = Cascade().add(_router.call);
    final HttpServer server = await serve(
      logRequests().addHandler(cascade.handler),
      InternetAddress.anyIPv4,
      port,
    );
    print('Serving at http://${server.address.host}:${server.port}');
  }

  /// Verify that DB data files exist
  Future<void> verifyDB() async {
    if (!await Directory("data").exists()) await Directory("data").create();
    this.db.forEach((item) async {
      if (!await File("data/$item.csv").exists()) await File("data/$item.csv").create();
    });
  }
}
