import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'person.dart';
import 'headers.dart';

Future<Response> getClientHandler(Request req) async {
  final List<Client> data = await getPersonData("clients");
  final Iterable<Client> res = data.where((item) => item.visible);
  final List<Map<dynamic, dynamic>> output = res.map((item) => item.toJson()).toList();
  return Response(200, headers: jsonHeaders, body: jsonEncode(output));
}

Future<Response> newClientHandler(Request req) async {
  final List<Client> data = await getPersonData("clients");
  final Map<String, String> res = req.url.queryParameters;
  data.add(Client(data.length + 1, res['first_name']!, res['last_name']!, res['email_address']!, true));
  await writePersonData("clients", data);
  return Response(302, headers: {"location": "/clients"});
}

Future<Response> updateClientHandler(Request req) async {
  final List<Client> data = await getPersonData("clients");
  final Map<String, String> res = req.url.queryParameters;
  data[int.parse(res["id"]!) - 1] =
      Client(int.parse(res["id"]!), res["first_name"]!, res["last_name"]!, res["email_address"]!, true);
  await writePersonData("clients", data);
  return Response(302, headers: {"location": "/clients"});
}

Future<Response> removeClientHandler(Request req) async {
  final List<Client> data = await getPersonData("clients");
  final Map<String, String> res = req.url.queryParameters;
  data[int.parse(res["id"]!) - 1].visible = false;
  await writePersonData("clients", data);
  return Response(302, headers: {"location": "/clients"});
}
