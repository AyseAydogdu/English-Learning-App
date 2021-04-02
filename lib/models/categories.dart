class Categories {
  String name;
  String imageUrl;
  Categories.fromMap(Map<String, dynamic> data) {
    name = data['name'];

    imageUrl = data['imageUrl'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}
