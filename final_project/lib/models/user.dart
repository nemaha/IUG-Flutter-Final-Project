class User {
  int? id;
  String? email;
  String? name;
  String? password;

  User(dynamic obj) {
    id = obj['id'];
    email = obj['email'];
    name = obj['name'];
    password = obj['password'];
  }
  User.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    email = map['email'];
    name = map['name'];
    password = map['password'];
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'name': name,
        'password': password,
      };
}
