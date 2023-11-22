import 'package:doctor_appointment_app/screens/profile_page.dart';
import 'package:doctor_appointment_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePagetState();
}

class _HomePagetState extends State<HomePage> {
  List<Map<String, dynamic>> medCat = [
    {
      "icon": FontAwesomeIcons.blind,
      "category": "สายตาพิการ",
    },
    {
      "icon": FontAwesomeIcons.eye,
      "category": "ตาบอดชั้นหนึ่ง",
    },
    {
      "icon": FontAwesomeIcons.eyeSlash,
      "category": "ตาบอดชั้นสอง",
    },
    {
      "icon": FontAwesomeIcons.lowVision,
      "category": "ตาบอดชั้นสาม",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.orange.shade100],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        DateFormat.Hm().format(
                            DateTime.now()), 
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfilePage()),
                          );
                        },
                        child: SizedBox(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/logo-white.jpg'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Card(
                    margin: EdgeInsets.all(10), 
                    elevation: 5, 
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(5), 
                      side: BorderSide(
                          color: Colors.white), 
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(13),
                      child: Column(
                        children: [
                          Text(
                            'ดุอาอฺเมื่อพบเห็นผู้พิการ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '“มวลการสรรเสริญเป็นสิทธ์ของอัลลอฮฺ ผู้ทรงประทานสุขภาพที่แข็งแรงให้แก่ฉัน โดยให้พ้นจากสิ่งที่พระองค์ทรงทดสอบท่าน และพระองค์ทรงโปรดให้ฉันอยู่เหนือผู้ที่พระองค์ทรงสร้างอย่างล้นเหลือ”',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 345, 
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, 
                      ),
                      itemCount: medCat.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(
                              12), 
                          child: InkWell(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  _showinfoDialog(context);
                                  break;
                                case 1:
                                  _showinfo1Dialog(context);
                                  break;
                                case 2:
                                  _showinfo2Dialog(context);
                                  break;
                                case 3:
                                  _showinfo3Dialog(context);
                                  break;
                              }
                            },
                            child: Container(
                              width: 50,
                              height: 100,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FaIcon(
                                      medCat[index]['icon'],
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      medCat[index]['category'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showinfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("ข้อมูลเพิ่มเติม สายตาพิการ"),
          content: Text(
            "สายตาพิการเป็นสภาวะที่สายตาของบุคคลมีปัญหาและไม่สามารถมองเห็นได้อย่างปกติ มันอาจมีหลายระดับตามความรุนแรงของปัญหาทางสายตา จะพิจารณาสายตาน้อยกว่า 6/60 ลงไปถึง 3/60",
          ),
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
  }

  void _showinfo1Dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("ข้อมูลเพิ่มเติม ตาบอดชั้นหนึ่ง"),
          content: Text(
            "ตาบอดชั้นหนึ่งหมายถึงสภาวะที่บุคคลมองเห็นได้แค่ในระดับที่น้อยมาก หมายความว่ามีปัญหาทางสายตาและมองเห็นได้เพียงในระดับความสว่างหรือความมืดที่มีขีดจำกัด รุนแรงลงจากสายตาพิการ จะพิจารณาสายตาน้อยกว่า 3/60 ลงไปถึง 1/60",
          ),
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
  }

  void _showinfo2Dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("ข้อมูลเพิ่มเติม ตาบอดชั้นสอง"),
          content: Text(
            "ตาบอดชั้นสองหมายถึงสภาวะที่บุคคลมองเห็นได้น้อยมากถึงไม่มองเห็นเลย คนที่มีตาบอดชั้นสองมักจำเป็นต้องพึ่งผู้ช่วยหรืออุปกรณ์เสริมเพื่อดำเนินชีวิตปรากฏ จะพิจารณาสายตาน้อยกว่า 1/60 ลงไปถึงเห็นเพียงแสงสว่าง",
          ),
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
  }

  void _showinfo3Dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("ข้อมูลเพิ่มเติม ตาบอดชั้นสาม"),
          content: Text(
            "ตาบอดชั้นสามหมายถึงสภาวะที่บุคคลมองเห็นได้น้อยมากถึงไม่มองเห็นเลย จากมุมมองทางสายตา, พบว่าตาบอดชั้นสามมักหมายถึงการสูญเสียการมองเห็นที่สมบูรณ์ ผู้ป่วยอาจไม่มีสายตาเหลือเลยหรือมีเพียงความมืดทั้งสายตา จะพิจารณาสายตามองไม่เห็นแม้แต่แสงสว่าง",
          ),
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
  }
}
