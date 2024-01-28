import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flip_card/flip_card.dart';

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
                  width: 350,
                  height: 120,
                  child: StreamBuilder<int>(
                      stream: _stopWatchTimer.rawTime,
                      initialData: _stopWatchTimer.rawTime.value,
                      builder: (context, snapshot) {
                        final displayTime = _getDisplayTime(snapshot.data!);
                        return Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              SizedBox(
                                width: 160,
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
                  width: 350,
                  height: 120,
                  child: const Center(
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
            SizedBox(
              height: 80,
              child: StreamBuilder<List<StopWatchRecord>>(
                stream: _stopWatchTimer.records,
                initialData: const [],
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<StopWatchRecord>> snapshot,
                ) {
                  final value = snapshot.data;
                  if (value!.isEmpty) {
                    return const Text('記録がありません');
                  }
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: value.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = value[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text('${index + 1}: ${data.displayTime}'),
                          ),
                          const SizedBox(height: 8), // 55行目の修正
                        ],
                      );
                    },
                  );
                },
              ),
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
              onPressed: () async {
                if (!_stopWatchTimer.isRunning) {
                  return;
                }
                _stopWatchTimer.onAddLap();
                await Future<void>.delayed(const Duration(milliseconds: 100));
                await _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                );
              },
              child: const Text('記録'),
            ),
            const SizedBox(height: 32), // 92行目の修正
          ],
        ),
      ),
    );
  }
}