import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/models/users.dart';

class UserManager with ChangeNotifier {
  Users _users;

  Users get user => _users;

  void setUser(Users user) {
    _users = user;
    notifyListeners();
  }

  void setCurrentUser(Users user) {
    _users = user;
    notifyListeners();
  }
}
