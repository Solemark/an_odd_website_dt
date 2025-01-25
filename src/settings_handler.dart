import 'package:shelf/shelf.dart';
import 'setting.dart';
import 'helpers.dart';

Future<Response> getSettingsHandler(Request req) async {
  final List<Setting> data = await getSettingData();
  final List<Map<dynamic, dynamic>> output = data.map((item) => item.toJson()).toList();
  return sendJson(output);
}

Future<Response> updateSettingHandler(Request req) async {
  final Map<String, String> res = await decodeResponse(req);
  final List<Setting> data = await getSettingData();
  final int i = data.indexWhere((item) => item.name == res["name"]);
  data[i].status = !data[i].status;
  await writeSettingData(data);
  return sendRedirect("/settings");
}
