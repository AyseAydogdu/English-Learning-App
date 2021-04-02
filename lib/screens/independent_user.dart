import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/api/category_api.dart';
import 'package:language_learning_app/models/categories.dart';
import 'package:language_learning_app/provider/data.dart';
import 'package:provider/provider.dart';

class IndependentUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IndependentUserState();
  }
}

class IndependentUserState extends State<IndependentUser> {
  @override
  void initState() {
    Data cartProvider = Provider.of<Data>(context, listen: false);
    CategoryApi.getCategoriesOrta(cartProvider);
    super.initState();
  }
  /*void initState() {
    
  }*/

  //final databaseReference = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final Data cartProvider = Provider.of<Data>(context);

    List<Categories> categories = cartProvider.categoryList;
    return Scaffold(
        body: cartProvider != null
            ? ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      subtitle: Text(categories[index].name),
                      title: Image.network(categories[index].imageUrl)
                      // subtitle: Text(cartProvider.categoryList[index].category),
                      );
                },
                itemCount: categories.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.black,
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              )
        //onRefresh: _refreshList,
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
        );
  }

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
}
