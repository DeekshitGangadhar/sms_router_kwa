import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

class MyInbox extends StatefulWidget {
  const MyInbox({ Key? key }) : super(key: key);

  @override
  State<MyInbox> createState() => _MyInboxState();
}

class _MyInboxState extends State<MyInbox> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  SmsQuery query = new SmsQuery();
  List<SmsMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Messages',
        ),
      ),
      body: FutureBuilder(
        future: fetchSMS(),
        builder: (context, snapshot) {
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
                  title: Text(messages[index].address),
                  subtitle: Text(
                    messages[index].body,
                    maxLines: 2,
                    style: TextStyle(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  fetchSMS() async {
    messages = await query.getAllSms;
  }
}