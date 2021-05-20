class Post {
  const Post(
      {required this.id,
      required this.title,
      required this.level,
      required this.post,
      required this.division,
      required this.branch,
      required this.dutystation,
      required this.description});

  final int id;
  final String title;
  final String description;
  final int level;
  final String post;
  final String division;
  final String branch;
  final String dutystation;

  @override
  String toString() => "$title (id=$id)";

  Post.fromMap(Map snapshot, int id)
      : id = id,
        title = snapshot['title'] ?? '',
        level = snapshot['level'] ?? '',
        post = snapshot['post'] ?? '',
        division = snapshot['division'] ?? '',
        branch = snapshot['branch'] ?? '',
        dutystation = snapshot['dutystation'] ?? '',
        description = snapshot['description'] ?? '';
}
