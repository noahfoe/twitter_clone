class UserModel {
  final String? id;
  final String bannerImage;
  final String profileImage;
  final String? name;
  final String? email;
  final String? username;

  UserModel({
    required this.bannerImage,
    required this.profileImage,
    this.name,
    this.email,
    this.id,
    this.username,
  });
}
