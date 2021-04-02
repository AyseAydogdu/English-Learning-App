import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/models/rigmarole.dart';
import 'package:language_learning_app/provider/auth_manager.dart';
import 'package:language_learning_app/provider/data.dart';
import 'package:language_learning_app/provider/dictionary_manager.dart';
import 'package:language_learning_app/provider/fundata.dart';
import 'package:language_learning_app/provider/theme_manager.dart';
import 'package:language_learning_app/screens/basic_user_page.dart';
import 'package:language_learning_app/screens/drag_drop.dart';
import 'package:language_learning_app/screens/gap_filling.dart';
import 'package:language_learning_app/screens/independent_user.dart';
import 'package:language_learning_app/screens/level_page.dart';
import 'package:language_learning_app/screens/login_page.dart';
import 'package:language_learning_app/screens/parts.dart';
import 'package:language_learning_app/screens/proficient_user.dart';
import 'package:language_learning_app/screens/proverb_page.dart';
import 'package:language_learning_app/screens/rigmarole_page.dart';
import 'package:language_learning_app/screens/scratcher.dart';
import 'package:language_learning_app/screens/selection_page.dart';
import 'package:language_learning_app/screens/stt.dart';
import 'package:language_learning_app/screens/text_iki.dart';
import 'package:language_learning_app/screens/translate_text_quiz.dart';
import 'package:language_learning_app/screens/tts.dart';

import 'package:language_learning_app/shared_pref.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> main() async {
  //await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();

  await firebase_core.Firebase.initializeApp();
  SharedPrefs.initialize();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => Data(),
    ),
    ChangeNotifierProvider(
      create: (context) => FunData(),
    ),
    ChangeNotifierProvider(
      create: (context) => ThemeManager(),
    ),
    ChangeNotifierProvider(
      create: (context) => AuthManager(),
    ),
    ChangeNotifierProvider(
      create: (context) => DictionaryManager(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool newUserStatus;
  String newmail;
  SharedPreferences loginData;
  @override
  void initState() {
    checkLogin();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeManager theme = Provider.of<ThemeManager>(context);
    return MaterialApp(
      title: 'Language App',
      theme: theme.themeData,
      home: Consumer<AuthManager>(
        builder: (context, notifier, child) {
          return notifier.user != null ? LevelPage() : LoginPage();
        },
      ),
      routes: {
        //"/": (context) => newUserStatus ? LevelPage() : LoginPage(),
        "/selectionPage": (context) => SelectionPage(),
        "/levelPage": (context) => LevelPage(),
        "/Kolay": (context) => BasicUserPage(),
        "/Orta": (context) => IndependentUser(),
        "/İleri": (context) => ProficientUser(),
        // "/parts": (context) => PartsPage(),
        "/dragDrop": (context) => DragDrop(),
        "/translateText": (context) => TranslateText(),
        "/textiki": (context) => TextIki(),
        "/tts": (context) => Tts(),
        "/stt": (context) => SpeechScreen(),
        "/gapF": (context) => GapFilling(),
        "/kazıkazan": (context) => KaziKazan(),
        "/basicPage": (context) => BasicUserPage(),
        "/proverb": (context) => ProverbPage(),
        "/rigmarole": (context) => RigmarolePage(),
        //"/stories": (context) => StoryPage(0),
      },
    );
  }

  checkLogin() async {
    loginData = await SharedPreferences.getInstance();
    //  newUserStatus = (loginData.getBool('login') ?? true);
    newmail = loginData.getString("email");
    newUserStatus = loginData.getBool('login');
    /* if (loginData.getBool('login')) {
      Navigator.pushNamed(context, "/levelPage");
    }*/
  }
}
