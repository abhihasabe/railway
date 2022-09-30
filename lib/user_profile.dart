import 'package:rapid_response/theme/app_shared_preferences_constant.dart';
import 'package:rapid_response/storage/cache/secure_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:rapid_response/theme/app_colors.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var phone, email, name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  void getUserData() async {
    name = await SecStore.getValue(keyVal: SharedPreferencesConstant.USERNAME);
    email =
        await SecStore.getValue(keyVal: SharedPreferencesConstant.USEREMAIL);
    phone =
        await SecStore.getValue(keyVal: SharedPreferencesConstant.USERPHONE);
    setState(() {
      print("name: $name, email: $email, phone: $phone");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), backgroundColor: primaryColor),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Name :",
                      style: TextStyle(fontSize: 18)),
                  SizedBox(width: 20),
                  name != null
                      ? Text(name, style: Theme.of(context).textTheme.bodyLarge)
                      : Text(""),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.black38),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Text("Email :",
                      style:TextStyle(fontSize: 18)),
                  SizedBox(width: 20),
                  email != null
                      ? Text(email,
                          style: Theme.of(context).textTheme.bodyLarge)
                      : Text(""),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.black38),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Text("Phone :",
                      style: TextStyle(fontSize: 18)),
                  SizedBox(width: 20),
                  phone != null
                      ? Text(phone,
                          style: Theme.of(context).textTheme.bodyLarge)
                      : Text(""),
                ],
              ),
            ),
            Divider(height: 1.7, color: Colors.black38)
          ]),
    );
  }
}
