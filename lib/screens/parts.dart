import 'package:flutter/material.dart';
import 'package:language_learning_app/api/category_api.dart';
import 'package:language_learning_app/models/categories.dart';
import 'package:language_learning_app/provider/data.dart';
import 'package:provider/provider.dart';

class PartsPage extends StatefulWidget {
  Categories category;

  @override
  State<StatefulWidget> createState() {
    return PartsPageState();
  }
}

class PartsPageState extends State {
  Categories category;

  @override
  void initState() {
    //  Data cartProvider = Provider.of<Data>(context, listen: false);
    //  CategoryApi.getSubjects(cartProvider, category.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Data cartProvider = Provider.of<Data>(context);

    List<Categories> categories = cartProvider.categoryList;
    return Scaffold(
      appBar: AppBar(
        title: Text("Alıştırmalar"),
      ),
      body: ListView(
        children: [
          Center(
            child: InkWell(
              onTap: () {
                // cartProvider.setCurrentCategories(categories[index]);
                Navigator.pushNamed(context, "/dragDrop");
              },
              //
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 200,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/surukle.jpg"),
                    ),
                  ),
                  Text(
                    "Eşleştirme",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/translateText");
              },
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 200,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/text.png"),
                    ),
                  ),
                  Text("Metin çevirme",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/tts");
              },
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 200,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/dinleme.jpg"),
                    ),
                  ),
                  Text("Dinle ve Yaz",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/gapF");
              },
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 200,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/fillgaps.jpg"),
                    ),
                  ),
                  Text("Boşluk Doldurma",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
