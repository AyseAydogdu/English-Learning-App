import 'package:flutter/material.dart';
import 'package:language_learning_app/screens/basic_home_page.dart';
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
    /// The `Wiredash` widget wraps the top level application widget.
    ///
    /// `Wiredash` requires the `Project ID` and the `API Key` obtained from the
    /// "Settings" tab of the console.
    /// The navigator key is also required to be able to show the overlay.
    /// `_navigatorKey` is assigned to both `Wiredash` and `MaterialApp`.
    /// Note: you are not required to use `MaterialApp`,
    /// Wiredash will work just as well with `CupertinoApp` and `WidgetsApp`.
    ///
    /// Wiredash also allows you to set custom themes using `WiredashThemeData`.
    /// The behaviour as well as the locale and translations can be customized
    /// using `WiredashOptionsData`.
    /// Both of these are optional but they enable you to make Wiredash your
    /// own.
    /// Read more about translations support in the package's README.
    return Wiredash(
      projectId: "learning-language-app-jcpxsri",
      secret: "t9rwnvhk69efgz7enns5ozbyo1rtael4iqvsb4c4z8um851k",
      navigatorKey: _navigatorKey,
      options: WiredashOptionsData(
        /// Change the locale of the Wiredash UI
        locale: Locale('en'),

        /// Uncomment below to disable the screenshot step
        // screenshotStep: false,

        /// Uncomment below to disable different buttons
        // bugReportButton: false,
        // featureRequestButton: false,
        // praiseButton: false,

        /// Uncomment below to set custom translations work
        // customTranslations: {
        //   const Locale.fromSubtags(languageCode: 'en'):
        //       const CustomDemoTranslations(),
        // },

        /// Uncomment below to override the default device locale
        // and/or text direction
        // locale: const Locale('de'),
        // textDirection: TextDirection.rtl,
      ),
      theme: WiredashThemeData(

          /// Uncomment below to explore the various theme options:

          /// Customize the Font Family
          // fontFamily: 'Monospace',

          /// Customize the Bottom Sheet Border Radius
          // sheetBorderRadius: BorderRadius.zero,

          /// Customize Brightness and Colors
          // brightness: Brightness.light,
          // primaryColor: Colors.red,
          // secondaryColor: Colors.blue,

          /// Customize the Pen Colors
          /// Note: If you change the Pen Colors, please consider providing
          /// custom translations to the WiredashOptions to ensure the app is
          /// accessible to all. The default translations describe the default
          /// pen colors.
          // firstPenColor: Colors.orange,
          // secondPenColor: Colors.green,
          // thirdPenColor: Colors.yellow,
          // fourthPenColor: Colors.deepPurpleAccent,
          ),
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        home: const _HomePage(),
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wiredash Demo'),
      ),
      body: Container(child: RaisedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => (BasicHomePage()),
              ));
        },
      )),
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
