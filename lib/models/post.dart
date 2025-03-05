// lib/models/post.dart
class Post {
  final String imageUrl;
  final String description;
  bool isLiked;
  bool isSaved;
  List<String> comments;
  List<String> users;

  Post({
    required this.imageUrl,
    required this.description,
    this.isLiked = false,
    this.isSaved = false,
    this.comments = const [],
    this.users = const [],
  });
}
