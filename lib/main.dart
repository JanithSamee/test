import 'package:flutter/material.dart';
import 'package:test/AppBody.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 48))),
        home: Scaffold(
          appBar: AppBar(title: const Text("Flutter Streams")),
          body: const AppBody(),
        ));
  }
}
