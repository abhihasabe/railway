import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:rapid_response/theme/app_colors.dart';
import 'package:flutter/material.dart';

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
          return RefreshIndicator(
            displacement: 250,
            backgroundColor: primaryColor,
            color: Colors.white,
            strokeWidth: 3,
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: () async {
              await Future.delayed(Duration(milliseconds: 1000));
              fetchSMS();
            },
            child: _messages.length>0?
            ListView.separated(
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
                }):Center(child: Text("Data Not Found")),
          );
        },
      ),
    );
  }

  fetchSMS() async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      final messages = await _query
          .querySms(kinds: [SmsQueryKind.values.first], address: 'AD-GKWRKS');
      setState(() => _messages = messages);
    } else {
      await Permission.sms.request();
    }
  }
}
