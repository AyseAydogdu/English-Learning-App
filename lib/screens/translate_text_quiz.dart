import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';

class TranslateText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TranslateTextState();
  }
}

class TranslateTextState extends State {
  final TextEditingController textController = TextEditingController();
  int a = 0;
  var formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Container(
              height: 70,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blueGrey,
              ),
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(50),
              child: Center(
                child: Text(
                  "it is a green apple",
                  style: TextStyle(fontSize: 30),
                ),
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
                        return alert(context,
                            title: Text('Üzgünüz yanlış cevap'));
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
    if (textController.text == "o yesil bir elma") {
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
