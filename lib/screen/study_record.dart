import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudyRecord extends StatefulWidget {
  const StudyRecord({Key? key}) : super(key: key);

  @override
  StudyRecordState createState() => StudyRecordState();
}

class StudyRecordState extends State<StudyRecord> {
  Timer? _timer;
  DateTime _time = DateTime.utc(0, 0, 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat.Hms().format(_time),
              style: Theme.of(context).textTheme.headline2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FloatingActionButton(
                  onPressed: null, // Stopボタンタップ時の処理
                  child: Text("Stop"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _timer = Timer.periodic(
                      const Duration(seconds: 1),
                      (Timer timer) => setState(() {
                        _time = _time.add(const Duration(seconds: 1));
                      }),
                    );
                  },
                  child: const Text("Start"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}