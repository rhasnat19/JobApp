import 'dart:convert';

class AuthUser {
  String? id;
  String? fullName;
  
  String? email;
  AuthUser({
    this.id,
    this.fullName,
    this.email,
  });

  AuthUser copyWith({
    String? id,
    String? fullName,
    String? email,
  }) {
    return AuthUser(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUser.fromJson(String source) =>
      AuthUser.fromMap(json.decode(source));

  @override
  String toString() => 'AuthUser(id: $id, fullName: $fullName, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AuthUser &&
      other.id == id &&
      other.fullName == fullName &&
      other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ fullName.hashCode ^ email.hashCode;
}
