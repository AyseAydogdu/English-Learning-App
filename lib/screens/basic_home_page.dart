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
    final Data categoryProvider = Provider.of<Data>(context, listen: false);
    CategoryApi.getCategoriesKolay(categoryProvider);
    //List<Categories> categories = cartProvider.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Data categoryProvider = Provider.of<Data>(context);

    // CategoryApi.getCategoriesKolay(cartProvider);

    Future<void> _refreshList() async {
      CategoryApi.getCategoriesKolay(categoryProvider);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Kategoriler"),
        ),
        body: new RefreshIndicator(
          child: categoryProvider != null
              ? ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    category = categoryProvider.categoryList[index];
                    return InkWell(
                      onTap: () {
                        //   categoryProvider.setCurrentCategories(category);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PartsPage(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            height: 150,
                            width: 200,
                            child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(category.imageUrl)),
                          ),
                          Container(child: Center(child: Text(category.name))),
                        ],
                      ),
                    );
                  },
                  itemCount: categoryProvider.categoryList.length,
                  /*  separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.black,
                );
              },*/
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          onRefresh: _refreshList,
        ));
  }
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
