import 'package:driver/authhentication/login_screen.dart';
import 'package:driver/global/global.dart';
import 'package:flutter/material.dart';

class ProfiletabPage extends StatefulWidget {
  const ProfiletabPage({Key? key}) : super(key: key);

  @override
  State<ProfiletabPage> createState() => _ProfiletabPageState();
}

class _ProfiletabPageState extends State<ProfiletabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        fAuth.signOut();
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      },
      child: const Text("Sign out"),
    ));
  }
}
