import 'package:chat_apps_with_flutter_supabase/utils/constans.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://iuaaimeboychzvqrpvyw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1YWFpbWVib3ljaHp2cXJwdnl3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODM2MTUxMzIsImV4cCI6MTk5OTE5MTEzMn0.1xQor0j2dIiIA_DTzicWhNzHIhOFmCoqTwOL1JGG2F4',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Chat App',
        theme: appTheme,
        home: const Scaffold(
          body: Center(
            child: Text('Hello World'),
          ),
        ));
  }
}
