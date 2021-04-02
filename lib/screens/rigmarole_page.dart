import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:language_learning_app/api/funapi.dart';
import 'package:language_learning_app/models/rigmarole.dart';
import 'package:language_learning_app/provider/fundata.dart';
import 'package:provider/provider.dart';

class RigmarolePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RigmarolePageState();
  }
}

class RigmarolePageState extends State {
  List<Rigmaroles> rigmaroles = [];
  Rigmaroles rigmarole;
  final FlutterTts flutterTts = FlutterTts();
  String secilen;
  double rate;
  Future speak(String sentence, double rate) async {
    await flutterTts.speak(sentence);
    await flutterTts.setLanguage("en - US");
    await flutterTts.setSpeechRate(rate);
    //if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  @override
  void initState() {
    final FunData funProvider = Provider.of<FunData>(context, listen: false);
    // ignore: unnecessary_statements
    FunApi.getRigmarole(funProvider);
    //List<Categories> categories = cartProvider.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FunData funProvider = Provider.of<FunData>(context);
    //String secilen;
    // CategoryApi.getCategoriesKolay(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Tekerlemeler"),
      ),
      body: funProvider != null
          ? Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                //scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: funProvider.rigmarolesList.length,
                //funProvider.proverbsList.length,
                itemBuilder: (BuildContext context, int index) {
                  rigmarole = funProvider.rigmarolesList[index];

                  return Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 100,
                          width: 600,

                          // width: MediaQuery.of(context).size.width,
                          // color: Colors.orangeAccent,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(7),
                                  height: 60,
                                  width: 230,
                                  child: Text(rigmarole.rigmarole)),
                              Container(
                                  height: 50,
                                  width: 70,
                                  // padding: EdgeInsets.all(5),
                                  // margin: EdgeInsets.all(5),
                                  // color: Colors.blue[200],
                                  child: RaisedButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(20.0)),
                                      color: Colors.blueGrey[400],
                                      child: Text("Yavaş"),
                                      onPressed: () {
                                        setState(() {
                                          rate = 1.0;
                                          secilen = funProvider
                                              .rigmarolesList[index].rigmarole;
                                        });
                                        speak(secilen, rate);
                                      })),
                              SizedBox(width: 5),
                              Container(
                                  height: 50,
                                  width: 65,
                                  //  padding: EdgeInsets.all(8),
                                  //  margin: EdgeInsets.all(5),
                                  // color: Colors.blue[200],
                                  child: RaisedButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(20.0)),
                                      color: Colors.blueGrey[400],
                                      child: Text("Hızlı"),
                                      onPressed: () {
                                        setState(() {
                                          rate = 3.0;
                                          secilen = funProvider
                                              .rigmarolesList[index].rigmarole;
                                        });
                                        speak(secilen, rate);
                                      })),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
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
