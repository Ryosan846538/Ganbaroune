import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CountUpPage extends StatefulWidget {
  const CountUpPage({Key? key}) : super(key: key);

  @override
  State<CountUpPage> createState() => _CountUpPageState();
}

class _CountUpPageState extends State<CountUpPage>{
  final _stopWatchTimer = StopWatchTimer();

  final _scrollController = ScrollController();

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('勉強記録'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snapshot) {
                  final displayTime = StopWatchTimer.getDisplayTime(
                    snapshot.data!,
                  );
                  return Center(
                    child: SizedBox(
                      width: 144,
                      child: Text(
                        displayTime,
                        style: const TextStyle(fontSize: 40,),
                      ),
                    ),
                  );
                }
              ),
              const SizedBox(height: 32,),
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
                      return const Text('No records');
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
                child: const Text('Start'),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _stopWatchTimer.onStopTimer,
                child: const Text('Stop'),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _stopWatchTimer.onResetTimer,
                child: const Text('Reset'),
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
                child: const Text('Lap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}