import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:language_learning_app/api/users_api.dart';
import 'package:language_learning_app/provider/auth_manager.dart';
import 'package:language_learning_app/screens/my_entotr_dictionary_page.dart';
import 'package:language_learning_app/screens/my_trtoen_dictionary_page.dart';

import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:translator/translator.dart';

class DictionaryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DictionaryPagePageState();
  }
}

class DictionaryPagePageState extends State<DictionaryPage> {
  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  TextEditingController _controller;
  //String _initialValue;
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'en',
      'label': 'İngilizce-Türkçe',
      //'icon': Icon(Icons.stop),
    },
    {
      'value': 'tr',
      'label': 'Türkçe-İngilizce',
      //'icon': Icon(Icons.fiber_manual_record),
      // 'textStyle': TextStyle(color: Colors.red),
    },
  ];

  @override
  void initState() {
    super.initState();

    //_initialValue = 'starValue';
    _controller = TextEditingController();

    _getValue();
  }

  /// This implementation is just to simulate a load data behavior
  /// from a data base sqlite or from a API
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = 'circleValue';
        _controller?.text = 'circleValue';
      });
    });
  }

  GoogleTranslator translator = GoogleTranslator();
  GoogleTranslator translator2 = GoogleTranslator();

  String out = "";
  String out2 = "";
  final langController = TextEditingController(); //getting text

  void translateToTr() async {
    translator
        .translate(langController.text, to: 'tr') //translating to hi = hindi
        .then((outp) {
      setState(() {
        out = outp
            .toString(); //placing the translated text to the String to be used
      });
      print(out);
    });
  }

  void translateToEn() async {
    translator2
        .translate(langController.text, from: 'tr', to: 'en')
        .then((outp) {
      setState(() {
        out = outp.toString();
      });
      print(out);
    });
  }

  var formKey = GlobalKey<FormState>();
  bool isSuccess;
  String displayName;
  String selectedKey;
  int _value = 1;
  List<String> keys = <String>[
    'İngilizce-Türkçe Sözlük',
    'Türkçe-İngilizce Sözlük',
  ];
  void dispose() {
    langController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthManager authManager = Provider.of<AuthManager>(context);
    return Scaffold(
      appBar: AppBar(title: Text(""), actions: [
        DropdownButton(
          // value: _value,
          underline: SizedBox(),
          items: [
            DropdownMenuItem(
              child: Text("İngilizce - Türkçe Sözlük"),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text("Türkçe-İngilizce Sözlük"),
              value: 2,
            ),
          ],
          onChanged: (value) {
            setState(() {
              _value = value;
            });
            if (_value == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyEnToTrDictionaryPage()));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyTrToEnDictionaryPage()));
            }
          },
          icon: Icon(
            Icons.book,
            color: Colors.white,
            size: 30,
          ),
        ),

        /*  DropDown<String>(
                        items: <String>["Male", "Female", "Other"],
                        initialValue: "Female",
                        hint: Text("Select gender"),
                        onChanged: print,
                        customWidgets: [
                          Icon(
                            Icons.settings,
                            color: Colors.green,
                            size: 30,
                          ),
                        ],
                      ),*/
      ]),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Form(
          key: _oFormKey,
          child: Column(
            children: <Widget>[
              SelectFormField(
                //type: SelectFormFieldType.dialog,
                controller: _controller,
                //initialValue: _initialValue,
                icon: Icon(Icons.translate_outlined),
                labelText: 'Dil Seçin',
                changeIcon: true,
                dialogTitle: 'Pick a item',
                dialogCancelBtn: 'CANCEL',
                enableSearch: true,
                dialogSearchHint: 'Search item',
                items: _items,
                onChanged: (val) => setState(() => _valueChanged = val),
                validator: (val) {
                  setState(() => _valueToValidate = val ?? '');
                  return null;
                },
                onSaved: (val) => setState(() => _valueSaved = val ?? ''),
              ),
              SizedBox(height: 20),
              // SelectableText(_valueChanged),
              Container(
                margin: EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Column(children: <Widget>[
                  TextField(
                    controller: langController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Lütfen Kelime Girin",
                      //labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    color: Colors.blueGrey,
                    child: Text("Translate !!"),
                    onPressed: () {
                      // print(_valueChanged);
                      if (_valueChanged == "tr") {
                        translateToEn();
                      } else if (_valueChanged == "en") {
                        translateToTr();
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 60,
                      width: 400,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      // color: Colors.orange[100],
                      child: Center(child: Text(out.toString())))
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.blueGrey,
                child: Text("Sözlüğüme Ekle"),
                onPressed: () {
                  UsersApi.addUserDictionary(
                      _valueChanged, langController.text, out, authManager);
                },
              ),
              /*  SelectableText(_valueChanged),
                          SizedBox(height: 30),
                          SelectableText(_valueToValidate),
                          SizedBox(height: 30),
                          SelectableText(_valueSaved),
                          SizedBox(height: 30),*/
            ],
          ),
        ),
      ),
    );
  }

  navigate() {}
}
