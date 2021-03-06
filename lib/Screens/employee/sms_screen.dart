import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:railway_alert/theme/app_colors.dart';

class SMSInbox extends StatefulWidget {
  const SMSInbox({Key? key}) : super(key: key);

  @override
  State<SMSInbox> createState() => _SMSInboxState();
}

class _SMSInboxState extends State<SMSInbox> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SMS Inbox"),
        backgroundColor: primaryColor,
      ),
      body: FutureBuilder(
        future: fetchSMS(),
        builder: (context, snapshot) {
          return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                  ),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                var message = _messages[index];
                return ListTile(
                  title: Text('${message.sender} [${message.date}]'),
                  subtitle: Text('${message.body}'),
                );
              });
        },
      ),
    );
  }

  fetchSMS() async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      final messages = await _query.querySms(
          kinds: [SmsQueryKind.values.first], address: 'AX-RNGRTI');
      setState(() => _messages = messages);
    } else {
      await Permission.sms.request();
    }
  }
}
