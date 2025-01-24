import 'dart:io';

// TODO - Separate Client & Employee from Person
typedef Client = Person;
typedef Employee = Person;

class Person {
  int id;
  String first_name, last_name, email_address;
  bool visible;
  Person(this.id, this.first_name, this.last_name, this.email_address, this.visible);
  Map toJson() => {
        "id": this.id,
        "first_name": this.first_name,
        "last_name": this.last_name,
        "email_address": this.email_address,
        "visible": this.visible,
      };

  @override
  String toString() => "${this.id},${this.first_name},${this.last_name},${this.email_address},${this.visible}";
}

Future<List<Person>> getPersonData(String type) async {
  final List<String> res = await File("data/$type.csv").readAsLines();
  return res
      .map((data) => data.split(","))
      .map((row) => Person(int.parse(row[0]), row[1], row[2], row[3], bool.parse(row[4])))
      .toList();
}

Future<void> writePersonData(String type, List<Person> data) async =>
    File("data/$type.csv").writeAsString(data.join("\n"), mode: FileMode.write);
