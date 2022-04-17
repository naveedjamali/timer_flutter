import 'dart:developer';
import 'package:flutter/material.dart';

import 'app_timer.dart';

main() {
  runApp(const StopWatch());
}

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  @override
  Widget build(BuildContext context) {
    return const TimerApp();
  }
}

class TimerApp extends StatefulWidget {
  const TimerApp({Key? key}) : super(key: key);

  @override
  State<TimerApp> createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  AppTimer? appTimer;
  String hours = "00";
  String minutes = "00";
  String seconds = "00";

  void setTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    setState(() {
      hours = twoDigits(d.inHours.remainder(24));
      minutes = twoDigits(d.inMinutes.remainder(60));
      seconds = twoDigits(d.inSeconds.remainder(60));

      log("$hours:$minutes:$seconds");
    });
  }

  @override
  void initState() {
    super.initState();
    appTimer = AppTimer(const Duration(seconds: 5), (d) => setTime(d),
        onTimerStop: () {
      setState(() {});
    }, onTimerStart: () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Flutter Stopwatch demo")),
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Timer",
                style: TextStyle(fontSize: 38),
              ),
              Text(
                "$hours:$minutes:$seconds",
                style:
                    const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    appTimer!.isRunning
                        ? appTimer!.stopTimer()
                        : appTimer!.startTimer();
                  });
                },
                child: Text(appTimer == null
                    ? "Start Timer"
                    : appTimer!.isRunning
                        ? "Stop Timer"
                        : "Start Timer"),
              )
            ],
          ),
        )),
      ),
    );
  }
}
