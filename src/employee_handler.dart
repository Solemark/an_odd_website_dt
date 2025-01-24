import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'person.dart';
import 'headers.dart';

Future<Response> getEmployeeHandler(Request req) async {
  final List<Employee> data = await getPersonData("employees");
  final Iterable<Employee> res = data.where((item) => item.visible);
  final List<Map<dynamic, dynamic>> output = res.map((item) => item.toJson()).toList();
  return Response(200, headers: jsonHeaders, body: jsonEncode(output));
}

Future<Response> newEmployeeHandler(Request req) async {
  final List<Employee> data = await getPersonData("employees");
  final Map<String, String> res = req.url.queryParameters;
  data.add(Employee(data.length + 1, res['first_name']!, res['last_name']!, res['email_address']!, true));
  await writePersonData("employees", data);
  return Response(302, headers: {"location": "/employees"});
}

Future<Response> updateEmployeeHandler(Request req) async {
  final List<Employee> data = await getPersonData("employees");
  final Map<String, String> res = req.url.queryParameters;
  data[int.parse(res["id"]!) - 1] =
      Employee(int.parse(res["id"]!), res["first_name"]!, res["last_name"]!, res["email_address"]!, true);
  await writePersonData("employees", data);
  return Response(302, headers: {"location": "/employees"});
}

Future<Response> removeEmployeeHandler(Request req) async {
  final List<Employee> data = await getPersonData("employees");
  final Map<String, String> res = req.url.queryParameters;
  data[int.parse(res["id"]!) - 1].visible = false;
  await writePersonData("employees", data);
  return Response(302, headers: {"location": "/employees"});
}
