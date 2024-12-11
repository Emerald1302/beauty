import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:final_pj/screens/home_page.dart';
import 'package:final_pj/screens/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isLoading = false;

  final loginURL = Uri.parse('https://www.melivecode.com/api/login');

  final headers = {'Content-Type': 'application/json'};

  Future<dynamic> _login(String username, String password) async {
    final body = jsonEncode({'username': username, 'password': password});
    try {
      final response = await http.post(loginURL, headers: headers, body: body);
      final jsonRes = jsonDecode(response.body);
      return jsonRes;
    } catch (e) {
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
                  const Image(
                    width: 150,
                    height: 130,
                    image: AssetImage('assets/beauty.png'),
                  ),
                  const Image(
                    image: AssetImage('assets/image.png'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'User Name'),
                    controller: _usernameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Password'),
                    controller: _passwordController,
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
                            final res = await _login(_usernameController.text,
                                _passwordController.text);
                            print(res);
                            print(res['user']);
                            
                            if (res['status'] == 'ok') {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomePage(
                                  userDetails: res['user'],
                                );
                              }));
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
                              print('Login failed');
                            }
                          },
                          child: Text('LOGIN',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.white))),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              (MaterialPageRoute(builder: (context) {
                                return SignupPage();
                              })));
                        },
                        child: const Text(
                          'Sign up',
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
