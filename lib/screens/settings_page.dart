import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/app_theme_data.dart';
import 'package:language_learning_app/manager/local_notify_manager.dart';
import 'package:language_learning_app/provider/theme_manager.dart';
import 'package:language_learning_app/screens/wiredash_page.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ayarlar",
          style: TextStyle(fontSize: 25),
        ),
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 20, right: 16),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(
                  Icons.ac_unit,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Genel",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Dil Değiştir", style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () => Navigator.pushNamed(context, "/levelPage"),
                child: Text("Seviye Değiştir", style: TextStyle(fontSize: 20))),
            Row(
              children: [
                Text("Gece Modu", style: TextStyle(fontSize: 20)),
                Padding(
                  padding: EdgeInsets.only(left: 140, top: 8),
                  child: Container(
                    height: 40,
                    child: LiteRollingSwitch(
                      value: false,
                      textOn: 'active',
                      textOff: 'inactive',
                      colorOn: Colors.greenAccent,
                      colorOff: Colors.redAccent,
                      iconOn: Icons.lightbulb_outline,
                      iconOff: Icons.power_settings_new,
                      onChanged: (bool state) {
                        if (state) {
                          theme.setTheme(AppTheme.Dark);
                        } else {
                          theme.setTheme(AppTheme.Light);
                        }
                        print('turned ${(state) ? 'on' : 'off'}');
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Alıştırma Hatırlatması", style: TextStyle(fontSize: 20)),
                Padding(
                  padding: EdgeInsets.only(left: 50, top: 8),
                  child: Container(
                    height: 40,
                    child: LiteRollingSwitch(
                      value: false,
                      textOn: 'active',
                      textOff: 'inactive',
                      colorOn: Colors.greenAccent,
                      colorOff: Colors.redAccent,
                      iconOn: Icons.lightbulb_outline,
                      iconOff: Icons.power_settings_new,
                      onChanged: (bool state) {
                        if (state) {
                          final Notifications noti = new Notifications();
                          noti.init();
                          noti.scheduleDailyTenAMNotification();
                        } else {
                          // theme.setTheme(AppTheme.Light);
                        }
                        print('turned ${(state) ? 'on' : 'off'}');
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              // height: 40,
              child: Row(
                children: [
                  Text(
                    "Motivasyon Mesajları",
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 55, top: 8),
                    child: Container(
                      height: 40,
                      child: LiteRollingSwitch(
                        value: true,
                        textOn: 'active',
                        textOff: 'inactive',
                        colorOn: Colors.greenAccent,
                        colorOff: Colors.redAccent,
                        iconOn: Icons.lightbulb_outline,
                        iconOff: Icons.power_settings_new,
                        onChanged: (bool state) {
                          print('turned ${(state) ? 'on' : 'off'}');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Destek",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              "Gizlilik Politikası",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WiredashExampleApp()));
              },
              child: Text(
                "Bize Ulaşın",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Center(
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {},
                child: Text("SIGN OUT",
                    style: TextStyle(
                        fontSize: 16, letterSpacing: 2.2, color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
