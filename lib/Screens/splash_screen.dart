import 'package:flutter/material.dart';
import 'package:railway_alert/widgets/logo_widget.dart';

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
      child: Center(
        child: _buildLogo(),
      ),
    );
  }
}

_buildLogo() {
  return const LogoWidget(
    header: false,
    challenge: false,
    small: true,
  );
}
