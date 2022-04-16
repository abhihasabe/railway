import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      key: const Key("container"),
      child: const Center(
        child: Text(
          "Splash",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
