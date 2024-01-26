import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudyRecord extends StatefulWidget{
  @override
  _StudyRecordState createState() => _StudyRecordState();
}

class _StudyRecordState extends State<StudyRecord>{
  Timer _timer;
  DateTime _time;

  @override
  void initState(){
    _time = DateTime.utc(0, 0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text (
              DateFormat.Hms().format(_time),
              style: const Theme.of(context).textTheme.headline2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () { // Stopボタンタップ時の処理
                    if (_timer != null && _timer.isActive) _timer.cancel();
                  },
                  child: Text("Stop"),
                ),
                FloatingActionButton(
                  onPressed: (){
                    _timer = Timer.periodic(
                      Duration(seconds: 1),
                      (Timer timer) => setState(() {
                        _time = _time.add(Duration(seconds: 1));
                      })
                    );
                  },
                  child: Text("Start"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}