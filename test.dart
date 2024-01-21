import 'dart:async';

void main() {
  StreamCreator().stream.listen((event) {
    print(event);
  }, onError: (err) => print(err));
}

class StreamCreator {
  final _streamController = StreamController<int>();
  int _count = 0;
  StreamCreator() {
    Timer.periodic(const Duration(seconds: 1), (e) {
      _count = e.tick;
      if (_count % 5 == 0) {
        _streamController.sink.addError("Error");
      } else {
        _streamController.sink.add(_count);
      }
    });
  }
  Stream<int> get stream => _streamController.stream;
}
