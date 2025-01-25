import 'package:shelf/shelf.dart';
import 'helpers.dart';
import 'person.dart';

Future<Response> getDataHandler(Request req, String name) async {
  final List<Person> data = await getPersonData(name);
  final Iterable<Person> res = data.where((item) => item.visible);
  final List<Map<dynamic, dynamic>> output = res.map((item) => item.toJson()).toList();
  return sendJson(output);
}

Future<Response> newDataHandler(Request req, String name) async {
  final Map<String, String> res = await decodeResponse(req);
  List<Person> data = await getPersonData(name);
  data.add(Person(data.length + 1, res['first_name']!, res['last_name']!, res['email_address']!, true));
  await writePersonData(name, data);
  return sendRedirect("/$name");
}

Future<Response> updateDataHandler(Request req, String name) async {
  final Map<String, String> res = await decodeResponse(req);
  List<Person> data = await getPersonData(name);
  data[int.parse(res["id"]!) - 1] =
      Person(int.parse(res["id"]!), res["first_name"]!, res["last_name"]!, res["email_address"]!, true);
  await writePersonData(name, data);
  return sendRedirect("/$name");
}

Future<Response> removeDataHandler(Request req, String name) async {
  final Map<String, String> res = await decodeResponse(req);
  List<Person> data = await getPersonData(name);
  data[int.parse(res["id"]!) - 1].visible = false;
  await writePersonData(name, data);
  return sendRedirect("/$name");
}
