class Users {
  String userId;
  String name;
  String surname;
  String password;
  String mail;
  String imageUrl;

  Users.fromMap(Map<String, dynamic> data) {
    userId = data['userId'];
    name = data['name'];
    surname = data['surname'];
    password = data['password'];
    mail = data['mail'];
    imageUrl = data['imageUrl'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'surname': surname,
      'password': password,
      'mail': mail,
      'imageUrl': imageUrl,
    };
  }
}
