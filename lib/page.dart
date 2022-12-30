import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  bool isRunning = false;
  Duration duration = Duration();
  Timer? timer;
  bool isCountdown = true;
  @override
  void initState() {
    super.initState();
    reset();
  }

  void reset() {
    setState(() {
      duration = Duration();
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) => addTime());
  }

  void stopTimer() {}

  void addTime() {
    setState(() {
      final seconds = duration.inSeconds + 1;
      duration = Duration(seconds: seconds);
    });
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Lottie.asset('assets/97976-clock.json'),
          ),
          Text(
            '$hours: $minutes : $seconds',
            style: const TextStyle(fontSize: 55),
          ),
          (isRunning)
              ? MaterialButton(
                  color: Colors.redAccent,
                  shape: const CircleBorder(),
                  onPressed: () {
                    // reset();
                    timer?.cancel();
                    setState(() {
                      isRunning = false;
                    });
                  },
                  onLongPress: () {
                    reset();
                    timer?.cancel();
                    setState(() {
                      isRunning = false;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.stop,
                      size: 50,
                    ),
                  ),
                )
              : MaterialButton(
                  color: Colors.lightBlueAccent,
                  shape: const CircleBorder(),
                  onPressed: () {
                    startTimer();
                    setState(() {
                      isRunning = true;
                    });
                  },
                  onLongPress: () {
                    reset();
                    timer?.cancel();
                    setState(() {
                      isRunning = false;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.play_arrow_outlined,
                      size: 50,
                    ),
                  ),
                ),
        ],
      ))),
    );
  }
}
