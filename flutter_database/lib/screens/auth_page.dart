import 'package:doctor_appointment_app/components/login_form.dart';
import 'package:doctor_appointment_app/components/sign_up_form.dart';
import 'package:doctor_appointment_app/utils/text.dart';
import 'package:flutter/material.dart';

import '../utils/config.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignIn = true;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    //build login text field
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 65.0,
              backgroundImage: AssetImage('assets/logo-blue.jpg'),
              backgroundColor: Colors.white,
            ),
            Config.spaceSmall,
            Text(
              isSignIn
                  ? AppText.enText['signIn_text']!
                  : AppText.enText['register_text']!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Config.spaceSmall,
            isSignIn ? LoginForm() : Config.spaceBig,
            isSignIn
                ? TextButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("ติดต่อเจ้าหน้าที่"),
          content: Text("โปรดติดต่อเจ้าหน้าที่ได้ที่อีเมล Cbr.madi@gmail.com ในช่วงเวลาทำการ 08:00-16:00 น. ขอบคุณค่ะ/ขอบคุณครับ"),
          actions: <Widget>[
            TextButton(
              child: Text("ปิด"),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
          ],
        );
      },
    );
  },
  child: Text(
    AppText.enText['forgot-password']!,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
  ),
)
                : Container(),
          ],
        ),
      ),
    ));
  }
}
