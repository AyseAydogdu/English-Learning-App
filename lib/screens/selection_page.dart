import 'package:flutter/material.dart';
import 'package:language_learning_app/models/language.dart';
import 'package:language_learning_app/screens/level_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SelectionPageState();
  }
}

class SelectionPageState extends State<SelectionPage> {
  List<Language> languages;
  List<Language> myLanguages;
  Language selectedLanguage;
  Language myLanguage;
  SharedPreferences selectedLanguageData;
  bool mylang, selectedlang;
  @override
  void initState() {
    super.initState();
    languages = Language.getLanguage();
    myLanguages = Language.getMyLanguage();
    // checkLanguage();
  }

  setSelectedLanguage(Language language) {
    setState(() {
      selectedLanguage = language;
      //  selectedLanguageData.setBool('select2', false);
      // selectedLanguageData.setString(
      //     'selectedLanguage', selectedLanguage.toString());
    });
  }

  setMyLanguage(Language language) {
    setState(() {
      myLanguage = language;
      // selectedLanguageData.setBool('select', false);
      // selectedLanguageData.setString('myLanguage', myLanguage.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dil Seçimi"),
      ),
      body: Column(
        children: <Widget>[
          Text(
            "Kendi Dilinizi Seçin",
            style: TextStyle(color: Colors.blueAccent, fontSize: 20),
          ),
          Column(
            children: createListMyLanguage(),
          ),
          Text(
            "Öğrenmek İstediğiniz Dili Seçin",
            style: TextStyle(color: Colors.blueAccent, fontSize: 20),
          ),
          Column(
            children: createListLanguage(),
          ),
          RaisedButton(
            child: Text("Seç"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LevelPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }

  List<Widget> createListLanguage() {
    List<Widget> widgets = [];
    for (Language language in languages) {
      widgets.add(
        RadioListTile(
          value: language,
          groupValue: selectedLanguage,
          title: Text(language.name),
          onChanged: (currentUser) {
            print("Current User ${currentUser.name}");
            setSelectedLanguage(currentUser);
          },
          selected: selectedLanguage == language,
          activeColor: Colors.green,
        ),
      );
    }
    return widgets;
  }

  List<Widget> createListMyLanguage() {
    List<Widget> widgets = [];
    for (Language language in myLanguages) {
      widgets.add(
        RadioListTile(
          value: language,
          groupValue: myLanguage,
          title: Text(language.name),
          onChanged: (currentUser) {
            print("Current User ${currentUser.name}");
            setMyLanguage(currentUser);
          },
          selected: myLanguage == language,
          activeColor: Colors.green,
        ),
      );
    }
    return widgets;
  }

  void checkLanguage() async {
    selectedLanguageData = await SharedPreferences.getInstance();
    mylang = (selectedLanguageData.getBool('select') ?? true);
    selectedlang = (selectedLanguageData.getBool('select2') ?? true);

    if (mylang == false && selectedlang == false) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => (LevelPage()),
          ));
    }
  }
}
