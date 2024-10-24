class Client {
  int client_id;
  String first_name;
  String last_name;
  String email_address;
  bool visible;
  Client(this.client_id, this.first_name, this.last_name, this.email_address, this.visible);

  Map get toJson => {
        "client_id": this.client_id,
        "first_name": this.first_name,
        "last_name": this.last_name,
        "email_address": this.email_address
      };

  @override
  String toString() => "${this.client_id},${this.first_name},${this.last_name},${this.email_address},${this.visible}";
}
