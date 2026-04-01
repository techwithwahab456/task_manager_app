class User {
  int? id;
  String email;
  String password; // In real app, you'd store hashed password
  String createdAt;

  User({
    this.id,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'createdAt': createdAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      createdAt: map['createdAt'],
    );
  }
}