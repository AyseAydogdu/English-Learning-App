import 'package:firebase_storage/firebase_storage.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:language_learning_app/screens/settings_page.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
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
  /* Future uploadPic(BuildContext context) async{
      String fileName = basename(imageFile.path);
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child(fileName);
       //StorageReference firebaseStorageRef = firebase_storage.instance.ref().child(fileName);
       firebase_storage.UploadTask uploadTask= ref.putFile(imageFile);
       //StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
        return Future.value(uploadTask);
       //StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
       setState(() {
          print("Profile Picture uploaded");
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
       });
    }*/
  /* Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(imageFile.path);
    firebase_storage.FirebaseStorage storage =
  firebase_storage.FirebaseStorage.instance;
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }*/

  /* _openGallery(BuildContext context) async{
    var picture =  await ImagePicker.(source: ImageSource.gallery);
    this.setState((){
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async{
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    

    var picture =  await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }*/

  final TextEditingController emailController2 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final TextEditingController nameController2 = TextEditingController();
  final TextEditingController surnameController2 = TextEditingController();
  var formKey = GlobalKey<FormState>();
  getUsers() {
    FirebaseFirestore.instance.collection("users").doc().get().then((value) {
      setState(() {
        ad = value.data()["name"];
        soyad = value.data()["surname"];
        mail = value.data()["mail"];
        sifre = value.data()["password"];
        nameController2.text = ad;
        surnameController2.text = soyad;
        emailController2.text = mail;
        passwordController2.text = sifre;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    /*   Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: (imageFile != null)
                              ? Image.file(imageFile)
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("images/avatar.png"))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()),
                              );
                            },
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        )),*/
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
                            labelText: "name",
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
                            labelText: soyad,
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
                            labelText: mail,
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
                            labelText: sifre,
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
              //buildTextField("Full Name", ad + " " + soyad, false),
              //buildTextField("E-mail", mail, false),
              //buildTextField("Password", sifre, true),
              // buildTextField("Location", "Turkey", false),

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
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc("0")
                          .update({
                        "name": nameController2.text,
                        "surname": surnameController2.text,
                        "mail": emailController2.text,
                        "password": passwordController2.text,
                      });
                    },
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
