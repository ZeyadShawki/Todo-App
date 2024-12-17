class UserData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final int points;
  final int credits;
  final String token;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credits,
    required this.token,
  });

  // Factory constructor for JSON deserialization
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
      points: json['points'] ?? 0,
      credits: json['credits'] ?? 0,
      token: json['token'] ?? '',
    );
  }

  // Method to convert UserData instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'points': points,
      'credits': credits,
      'token': token,
    };
  }
}
