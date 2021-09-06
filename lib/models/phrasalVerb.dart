class PhrasalVerb {
  String name;
  String mean;
  PhrasalVerb.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    mean = data['mean'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mean': mean,
    };
  }
}
