import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flip_card/flip_card.dart';
import '/service/studynote_data_repository.dart';
import '/service/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class CountUpPage extends StatefulWidget {
  const CountUpPage({Key? key}) : super(key: key);

  @override
  State<CountUpPage> createState() => _CountUpPageState();
}

class _CountUpPageState extends State<CountUpPage> {
  final _stopWatchTimer = StopWatchTimer();
  final _scrollController = ScrollController();
  final _flipCardKey = GlobalKey<FlipCardState>();

  String _getDisplayTime(int time) {
    final hours =
        ((time / (60 * 60 * 1000)) % 60).floor().toString().padLeft(2, '0');
    final minutes =
        ((time / (60 * 1000)) % 60).floor().toString().padLeft(2, '0');
    final seconds = ((time / 1000) % 60).floor().toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // snapshot.dataを保存するための変数を定義します
    String displayTime = '';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlipCard(
              key: _flipCardKey,
              direction: FlipDirection.VERTICAL,
              front: Card(
                color: Colors.green[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.black, width: 4),
                ),
                child: SizedBox(
                  width: 360,
                  height: 120,
                  child: StreamBuilder<int>(
                      stream: _stopWatchTimer.rawTime,
                      initialData: _stopWatchTimer.rawTime.value,
                      builder: (context, snapshot) {
                        displayTime = _getDisplayTime(snapshot.data!);
                        return Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  displayTime,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.sync,
                                size: 40,
                                color: Colors.black,
                              ),
                            ]));
                      }),
                ),
              ),
              back: Card(
                color: Colors.green[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.black, width: 4),
                ),
                child: const SizedBox(
                  width: 360,
                  height: 120,
                  child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 160,
                              child: Text(
                                '勉強中...',
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.sync,
                              size: 40,
                              color: Colors.black,
                            ),
                          ])),
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _stopWatchTimer.onStartTimer,
              child: const Text('スタート'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _stopWatchTimer.onStopTimer,
              child: const Text('ストップ'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _stopWatchTimer.onResetTimer,
              child: const Text('リセット'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _stopWatchTimer.onStopTimer();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text("きろくしますか？"),
                      content: StreamBuilder<int>(
                        stream: _stopWatchTimer.rawTime,
                        initialData: _stopWatchTimer.rawTime.value,
                        builder: (context, snapshot) {
                          final displayTime = _getDisplayTime(snapshot.data!);
                          return Text(displayTime);
                        },
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("いいえ"),
                          onPressed: () {
                            _stopWatchTimer.onStartTimer();
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        ),
                        TextButton(
                          child: const Text("はい"),
                          onPressed: () async {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
                            dynamic inputData = {
                              'studytime': displayTime,
                              'subject': 1,
                              'username': 'test',
                              'date': formattedDate,
                              'goal': 'test'
                            };
                            await fetchStudyNote(inputData);
                            if (!mounted) return;
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('きろく'),
            ),
            const SizedBox(height: 32), // 92行目の修正
          ],
        ),
      ),
    );
  }
}

Future<void> fetchStudyNote(dynamic inputData) async {
  final String apiUrl = dotenv.get('API_SERVER');
  ApiClient apiClient = ApiClient(apiUrl);
  var studyNote = StudyNoteDataRepository(apiClient);

  try {
    await studyNote.postStudyNoteAdd(inputData);
    // データの受け取りと処理はここで行う
    // 例えば、結果をログに出力するなど
  } catch (error) {
    // エラーハンドリング
    // print('Error: $error');
    // print('Error Details: ${error.toString()}');
  }
}