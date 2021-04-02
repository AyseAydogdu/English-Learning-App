import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/provider/auth_manager.dart';
import 'package:language_learning_app/screens/login_page.dart';
import 'package:provider/provider.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateAccountPageState();
  }
}

class CreateAccountPageState extends State<CreateAccountPage> {
  String email, password, name, surName;
  String imageUrl = 'images/avatar.png';
  int id = 0;
  bool loadState = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isSuccess;
  String displayName;

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthManager authManager = Provider.of<AuthManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account Page'),
      ),
      body: loadState
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Expanded(
                    child: Container(
                        height: 100, child: Image.asset("images/diller.jpg"))),
                Form(
                  key: formKey,
                  child: Container(
                    margin: EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              value.isEmpty ? null : 'Lütfen isim girin',
                          decoration: InputDecoration(
                            hintText: "Lütfen İsim Girin",
                            labelText: "Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _surnameController,
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              value.isEmpty ? null : 'Lütfen soyisim girin',
                          decoration: InputDecoration(
                            hintText: "Lütfen Soyisim Girin",
                            labelText: "SurName",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => value.contains('@')
                              ? null
                              : 'Gecerli email adresi yazın',
                          decoration: InputDecoration(
                            hintText: "Lütfen Email Adresi Girin",
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (value) => value.length >= 6
                              ? null
                              : 'Sifreniz en az 6 karakter olmalıdır',
                          decoration: InputDecoration(
                            hintText: "Lütfen Sifre Girin",
                            labelText: "Sifre",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            child: RaisedButton(
                          child: Text("Kaydet"),
                          onPressed: () {
                            addRecord(authManager);
                            // addPerson();

                            Navigator.pushNamed(context, "/");
                          },
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  addRecord(AuthManager authManager) async {
    final User user = (await auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      addUser(user);
      authManager.setUser(user);
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      isSuccess = false;
    }
  }

  addUser(User user) {
    name = _nameController.text;
    surName = _surnameController.text;
    email = _emailController.text;
    password = _passwordController.text;
    FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      'userId': user.uid,
      'name': name,
      'surname': surName,
      'mail': email,
      'password': password,
      'imageUrl': imageUrl,
    });
  }
}
