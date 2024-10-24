import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'client.dart';
import 'headers.dart';

Future<List<Client>> _getClientData() async {
  var res = await File("data/clients.csv").readAsLines();
  return res
      .map((data) => data.split(","))
      .map((row) => Client(int.parse(row[0]), row[1], row[2], row[3], bool.parse(row[4])))
      .toList();
}

Future<void> _writeClientData(List<Client> data) =>
    File("data/clients.csv").writeAsString(data.join("\n"), mode: FileMode.write);

Future<Response> getClientsHandler(Request request) async {
  final List<Client> data = await _getClientData();
  final Iterable<Client> results = data.where((client) => client.visible == true);
  final List<Map<dynamic, dynamic>> output = results.map((client) => client.toJson).toList();
  return Response(200, headers: jsonHeaders, body: jsonEncode(output));
}

Future<Response> newClientHandler(Request request) async {
  List<Client> clientData = await _getClientData();
  final Map<String, String> result = request.url.queryParameters;
  clientData
      .add(Client(clientData.length + 1, result['first_name']!, result['last_name']!, result['email_address']!, true));
  print("new client: ${clientData.last}");
  await _writeClientData(clientData);
  return Response(302, headers: {"location": "/clients"});
}

Future<Response> updateClientHandler(Request request) async {
  List<Client> clientData = await _getClientData();
  final Map<String, String> result = request.url.queryParameters;
  clientData[int.parse(result["client_id"]!) - 1] = Client(
    int.parse(result["client_id"]!),
    result["first_name"]!,
    result["last_name"]!,
    result["email_address"]!,
    true,
  );
  await _writeClientData(clientData);
  return Response(302, headers: {"location": "/clients"});
}

Future<Response> removeClientHandler(Request request) async {
  List<Client> clientData = await _getClientData();
  final Map<String, String> result = request.url.queryParameters;
  clientData[int.parse(result["client_id"]!) - 1].visible = false;
  await _writeClientData(clientData);
  return Response(302, headers: {"location": "/clients"});
}
