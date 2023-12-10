import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sipao/services/firebase_auth_service.dart';
import 'package:sipao/view/user/home/home_page.dart';
import 'package:sipao/view/etc/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  void _dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user =
        await _authService.loginWithEmailandPassword(email, password, context);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login success"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login failed"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              //LOGIN HERE
              const Padding(
                padding: EdgeInsets.only(
                  top: 80,
                ),
                child: Text(
                  "Login Here",
                  style: TextStyle(
                    color: Color(0xFF141E46),
                    fontSize: 28,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //SELAMAT
              const Padding(
                padding: EdgeInsets.only(
                  top: 40,
                ),
                child: Text(
                  "Selamat datang! Kami selalu menantikan kehadiranmu!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              //INPUT
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                ),
                child: Column(
                  children: [
                    //EMAIL
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: _emailController,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF1F4FF),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          labelText: "Email",
                          labelStyle: const TextStyle(
                            color: Color(0xFF616161),
                            fontSize: 16,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                          ),
                          hintText: "Enter your email",
                          hintStyle: const TextStyle(
                            color: Color(0xFF616161),
                            fontSize: 16,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //PASSWORD
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: _passwordController,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF1F4FF),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          labelText: "Password",
                          labelStyle: const TextStyle(
                            color: Color(0xFF616161),
                            fontSize: 16,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                          ),
                          hintText: "Enter your password",
                          hintStyle: const TextStyle(
                            color: Color(0xFF616161),
                            fontSize: 16,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ),
              //FORGOT
              const Padding(
                padding: EdgeInsets.only(
                  top: 15,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(
                      color: Color(0xFF141E46),
                      fontSize: 14,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              //LOGIN
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF141E46),
                    elevation: 4,
                    shadowColor: const Color(0xFFCAD6FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      "Sign In",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              //REGISTER
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  ),
                  child: const Text(
                    "Create new account",
                    style: TextStyle(
                      color: Color(0xFF494949),
                      fontSize: 14,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
