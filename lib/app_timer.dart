
import 'dart:async';

class AppTimer {
  Duration _countDownDuration = const Duration();
  Duration _elapsedDuration = const Duration();
  Timer? timer;
  Function(Duration elapsed) callbackOnTick;
  Function()? onTimerStop;
  Function()? onTimerStart;
  bool isRunning = false;

  AppTimer(Duration length, this.callbackOnTick,
      {this.onTimerStart, this.onTimerStop}) {
    _countDownDuration = length;
    _reset();
  }

  void _reset() {
    _elapsedDuration = _countDownDuration;
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) => _addTime(1));
    onTimerStart!();
    isRunning = true;
  }

  void _addTime(int tickLengthInSeconds) {
    final addSeconds = tickLengthInSeconds;

    final seconds = _elapsedDuration.inSeconds - addSeconds;
    if (seconds < 0) {
      stopTimer(resets: true);
    } else {
      _elapsedDuration = Duration(seconds: seconds);
      callbackOnTick(_elapsedDuration);
    }
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      _reset();
    }
    timer?.cancel();
    onTimerStop!();
    isRunning = false;
  }
}
