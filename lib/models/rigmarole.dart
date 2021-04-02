class Rigmaroles {
  String rigmarole;

  Rigmaroles.fromMap(Map<String, dynamic> data) {
    rigmarole = data['rigmarole'];
  }

  Map<String, dynamic> toMap() {
    return {
      'rigmarole': rigmarole,
    };
  }
}
