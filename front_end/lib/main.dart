import 'package:flutter/material.dart';
import 'package:front_end/registrationpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Supabase.initialize(
  url: "https://bbkowwxnzhznvmnbpglc.supabase.co",  // 🔹 Replace with your actual Supabase URL
  anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJia293d3huemh6bnZtbmJwZ2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA5MDY1OTcsImV4cCI6MjA1NjQ4MjU5N30.8bnDy9DbgTDeL2l0FQPDozsLIXi1tgF7DVfDA8ZWlqw",  // 🔹 Replace with your actual Anon Key
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
