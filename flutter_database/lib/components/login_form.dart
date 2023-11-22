import 'package:doctor_appointment_app/components/button.dart';
import 'package:doctor_appointment_app/models/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/config.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  // final Future<FirebaseApp> firebase = Firebase.initializeApp();
  bool obsecurePass = true;
  @override
  Widget build(BuildContext context) {
    // retuen FutureBuilder(
    //   Future: firebase,
    //   builder: (context,snapshot){
    //     if(snapshot.hasError){
    //       return Form(
    //         appBar: AppBar(title: Text("Error"),),
    //         body: Center(
    //           child: Text("${snapshot.error}"),
    //         ),
    //       );
    //     }
    //   });
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'อีเมล',
              labelText: 'อีเมล',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
                hintText: 'รหัสผ่าน',
                labelText: 'รหัสผ่าน',
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.lock_outline),
                prefixIconColor: Config.primaryColor,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecurePass = !obsecurePass;
                      });
                    },
                    icon: obsecurePass
                        ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black38,
                          )
                        : const Icon(
                            Icons.visibility_outlined,
                            color: Config.primaryColor,
                          ))),
          ),
          Config.spaceSmall,
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return Button(
                width: double.infinity,
                title: 'เข้าสู่ระบบ',
                onPressed: () {
                  Navigator.of(context).pushNamed('main');
                },
                disable: false,
              );
            },
          )
        ],
      ),
    );
  }
}
