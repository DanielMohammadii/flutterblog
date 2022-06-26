
class User {
  final String name;
  final String family;
  final int age;
  final DateTime createdTime;
  final String img;
  User({
    required this.name,
    required this.family,
    required this.age,
    required this.createdTime,
    required this.img,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'family': family,
        'age': age,
        'createdTime': createdTime,
        'image': img,
      };
}
