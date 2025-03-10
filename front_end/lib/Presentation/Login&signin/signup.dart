import 'package:flutter/material.dart';
import 'package:front_end/auth/authentication.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  void _signUp() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    try {
      await AuthService().signUp(email, password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup successful! Please log in.')),
      );

      // Navigate to login page
      Navigator.pushNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const Opacity(
              opacity: 0.50,
              child: Image(
                image: AssetImage("assets/login1.jpg"),
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center vertically
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center horizontally
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.2), // Adjust spacing
                    Text(
                      "Create an account",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Get start now!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildGlassTextField("Email", _emailController),
                    const SizedBox(height: 20),
                    _buildGlassTextField("Password", _passwordController,
                        obscureText: true),
                    const SizedBox(height: 50),
                    _buildAnimatedLoginButton(),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.2), // Adjust bottom spacing
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        "Already have an account? Login",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassTextField(String hint, TextEditingController controller,
      {bool obscureText = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.white.withOpacity(0.1))
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildAnimatedLoginButton() {
    return GestureDetector(
      onTap: () {
        _signUp();
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        width: 200,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          // gradient: LinearGradient(colors: [Colors.blueAccent, Colors.purpleAccent]),
          borderRadius: BorderRadius.circular(30),
          //boxShadow: [BoxShadow(color: Colors.green, blurRadius: 10)],
        ),
        child: Text(
          "Sign Up",
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // Widget _buildSocialButtons() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       _socialButton(FontAwesomeIcons.google, Colors.red, "Google"),
  //       SizedBox(width: 20),

  //     ],
  //   );
  // }

  // Widget _socialButton(IconData icon, Color color, String label) {
  //   return ElevatedButton.icon(
  //     style: ElevatedButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.2)),
  //     onPressed: () {},
  //     icon: Icon(icon, color: color),
  //     label: Text(label, style: TextStyle(color: Colors.white)),
  //   );
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
