import 'package:flutter/material.dart';
import '/service/studynote_data_repository.dart';
import '/service/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  late Future<List<StudyRecord>> studyRecords;

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is initialized
    try{
      studyRecords = fetchStudynoteShow('test');
    }catch (error){
       //print('Error: $error');
    }
  }

  Future<void> _refreshData() async {
    // Fetch updated data from the API
    final updatedRecords = await fetchStudynoteShow('test');
    setState(() {
      studyRecords = Future.value(updatedRecords);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: FutureBuilder<List<StudyRecord>>(
        future: studyRecords,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No study records available.');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: snapshot.data![index].subjectColor,
                  ),
                  child: ListTile(
                    title: Text('日付: ${snapshot.data![index].date}'),
                    subtitle: Text('勉強時間: ${snapshot.data![index].studyTime.inHours}時間'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

Future<List<StudyRecord>> fetchStudynoteShow(String username) async {
  final String apiUrl = dotenv.get('API_SERVER');
  ApiClient apiClient = ApiClient(apiUrl);
  var studyNoteData = StudyNoteDataRepository(apiClient);
  List<StudyRecord> studyRecords = [];

  try {
    dynamic responseData = await studyNoteData.getStudyNoteShow(username);

    if (responseData['message'] == 'succeed') {
      // Assuming responseData['data'] is a list of study records
      List<Map<String, dynamic>> dataList = List.castFrom(responseData['data']);
      studyRecords = dataList.map((data) {
        // Assuming 'date', 'studytime', and 'subject' are keys in each study record
        DateTime date = DateTime.parse(data['date']);
        Duration studyTime;

        if (data['studytime'] is String) {
          // Parse 'studytime' as DateTime
          DateTime studyDateTime = DateTime.parse(data['studytime']);
          // Calculate the difference in milliseconds
          studyTime = DateTime.now().difference(studyDateTime);
        } else {
          // Parse 'studytime' as Duration (assuming it's in milliseconds)
          studyTime = Duration(milliseconds: data['studytime']);
        }

        String subject = data['subject'].toString();

        return StudyRecord(
          date: date,
          studyTime: studyTime,
          subject: subject,
        );
      }).toList();

    } else {
      // Handle the case when the API response is not successful
      //print('API response indicates failure');
    }
  } catch (error) {
    // Handle error
    //print('Error: $error');
  }

  return studyRecords;
}