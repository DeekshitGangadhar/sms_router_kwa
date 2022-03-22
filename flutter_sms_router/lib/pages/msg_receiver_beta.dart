import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called");
}

class MsgReceiverBeta extends StatefulWidget {
  const MsgReceiverBeta({ Key? key }) : super(key: key);

  @override
  State<MsgReceiverBeta> createState() => _MsgReceiverBetaState();
}

class _MsgReceiverBetaState extends State<MsgReceiverBeta> {
  final GlobalKey<ScaffoldState> _scaffoldKey_1 = GlobalKey<ScaffoldState>();

  String _message = "";
  String _phone = "";
  List<SmsMessage> messages = [];
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
      messages.add(message);
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
      body: Builder(
        builder: (context) {
          if (messages.length == 0){
            return Center(child: Text('No new messages'));
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(color: Colors.black),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    print(messages.length);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.markunread,
                        ),
                        title: Text(messages[index].address ?? "Failed to get phone number"),
                        subtitle: Text(
                          messages[index].body ?? "Failed to get message body",
                          maxLines: 2,
                          style: TextStyle(),
                        ),
                      ),
                    );
                  },
            );
          }
          
        }
      ),
    );
  }
}