import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:language_learning_app/api/users_api.dart';
import 'package:language_learning_app/models/users.dart';
import 'package:language_learning_app/provider/auth_manager.dart';
import 'package:language_learning_app/provider/fundata.dart';
import 'package:language_learning_app/provider/user_manager.dart';

import 'package:language_learning_app/screens/basic_home_page.dart';
import 'package:language_learning_app/screens/settings_page.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  bool showPassword = false;
  String ad, soyad, mail, sifre;
  bool loadState = false;
  File imageFile;
  final picker = ImagePicker();

  Future takePhoto(ImageSource source) async {
    var pickedFile = await picker.getImage(source: source);

    setState(() {
      imageFile = File(pickedFile.path);
    });
    uploadPic();
  }

/*uploadFirebase(AuthManager authManager)async
{
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authManager.user.uid)
        .collection("dictionary$valueC")
        .doc()
        .set({"name": });
}*/
  Future uploadPic() async {
    //String fileName = basename(imageFile.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("users").child("profile");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile);

    //StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      print("Profile Picture uploaded");
      //Scaffold.of(context)
      //    .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });
  }

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController emailController2 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final TextEditingController nameController2 = TextEditingController();
  final TextEditingController surnameController2 = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthManager authManager =
        Provider.of<AuthManager>(context, listen: true);
    final UserManager userManager =
        Provider.of<UserManager>(context, listen: true);
    UsersApi.initializeCurrentUser(authManager);
    var user = authManager.user;
    UsersApi.getUsers(user, userManager);
    Users users = userManager.user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Profil Düzenle",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: imageFile != null
                          ? FileImage(imageFile)
                          : AssetImage("images/avatar.png"),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet()),
                          );
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: Form(
                  key: formKey,
                  child: Container(
                    margin: EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: nameController2,
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              value.isEmpty ? null : 'Lütfen isim girin',
                          decoration: InputDecoration(
                            hintText: "Name",
                            labelText: users.name,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: surnameController2,
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              value.isEmpty ? null : 'Lütfen soyisim girin',
                          decoration: InputDecoration(
                            hintText: "Lütfen Soyisim Girin",
                            labelText: users.surname,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController2,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => value.contains('@')
                              ? null
                              : 'Gecerli email adresi yazın',
                          decoration: InputDecoration(
                            hintText: "Lütfen Email Adresi Girin",
                            labelText: users.mail,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController2,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (value) => value.length >= 6
                              ? null
                              : 'Sifreniz en az 6 karakter olmalıdır',
                          decoration: InputDecoration(
                            hintText: "Lütfen Sifre Girin",
                            labelText: users.password,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pushNamed(context, "/basicPage");
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BasicHomePage()));
                      },
                      child: Text("CANCEL",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.black)),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.assistant_photo,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Durum",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "_____ bölüm geçtiniz",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Toplam Puanınız ______",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: 200, //MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Profil Fotoğrafı",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }
}
