import 'package:doctor_appointment_app/components/button_widget.dart';
import 'package:doctor_appointment_app/main.dart';
import 'package:doctor_appointment_app/screens/user_form.dart';
import 'package:doctor_appointment_app/sheets/api.dart';
import 'package:doctor_appointment_app/sheets/fields.dart';
import 'package:flutter/material.dart';

class CreateSheetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      // title: Text(MyApp.title),
      centerTitle: true,
    ),
    body:  Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(32),
      child: SingleChildScrollView(
        child: UserFormWidget(
          onSavedUser: (user) async {
            final rowCount = await UserSheetApi.getRowCount();
            final newUser = user;
            
            await UserSheetApi.insert([newUser.toJson()]);
          },
        ),
      ),
    ),
  );
}

mixin title {
}
