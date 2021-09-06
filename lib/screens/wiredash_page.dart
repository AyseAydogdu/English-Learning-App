import 'package:flutter/material.dart';
import 'package:language_learning_app/screens/basic_home_page.dart';
import 'package:language_learning_app/screens/dictionary_page.dart';
import 'package:language_learning_app/screens/fun_page.dart';
import 'package:language_learning_app/screens/parts.dart';
import 'package:wiredash/wiredash.dart';

class WiredashExampleApp extends StatefulWidget {
  const WiredashExampleApp({Key key}) : super(key: key);

  @override
  _WiredashExampleAppState createState() => _WiredashExampleAppState();
}

class _WiredashExampleAppState extends State<WiredashExampleApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: "learning-language-app-jcpxsri",
      secret: "t9rwnvhk69efgz7enns5ozbyo1rtael4iqvsb4c4z8um851k",
      navigatorKey: _navigatorKey,
      options: WiredashOptionsData(
        /// Change the locale of the Wiredash UI
        locale: Locale('en'),
      ),
      theme: WiredashThemeData(),
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        home: const _WirePage(),
      ),
    );
  }
}

class _WirePage extends StatelessWidget {
  const _WirePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bize Bildirin'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  "Gitmek İstediğiniz Sayfa İçin Seçim Yapınız",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.purple[300],
                  ),
                )),
            Center(
              child: Container(
                  margin: EdgeInsets.all(10),
                  height: 70,
                  width: 200,
                  child: RaisedButton(
                    color: Colors.green[300],
                    child: Text("Ana Sayfa"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => (BasicHomePage()),
                          ));
                    },
                  )),
            ),
            Center(
              child: Container(
                  margin: EdgeInsets.all(10),
                  height: 70,
                  width: 200,
                  child: RaisedButton(
                    color: Colors.blue[200],
                    child: Text("Eğlence Sayfası"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => (FunPage()),
                          ));
                    },
                  )),
            ),
            Center(
              child: Container(
                  margin: EdgeInsets.all(10),
                  height: 70,
                  width: 200,
                  child: RaisedButton(
                    color: Colors.purple[200],
                    child: Text("Sözlük Sayfası"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => (DictionaryPage()),
                          ));
                    },
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        /// Showing the Wiredash Dialog is as easy as calling:
        /// Wiredash.of(context).show()
        /// Since the `Wiredash` widget is at the root of the widget tree this
        /// method can be accessed from anywhere in the code.
        onPressed: Wiredash.of(context).show,
        child: Icon(Icons.feedback_outlined),
      ),
    );
  }

  void _openDetailsPage(BuildContext context, int which) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return _DetailsPage(index: which);
        },
      ),
    );
  }
}

class _DetailsPage extends StatelessWidget {
  const _DetailsPage({
    Key key,
    this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page #$index'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Details page #$index',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 8),
              const Text('Try navigating here in feedback mode.')
            ],
          ),
        ),
      ),
    );
  }
}
