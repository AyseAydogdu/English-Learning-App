import 'package:flutter/material.dart';
import 'package:language_learning_app/api/funapi.dart';
import 'package:language_learning_app/models/categories.dart';
import 'package:language_learning_app/models/proverbs.dart';
import 'package:language_learning_app/provider/data.dart';
import 'package:language_learning_app/provider/fundata.dart';
import 'package:language_learning_app/screens/parts.dart';
import 'package:provider/provider.dart';
import 'package:language_learning_app/api/category_api.dart';

class ProverbPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProverbPageState();
  }
}

class ProverbPageState extends State {
  //List<Proverbs> proverbs = [];
  Proverbs proverb;
  @override
  void initState() {
    final FunData funProvider = Provider.of<FunData>(context, listen: false);
    FunApi.getProverbs(funProvider);
    //List<Categories> categories = cartProvider.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FunData funProvider = Provider.of<FunData>(context);

    // CategoryApi.getCategoriesKolay(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Atasözleri"),
      ),
      body: funProvider != null
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                //scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: funProvider.proverbsList.length,
                //funProvider.proverbsList.length,
                itemBuilder: (BuildContext context, int index) {
                  proverb = funProvider.proverbsList[index];

                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                            color: Colors.orange[200],
                            //decoration: BoxDecoration(
                            //    borderRadius: BorderRadius.circular(15)),
                            child: Text(proverb.proverb,
                                style: TextStyle(fontSize: 15))),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            color: Colors.pink[200],
                            child: Text(
                              proverb.translation,
                              style: TextStyle(fontSize: 15),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            color: Colors.brown[200],
                            child: Text(proverb.meaning,
                                style: TextStyle(fontSize: 15))),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      /*  persistentFooterButtons: <Widget>[
        new RaisedButton(
          child: Text("İlerle"),
          onPressed: () {
            Navigator.pushNamed(context, "/proverb");
          },
        ),
      ],*/
    );
  }
}
