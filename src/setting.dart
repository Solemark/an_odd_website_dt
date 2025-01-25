import 'dart:io';

class Setting {
  String name;
  bool status;
  Setting(this.name, this.status);
  Map<String, dynamic> toJson() => {"name": this.name, "status": this.status};
  @override
  String toString() => "${this.name},${this.status}";
}

Future<List<Setting>> getSettingData() async {
  final List<String> res = await File("data/settings.csv").readAsLines();
  return res.map((data) => data.split(",")).map((row) => Setting(row[0], bool.parse(row[1]))).toList();
}

Future<void> writeSettingData(List<Setting> data) async =>
    File("data/settings.csv").writeAsString(data.join("\n"), mode: FileMode.write);
