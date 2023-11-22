import 'package:doctor_appointment_app/screens/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.orange.shade100],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'โปรไฟล์',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/logo-white.jpg'),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Card(
          elevation: 10,
          margin: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text('สมาคมเพื่อคนพิการจังหวัดชายแดนภาคใต้'),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Cbr.madi@gmail.com'),
              ),
              ListTile(
                leading: Icon(Icons.facebook),
                title: Text('สมาคมเพื่อคนพิการจังหวัดชายแดนภาคใต้'),
                onTap: () {
                  launchFacebookProfile();
                },
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('จังหวัดชายแดนภาคใต้'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('089 041 1356'),
                onTap: () {
                  _launchPhone('tel:+66890411356');
                },
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Image.asset('assets/1.jpg'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('ปิด'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.note_alt, color: Colors.white),
                    SizedBox(width: 20),
                    Text('บันทึกความดี', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthPage()),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.white),
                    SizedBox(width: 20),
                    Text('ออกจากระบบ', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void _launchPhone(String phoneNumber) async {
  if (await canLaunch(phoneNumber)) {
    await launch(phoneNumber);
  } else {
    throw 'Could not launch $phoneNumber';
  }
}


launchFacebookProfile() async {
  const facebookProfileUrl =
      'https://www.facebook.com/profile.php?id=100040376418604';
  if (await canLaunch(facebookProfileUrl)) {
    await launch(facebookProfileUrl);
  } else {
    throw 'Could not launch $facebookProfileUrl';
  }
}
