import 'dart:async';

class SetDataBLoC {



  StreamController<String> streamController = StreamController();

  void newMessage(int number, String message) {
    final duration = Duration(seconds: number);
    Timer.periodic(duration, (Timer t) => streamController.add(message));
  }

}
