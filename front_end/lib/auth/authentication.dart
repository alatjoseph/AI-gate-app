import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;
  Future<User?> signUp(String email, String password) async {
    try {
      final response=await supabase.auth.signUp(
        email: email,
        password: password,
      );
      return response.user!;
    } catch (e) {
      print("Signup Error: $e");
      return null;
    }
  }


  Future<User?> login(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    return response.user!;
      
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }


  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
