import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/api/category_api.dart';
import 'package:language_learning_app/models/categories.dart';
import 'package:language_learning_app/models/subjects.dart';
import 'package:language_learning_app/provider/data.dart';
import 'package:provider/provider.dart';

class GapFilling extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GapFillingState();
  }
}

class GapFillingState extends State {
  @override
  void initState() {
    Data cartProvider = Provider.of<Data>(context, listen: false);
    Categories categories = cartProvider.getCurrentCategories();
    CategoryApi.getSubjects(cartProvider, categories.name);
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController textController = TextEditingController();
  int a = 0;
  var formKey2 = GlobalKey<FormState>();
  String cumle = "";
  String cumle2 = "they are _____balloons";
  @override
  Widget build(BuildContext context) {
    final Data cartProvider = Provider.of<Data>(context);
    Subjects subjects = cartProvider.getSubjects();
    return Scaffold(
      appBar: AppBar(
          //  title: Text(subjects.sentence[0]),
          ),
      body: Column(children: [
        Container(
            height: 100,
            width: 1200,
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.all(30),
            color: Colors.white10,
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueGrey,
                    ),
                    height: 70,
                    width: 70,
                    child: Image.asset("images/mavibalon.jpg")),
                Text(
                  cumle2,
                  style: TextStyle(fontSize: 25),
                ),
              ],
            )),
        SizedBox(
          height: 40,
        ),
        Container(
          margin: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: ButtonTheme(
                    child: ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              cumle2 = "they are red balloons";
                            });
                          },
                          child: Text('red'),
                          color: Color(0xff2FBBF0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              cumle2 = subjects.sentence[0].toString();
                            });
                          },
                          child: Text('blue'),
                          color: Color(0xff2FBBF0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              cumle2 = "they are purple balloons";
                            });
                          },
                          child: Text('purple'),
                          color: Color(0xff2FBBF0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              cumle2 = "they are yellow balloons";
                            });
                          },
                          child: Text('yellow'),
                          color: Color(0xff2FBBF0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
            child: RaisedButton(
          child: Text("Kontrol Et"),
          onPressed: () {
            //print(textController.text);
            kontrol(subjects.sentence[0]);
            if (a == 1) {
              // ilerle();
              return alert(context, title: Text('Tebrikler doğru'));
            } else {
              return alert(context, title: Text('Üzgünüz yanlış'));
            }
            // Navigator.pushNamed(context, "/");*/
          },
        )),
        SizedBox(
          height: 10,
        ),
      ]),
      persistentFooterButtons: <Widget>[
        new RaisedButton(
          child: Text("İlerle"),
          onPressed: () {
            Navigator.pushNamed(context, "/textiki");
          },
        ),
      ],
    );
  }

  kontrol(String cumle3) {
    if (cumle2 == cumle3) {
      a = 1;

      // print(textController.text.toString());
    }
  }

  Widget ilerle() {
    return RaisedButton(
      child: Text("aa"),
      onPressed: () {},
    );
  }
}
