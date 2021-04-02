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
    Data cartProvider = Provider.of<Data>(context, listen: false);
    CategoryApi.getSubjects(cartProvider, category.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Data cartProvider = Provider.of<Data>(context);

    List<Categories> categories = cartProvider.categoryList;
    return Scaffold(
        appBar: AppBar(
          title: Text(categories[0].name),
        ),
        body: Container(
          // height: 800,
          width: 500,
          child: ListView(
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    // cartProvider.setCurrentCategories(categories[index]);
                    Navigator.pushNamed(context, "/dragDrop");
                  },
                  //
                  child: Container(
                    height: 150,
                    width: 200,
                    child: CircleAvatar(
                      child: Text(
                        "Eşleştirme",
                        style: TextStyle(fontSize: 25, color: Colors.black87),
                      ),
                      backgroundImage: AssetImage("images/surukle.jpg"),
                    ),
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
                  child: Container(
                    height: 150,
                    width: 200,
                    child: CircleAvatar(
                      child: Text("Metin çevirme",
                          style:
                              TextStyle(fontSize: 25, color: Colors.black87)),
                      backgroundImage: AssetImage("images/text.png"),
                    ),
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
                  child: Container(
                    height: 150,
                    width: 200,
                    child: CircleAvatar(
                      child: Text("Dinle ve Yaz",
                          style:
                              TextStyle(fontSize: 25, color: Colors.black87)),
                      backgroundImage: AssetImage("images/dinleme.jpg"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/stt");
                  },
                  child: Container(
                    height: 150,
                    width: 200,
                    child: CircleAvatar(
                      child: Text("Konuşma Sırası Sende",
                          style:
                              TextStyle(fontSize: 25, color: Colors.black87)),
                      backgroundImage: AssetImage("images/konusma.jpg"),
                    ),
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
                  child: Container(
                    height: 150,
                    width: 200,
                    child: CircleAvatar(
                      child: Text("Boşluk Doldurma",
                          style:
                              TextStyle(fontSize: 25, color: Colors.black87)),
                      backgroundImage: AssetImage("images/fillgaps.jpg"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
