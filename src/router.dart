import 'dart:io';
import 'data_handler.dart';
import 'webpage_handler.dart';
import 'settings_handler.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

class WebServer {
  final Router _router = Router()
    ..get("/", indexHandler)
    ..get("/favicon.ico", iconHandler)
    ..get("/<name>", webpageHandler)
    ..get("/styles/<name>", styleHandler)
    ..get("/scripts/<name>", scriptHandler)
    ..get("/data/settings", getSettingsHandler)
    ..get("/data/settings/update", updateSettingHandler)
    ..get("/data/<name>", getDataHandler)
    ..get("/data/<name>/new", newDataHandler)
    ..get("/data/<name>/update", updateDataHandler)
    ..get("/data/<name>/remove", removeDataHandler);

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
    ["clients", "employees", "settings"].forEach((item) async {
      if (!await File("data/$item.csv").exists()) await File("data/$item.csv").create();
    });
  }
}
