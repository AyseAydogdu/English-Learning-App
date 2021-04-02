import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/api/users_api.dart';
import 'package:language_learning_app/provider/auth_manager.dart';
import 'package:language_learning_app/screens/create_account_page.dart';
import 'package:language_learning_app/screens/level_page.dart';
import 'package:language_learning_app/screens/selection_page.dart';
import 'package:language_learning_app/shared_pref.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthMode { Signup, Login }

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  String email, password;
  bool loadState = false;
  AuthMode _authMode;
  final TextEditingController _emailController = TextEditingController();
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  SharedPreferences loginData;
  //SharedPreferences levelData;
  bool newUserStatus;
  String newmail;
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    AuthManager authNotifier = Provider.of<AuthManager>(context, listen: false);
    UsersApi.initializeCurrentUser(authNotifier);
    super.initState();

    //  checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    final AuthManager authManager = Provider.of<AuthManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: loadState
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Colors.green[200],
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.all(16),
                        child: Image.asset("images/diller.jpg")),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Form(
                        key: formKey,
                        child: Container(
                          margin: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
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
                                textColor: Colors.white,
                                child: Text('Giriş Yap'),
                                onPressed: () async {
                                  if (formKey.currentState.validate()) {
                                    signInWithEmailAndPassword(authManager);
                                    Navigator.pushNamed(context, "/levelPage");
                                  }
                                },
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: InkWell(
                                  child: Text(
                                    'Hesabınız yok mu?',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.indigo),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CreateAccountPage(),
                                        ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
    );
  }

  void signInWithEmailAndPassword(AuthManager authManager) async {
    try {
      var firebaseUser = await auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (!firebaseUser.user.emailVerified) {
        await firebaseUser.user.sendEmailVerification();
      }
      authManager.setUser(firebaseUser.user);

      setState(() {
        _authMode = AuthMode.Login;
        SharedPrefs.saveMail(email);
        //SharedPrefs.saveMail();
        // loginData.setBool('login', true);
        // loginData.setString('email', email);
      });
    } catch (e) {
      Text("Failed to sign in with Email & Password");
    }
  }

  /* void checkLogin() async {
    loginData = await SharedPreferences.getInstance();
    newUserStatus = (loginData.getBool('login') ?? true);
    newmail = loginData.getString("email");
    if (newUserStatus == false) {
      Navigator.pushNamed(context, "/levelPage");
    }
  }*/

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
