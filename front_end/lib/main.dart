import 'package:flutter/material.dart';
import 'package:front_end/Presentation/registrationpage.dart';
import 'package:front_end/constants/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Supabase.initialize(
  url: url,  // 🔹 Replace with your actual Supabase URL
  anonKey: anonKey
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Registrationpage()
    );
  }
}
