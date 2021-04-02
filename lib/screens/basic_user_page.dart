import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/screens/basic_home_page.dart';
import 'package:language_learning_app/screens/dictionary_page.dart';
import 'package:language_learning_app/screens/fun_page.dart';
import 'package:language_learning_app/screens/profile.dart';

class BasicUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BasicUserPageState();
  }
}

/*
StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("categories")
            .doc("hrYrrCSHvzcAk3muCmbX")
            .collection("ozellik")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            Text("Loading");
          } else {
            return buildBody(context, snapshot.data.docs);
          }
        },
      ),




*/

class BasicUserPageState extends State {
  int selectedIndex;
  PageController pageController = PageController();
  List<Widget> screen = [
    BasicHomePage(),
    FunPage(),
    DictionaryPage(),
    ProfilePage()
  ];
  void pageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    //  getData();
    selectedIndex = 0;
  }

  final databaseReference = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: screen,
        onPageChanged: pageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      /*StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("categories").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            Text("Loading");
          } else {
            return buildBody(context, snapshot.data.docs);
          }
        },
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: selectedIndex == 0 ? Colors.teal[500] : Colors.grey,
            ),
            label: "Home",
            //backgroundColor:
            //  selectedIndex == 0 ? Colors.teal[500] : Colors.grey
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: selectedIndex == 1 ? Colors.teal[500] : Colors.grey,
              ),
              label: "Favorite",
              backgroundColor: selectedIndex == 1 ? Colors.blue : Colors.grey),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.translate,
                color: selectedIndex == 2 ? Colors.teal[500] : Colors.grey,
              ),
              label: "Dictionary",
              backgroundColor: selectedIndex == 2 ? Colors.blue : Colors.grey),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: selectedIndex == 3 ? Colors.teal[500] : Colors.grey,
              ),
              label: "Profile",
              backgroundColor: selectedIndex == 3 ? Colors.blue : Colors.grey),
        ],
        onTap: onItemTapped,
      ),
    );
  }

  /* Widget getData() {
            databaseReference
                .collection("categories")
                .doc("hrYrrCSHvzcAk3muCmbX")
                .collection("ozellik")
                .get()
                .then((QuerySnapshot snapshot) {
              snapshot.docs.forEach((f) => print('${f.data}}'));
              //buildBody(context, snapshot.docs);
            });
          }*/

  /* Widget buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 20.0),
      children: snapshot
          .map(
            (data) => ListTile(
              subtitle: Center(
                child: Text(
                  data["name"].toString(),
                  style: TextStyle(fontSize: 25, color: Colors.purple[400]),
                ),
              ),
              title: Container(
                  width: 200,
                  height: 200,
                  margin: EdgeInsets.all(16),
                  child: Image.network(data["imageUrl"])),
            ),
          )
          .toList(),
    );
  }*/

  void onItemTapped(int value) {
    pageController.jumpToPage(value);
  }
}
