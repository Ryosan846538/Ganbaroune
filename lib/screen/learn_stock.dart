import 'package:flutter/material.dart';

class StudyRecord {
  final DateTime date;
  final Duration studyTime;
  final String subject;

  StudyRecord({required this.date, required this.studyTime, required this.subject});

  Color get subjectColor {
    switch (subject) {
      case '国語':
        return Colors.red[100]!;
      case '数学':
        return Colors.blue[100]!;
      case '英語':
        return Colors.purple[100]!;
      case '理科':
        return Colors.green[100]!;
      case '社会':
        return Colors.yellow[100]!;
      default:
        return Colors.grey;
    }
  }
}

class LearnStock extends StatefulWidget {
  const LearnStock({Key? key}) : super(key: key);

  @override
  LearnStockState createState() => LearnStockState();
}

class LearnStockState extends State<LearnStock> {
  List<StudyRecord> studyRecords = [
    StudyRecord(date: DateTime.now(), studyTime: const Duration(hours: 1), subject: '国語'),
    // ここにデータを追加していく
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: studyRecords.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1), // この行を追加
            color: studyRecords[index].subjectColor,
          ),
          child: ListTile(
            title: Text('日付: ${studyRecords[index].date}'),
            subtitle: Text('勉強時間: ${studyRecords[index].studyTime.inHours}時間'),
          ),
        );
      },
    );
  }
}