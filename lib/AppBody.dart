import 'dart:async';

import 'package:flutter/material.dart';

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
              return const Text("Waiting");
            } else {
              return Text("${snap.data}");
            }
          }),
    );
  }
}

class StreamCreator {
  final _streamController = StreamController<int>.broadcast();
  int _count = 0;
  StreamCreator() {
    Timer.periodic(const Duration(seconds: 5), (e) {
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
