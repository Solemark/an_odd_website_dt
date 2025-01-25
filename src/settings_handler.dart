import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'setting.dart';
import 'headers.dart';

Future<Response> getSettingsHandler(Request req) async {
  final List<Setting> data = await getSettingData();
  final List<Map<dynamic, dynamic>> output = data.map((item) => item.toJson()).toList();
  return Response(200, headers: jsonHeaders, body: jsonEncode(output));
}

Future<Response> updateSettingHandler(Request req) async {
  final List<Setting> data = await getSettingData();
  final Map<String, String> res = req.url.queryParameters;
  final int i = data.indexWhere((item) => item.name == res["name"]);
  data[i].status = !data[i].status;
  await writeSettingData(data);
  return Response(302, headers: {"location": "/settings"});
}
