import 'package:final_pj/screens/login_page.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  Map<String, dynamic> userDetails;
  ProfileTab({super.key, required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 80,
        child: Image.network(
          userDetails['avatar'],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Card(
        child: Column(children: [
          ListTile(
            leading: const Text('First Name'),
            trailing: Text(userDetails['fname']),
          ),
          ListTile(
            leading: const Text('Last Name'),
            trailing: Text(userDetails['lname']),
          ),
          ListTile(
            leading: const Text('User Name'),
            trailing: Text(userDetails['username']),
          ),
          ListTile(
            leading: const Text('Email'),
            trailing: Text(userDetails['email']),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              )),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    ]);
  }
}
