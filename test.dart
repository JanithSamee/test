import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  StreamCreator().stream.listen((event) {
    print(event);
  }, onError: (err) => print(err));
}

class StreamCreator {
  final _streamController = StreamController<String>.broadcast();
  StreamCreator() {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://socketsbay.com/wss/v2/1/demo/'),
    );

    _streamController.addStream(channel.stream.map((event) =>
        event is! String ? "message : unknown" : "message : $event"));
  }
  Stream<String> get stream => _streamController.stream;
}
