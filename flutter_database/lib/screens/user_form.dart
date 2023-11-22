import 'package:doctor_appointment_app/components/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/chat/v1.dart';
import 'package:gsheets/gsheets.dart';

class UserFormWidget extends StatefulWidget {
  final ValueChanged<User> onSavedUser;

  const UserFormWidget({
    Key? key,
    required this.onSavedUser,
  }) : super(key: key);

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerId;
  late TextEditingController controllerName;
  late TextEditingController controllerAge;
  late TextEditingController controllerStatus;
  late TextEditingController controllerAddress;

  @override
  void initState() {
    super.initState();

    initUser();
  }

  void initUser() {
    controllerId = TextEditingController();
    controllerName = TextEditingController();
    controllerAge = TextEditingController();
    controllerStatus = TextEditingController();
    controllerAddress = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildID(),
            const SizedBox(height: 16),
            buildName(),
            const SizedBox(height: 16),
            buildAge(),
            const SizedBox(height: 16),
            buildStatus(),
            const SizedBox(height: 16),
            buildAddress(),
            const SizedBox(height: 16),
            buildSubmit(),
          ],
        ),
      );

  Widget buildID() => TextFormField(
        controller: controllerId,
        decoration: InputDecoration(
          labelText: 'ID',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'กรุณากรอก ID' : null,
      );

  Widget buildName() => TextFormField(
        controller: controllerName,
        decoration: InputDecoration(
          labelText: 'ชื่อ-สกุล',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'กรุณากรอกชื่อ-สกุล' : null,
      );

  Widget buildAge() => TextFormField(
        controller: controllerAge,
        decoration: InputDecoration(
          labelText: 'อายุ',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'กรุณากรอกอายุ' : null,
      );

  Widget buildStatus() => TextFormField(
        controller: controllerStatus,
        decoration: InputDecoration(
          labelText: 'สถานะ',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'กรุณากรอกสถานะ' : null,
      );

  Widget buildAddress() => TextFormField(
        controller: controllerAddress,
        decoration: InputDecoration(
          labelText: 'ที่อยู่',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'กรุณากรอกที่อยู่' : null,
      );

  Widget buildSubmit() => ButtonWidget(
        text: 'บันทึก',
        onClick: () {
          final form = formKey.currentState!;
          final isValid = form.validate();

          // if (isValid) {
          //   final user = User(
          //     id: controllerId.text,
          //     name: controllerName.text,
          //     age: controllerAge.text,
          //     status: controllerStatus.text,
          //     address: controllerAddress.text,
          //   );
          //   widget.onSavedUser(user);
          // }
        }, OnClick: () {  },
      );
}
