class User {
  final String? token;
  final int? id;
  final String? name;
  final String? email;
  final DateTime? emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.token,
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"] as String,
        id: json["user"]["id"] as int,
        name: json["user"]["name"] as String,
        email: json["user"]["email"] as String,
        emailVerifiedAt: json["user"]["email_verified_at"] != null
            ? DateTime.parse(json["user"]["email_verified_at"] as String)
            : null,
        createdAt: DateTime.parse(json["user"]["created_at"] as String),
        updatedAt: DateTime.parse(json["user"]["updated_at"] as String),
      );
}
