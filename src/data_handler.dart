import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'person.dart';
import 'headers.dart';

Future<Response> getDataHandler(Request req, String name) async {
  final List<Person> data = await getPersonData(name);
  final Iterable<Person> res = data.where((item) => item.visible);
  final List<Map<dynamic, dynamic>> output = res.map((item) => item.toJson()).toList();
  return Response(200, headers: jsonHeaders, body: jsonEncode(output));
}

Future<Response> newDataHandler(Request req, String name) async {
  final List<Person> data = await getPersonData(name);
  final Map<String, String> res = req.url.queryParameters;
  data.add(Person(data.length + 1, res['first_name']!, res['last_name']!, res['email_address']!, true));
  await writePersonData(name, data);
  return Response(302, headers: {"location": "/$name"});
}

Future<Response> updateDataHandler(Request req, String name) async {
  final List<Person> data = await getPersonData(name);
  final Map<String, String> res = req.url.queryParameters;
  data[int.parse(res["id"]!) - 1] =
      Person(int.parse(res["id"]!), res["first_name"]!, res["last_name"]!, res["email_address"]!, true);
  await writePersonData(name, data);
  return Response(302, headers: {"location": "/$name"});
}

Future<Response> removeDataHandler(Request req, String name) async {
  final List<Person> data = await getPersonData(name);
  final Map<String, String> res = req.url.queryParameters;
  data[int.parse(res["id"]!) - 1].visible = false;
  await writePersonData(name, data);
  return Response(302, headers: {"location": "/$name"});
}
