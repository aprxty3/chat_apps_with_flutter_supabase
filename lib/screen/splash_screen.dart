import 'package:chat_apps_with_flutter_supabase/screen/chat_screen.dart';
import 'package:chat_apps_with_flutter_supabase/screen/register_screen.dart';
import 'package:flutter/material.dart';

import '../utils/constans.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    final session = supabase.auth.currentSession;
    if (session == null) {
      await Future.delayed(
        const Duration(seconds: 1),
        () => Navigator.pushAndRemoveUntil(
            context, RegisterScreen.route(), (route) => false),
      );
    } else {
      await Future.delayed(
        const Duration(seconds: 1),
        () => Navigator.pushAndRemoveUntil(
            context, ChatScreen.route(), (route) => false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: preloader);
  }
}
