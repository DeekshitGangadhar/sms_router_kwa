  // ignore: prefer_const_constructors
  import 'package:flutter/material.dart';
  import 'package:flutter_sms_router/pages/my_inbox.dart';
  import 'package:flutter_sms_router/pages/msg_receiver.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MsgReceiver(),
    );
  }
}