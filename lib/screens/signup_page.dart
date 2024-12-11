import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:final_pj/screens/home_page.dart';
import 'package:final_pj/screens/login_page.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final _fnameController = TextEditingController();

  final _lnameController = TextEditingController();

  final _usernameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isLoading = false;
  final signupURL = Uri.parse('https://www.melivecode.com/api/users/create');
  final headers = {'Content-Type': 'application/json'};
  Future<dynamic> _signup(String fname, String lname, String username,
      String email, String password) async {
    final body = jsonEncode({
      "fname": fname,
      "lname": lname,
      "username": username,
      "password": password,
      "email": email,
      "avatar": "https://www.melivecode.com/users/cat.png"
    });
    try {
      final response = await http.post(signupURL, headers: headers, body: body);
      final jsonRes = jsonDecode(response.body);
      return jsonRes;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'S I G N U P',
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _fnameController,
                          decoration:
                              const InputDecoration(hintText: 'First Name'),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _lnameController,
                          decoration:
                              const InputDecoration(hintText: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(hintText: 'Username'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            final res = await _signup(
                                _fnameController.text,
                                _lnameController.text,
                                _usernameController.text,
                                _emailController.text,
                                _passwordController.text);

                            if (res['status'] == 'ok') {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomePage(userDetails: res['user']);
                              }));
                            } else {
                              _isLoading = false;
                            }
                          },
                          child: const Text('SIGNUP'),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              (MaterialPageRoute(builder: (context) {
                                return const LoginPage();
                              })));
                        },
                        child: const Text(
                          'Login',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
