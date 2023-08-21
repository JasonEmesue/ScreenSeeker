import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11.0),
          child: Image.asset(
            'assets/images/SSlogo3.png',
            width: 30.0,
            height: 20.0,
          ),
        ),
        title: const Text(
          'Account',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
