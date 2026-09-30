import 'package:flutter/material.dart';

import 'root.dart';
// import 'models/data.dart';
import 'models/food_item.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoginFailed = false;

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Pencocokan data dengan user1
    if (username == user1.username && password == user1.password) {
      //menampilkan pesan berhasil login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Berhasil! Selamat Datang.'),
          backgroundColor: Colors.green, // Warna hijau untuk sukses
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Root(username: user1.username, nama: user1.nama,), // Mengirim data nama ke Root
        ),
      );
    } else {
      setState(() {
        isLoginFailed = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Gagal: Username atau Password salah'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(16),
            ),

            child: Padding(
              padding: const EdgeInsetsGeometry.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // menambah image dengan url
                  Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBIXh8mKaO5dgxI2KrjEg75MMXlO_pcbkI8GplRj6mCw&s",
                    height: 80,
                    width: 80,
                  ),
                  const SizedBox(height: 24),




                //kalo pake assets
                Image.asset(
                  'assets/logo.png',
                  height: 80,
                  width: 80,
                ),




                  const Text(
                    'this is login page',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  _usernameField(_usernameController, isLoginFailed),
                  _passwordField(_passwordController, isLoginFailed),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(200, 45),
                    ),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _usernameField(TextEditingController controller, bool isLoginFailed) {
  return _inputField(
    controller: controller,
    hint: 'Username',
    isLoginFailed: isLoginFailed,
  );
}

Widget _passwordField(TextEditingController controller, bool isLoginFailed) {
  return _inputField(
    controller: controller,
    hint: 'Password',
    isLoginFailed: isLoginFailed,
    obscure: true,
  );
}

Widget _inputField({
  required TextEditingController controller,
  required String hint,
  required bool isLoginFailed,
  bool obscure = false,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.all(8.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: isLoginFailed ? Colors.red : Colors.blue,
            width: 2.0,
          ),
        ),
      ),
    ),
  );
}
