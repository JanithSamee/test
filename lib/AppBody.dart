import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
          stream: StreamCreator().stream,
          builder: (context, snap) {
            if (snap.hasError) {
              return const Text("Error");
            } else if (snap.connectionState == ConnectionState.waiting) {
              return const Text("Waiting...");
            } else if (snap.connectionState == ConnectionState.active) {
              return Text("${snap.data}");
            } else {
              return const Text("Finished");
            }
          }),
    );
  }
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
