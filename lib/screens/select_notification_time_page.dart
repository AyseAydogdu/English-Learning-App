import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:language_learning_app/manager/local_notify_manager.dart';

class SelectNotificationTime extends StatefulWidget {
  @override
  SelectNotificationTimeState createState() => SelectNotificationTimeState();
}

class SelectNotificationTimeState extends State<SelectNotificationTime> {
  double _height;
  double _width;

  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  // TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;

        // _timeController.text =
        //     TimeOfDay(hour: selectedTime.hour, minute: selectedTime.minute)
        //        .toString();
      });
  }

  @override
  void initState() {
    //   selectedTime = TimeOfDay(hour: 00, minute: 00);
    //  _dateController.text = DateFormat.yMd().format(DateTime.now());
    _timeController.text = "00:00";
    //_timeController.text = TimeOfDay(hour: 00, minute: 00).toString();
    // _timeController.text =
    //    DateTime(DateTime.now().hour, DateTime.now().minute).toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bildirim Zamanı'),
      ),
      body: Container(
        width: _width,
        height: _height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Zaman Seçin',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.purple[300],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: _width / 2,
                    height: _height / 9,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      // initialValue: time,
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      onSaved: (String val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeController,
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  child: Text("Kaydet"),
                  onPressed: () {
                    // _selectTime(context);
                    final Notifications noti = new Notifications();
                    noti.init();
                    noti.scheduleDailyNotification(_hour, _minute);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
