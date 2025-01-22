import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _verifyInicializations();
  }

  Future<void> _verifyInicializations() async {
    //Normaly we would check if the user is logged in, if the user has a subscription, etc.
    //For now, we just wait 1 second
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      ///Remove the splash screen
      FlutterNativeSplash.remove();

      ///Navigate to the home page
      await Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
