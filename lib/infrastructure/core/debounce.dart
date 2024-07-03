

import 'dart:async';



/// it will handle the concurrent request
///
/// it will wait to the time and push the latest coming request
///
/// used in textField search , to avoid multiple API request in a fraction time.
class Debounce {
  Duration delay;
  Timer? _timer;

  Debounce(
      this.delay,
      );

  call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  dispose() {
    _timer?.cancel();
  }
}