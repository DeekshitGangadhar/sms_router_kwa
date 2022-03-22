import 'package:flutter/material.dart';
// import 'package:sms/sms.dart';
import 'package:telephony/telephony.dart';

onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called");
}

class MsgReceiver extends StatefulWidget {
  const MsgReceiver({ Key? key }) : super(key: key);

  @override
  State<MsgReceiver> createState() => _MsgReceiverState();
}

class _MsgReceiverState extends State<MsgReceiver> {
  final GlobalKey<ScaffoldState> _scaffoldKey_1 = GlobalKey<ScaffoldState>();

  String _message = "";
  String _phone = "";
  final telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  onMessage(SmsMessage message) async {
    // print("New Message received $message");
    setState(() {
      _message = message.body ?? "Error reading message body.";
      _phone = message.address ?? "Error reading message address." ;
    });
  }

  Future<void> initPlatformState() async {
    telephony.listenIncomingSms(
          onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey_1,
      appBar: AppBar(
        title: Text('Message Router'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: Icon(Icons.markunread),
            title: Text("Latest message from $_phone"),
            subtitle: Text(_message),
          )
        ],
      ),
    );
  }
}