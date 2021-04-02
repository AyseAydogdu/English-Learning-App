import 'package:flutter/material.dart';
import 'package:language_learning_app/api/users_api.dart';
import 'package:language_learning_app/models/dictionary.dart';
import 'package:language_learning_app/provider/auth_manager.dart';
import 'package:language_learning_app/provider/dictionary_manager.dart';
import 'package:provider/provider.dart';

class MyTrToEnDictionaryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyTrToEnDictionaryPageState();
  }
}

class MyTrToEnDictionaryPageState extends State {
  List<Dictionary> DictionaryList = [];
  Dictionary dictionary;
  String language = "tr";
  @override
  void initState() {
    final DictionaryManager dictionaryManager =
        Provider.of<DictionaryManager>(context, listen: false);
    final AuthManager authManager =
        Provider.of<AuthManager>(context, listen: false);
    UsersApi.getUserDictionary(authManager, dictionaryManager, language);
    //List<Categories> categories = cartProvider.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DictionaryManager dictionaryManager =
        Provider.of<DictionaryManager>(context, listen: true);

    // CategoryApi.getCategoriesKolay(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Atasözleri"),
      ),
      body: dictionaryManager != null
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                //scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: dictionaryManager.dictionaryList.length,
                //funProvider.proverbsList.length,
                itemBuilder: (BuildContext context, int index) {
                  dictionary = dictionaryManager.dictionaryList[index];

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
                            child: Row(
                              children: [
                                Text(dictionary.name,
                                    style: TextStyle(fontSize: 15)),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  dictionary.translatedName,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            )),
                      ],
                    ),
                  );
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
