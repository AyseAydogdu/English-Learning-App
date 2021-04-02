import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Tts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TtsState();
  }
}

class TtsState extends State {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textController = TextEditingController();
  int a = 0;
  var formKey2 = GlobalKey<FormState>();
  Future speak() async {
    await flutterTts.speak("it is an apple");
    await flutterTts.setLanguage("en - US");

    //if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Container(
              height: 100,
              width: 300,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(50),
              // color: Colors.blue[200],
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                color: Colors.blueGrey[400],
                child: Text("Dinlemek için dokunun"),
                onPressed: () => speak(),
              )),
          SizedBox(
            height: 40,
          ),
          Form(
            key: formKey2,
            child: Container(
              margin: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextFormField(
                      controller: textController,
                      keyboardType: TextInputType.text,
                      validator: (value) {}, //{return kontrol(value)}

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      child: RaisedButton(
                    child: Text("Kontrol Et"),
                    onPressed: () {
                      //print(textController.text);
                      kontrol();
                      if (a == 1) {
                        // ilerle();
                        return alert(context, title: Text('Tebrikler doğru'));
                      } else {
                        return alert(context, title: Text('Üzgünüz yanlış'));
                      }
                      // Navigator.pushNamed(context, "/");*/
                    },
                  )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
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

  kontrol() {
    if (textController.text == "it is an apple") {
      a = 1;

      // print(textController.text.toString());
    }
  }

  Widget ilerle() {
    return RaisedButton(
      child: Text("aa"),
      onPressed: () {},
    );
    /*FooterView(
      children: null,
      footer: Footer(
        child: Row(
          children: [
            RaisedButton(
              onPressed: () {},
              child: Text(
                "ilerle",
              ),
            ),
            Text('yes')
          ],
        ),
        child: Text("aaa"),
      ),
    );*/
  }
}
