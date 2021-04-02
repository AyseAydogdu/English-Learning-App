import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/models/categories.dart';
import 'package:language_learning_app/provider/data.dart';
import 'package:language_learning_app/screens/parts.dart';
import 'package:provider/provider.dart';
import 'package:language_learning_app/api/category_api.dart';

class BasicHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BasicHomePageState();
  }
}

/* void getData() {
    final Data cartProvider = Provider.of<Data>(context);
   

   
  }*/

class BasicHomePageState extends State {
  List<Categories> categories = [];
  Categories category;
  @override
  void initState() {
    final Data cartProvider = Provider.of<Data>(context, listen: false);
    CategoryApi.getCategoriesKolay(cartProvider);
    //List<Categories> categories = cartProvider.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Data cartProvider = Provider.of<Data>(context);

    // CategoryApi.getCategoriesKolay(cartProvider);

    Future<void> _refreshList() async {
      CategoryApi.getCategoriesKolay(cartProvider);
    }

    return Scaffold(
        body: new RefreshIndicator(
      child: cartProvider != null
          ? ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                category = cartProvider.categoryList[index];
                return InkWell(
                  onTap: () {
                    cartProvider.setCurrentCategories(category);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PartsPage(),
                        ));
                  },
                  child: ListTile(
                      subtitle: Text(category.name),
                      title: Image.network(category.imageUrl)
                      // subtitle: Text(cartProvider.categoryList[index].category),
                      ),
                );
              },
              itemCount: cartProvider.categoryList.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.black,
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      onRefresh: _refreshList,
      /*StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("kolay").snapshots(),
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
    ));
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

Widget buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    scrollDirection: Axis.vertical,
    padding: EdgeInsets.only(top: 20.0),
    children: snapshot
        .map(
          (data) => InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/parts");
            },
            child: ListTile(
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
          ),
        )
        .toList(),
  );
}
