import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FavPage(),
    );
  }
}

class FavPage extends StatefulWidget {
  @override
  _FavPageState createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  String searchText = "";
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายชื่อผู้ป่วย',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.orange.shade100],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(fontSize: 16, color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  hintText: 'ค้นหารายชื่อ ...',
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: fetchUsers(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var id = snapshot.data[index]['id'].toString();
                        var name = snapshot.data[index]['name'].toString();
                        var age = snapshot.data[index]['age'].toString();
                        var status = snapshot.data[index]['status'].toString();

                        return GestureDetector(
                          onTap: () {
                            _showMemberCardDetails(id, name, age, status);
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            width: double.infinity,
                            child: Card(
                              child: ListTile(
                                title: Text(name),
                                subtitle: Text(age),
                                trailing: Text(status),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FormPage()));
        },
        elevation: 10,
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          size: 38,
        ),
      ),
    );
  }

  void _showMemberCardDetails(
      String id, String name, String age, String status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('รายละเอียดผู้ป่วย'),
          content: Container(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: $id'),
                Text('ชื่อ-สกุล: $name'),
                Text('อายุ: $age'),
                Text('สถานะ: $status'),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ปิด'),
            ),
          ],
        );
      },
    );
  }

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(Uri.parse(
        "https://script.google.com/macros/s/AKfycbyhmrlLvdRO6qhHVJdb8Az1YkcYe9Uh0_EBDZ_bfwre3Om-Pa9q_Re80XGKXevIWIAk/exec"));
    if (result.statusCode == 200) {
      return jsonDecode(result.body);
    } else {
      throw Exception('ไม่สามารถดึงข้อมูลได้');
    }
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'เพิ่มรายชื่อผู้ป่วย',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: idController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกหมายเลข ID';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'ID'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกชื่อ-สกุล';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'ชื่อ-สกุล'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: ageController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกอายุ';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'อายุ'),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                onChanged: (newValue) {
                  setState(() {
                    selectedStatus = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาเลือกสถานะ';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'เลือกสถานะ'),
                items: [
                  DropdownMenuItem(
                    value: 'สายตาพิการ',
                    child: Text('สายตาพิการ'),
                  ),
                  DropdownMenuItem(
                    value: 'ตาบอดชั้น1',
                    child: Text('ตาบอดชั้น1'),
                  ),
                  DropdownMenuItem(
                    value: 'ตาบอดชั้น2',
                    child: Text('ตาบอดชั้น2'),
                  ),
                  DropdownMenuItem(
                    value: 'ตาบอดชั้น3',
                    child: Text('ตาบอดชั้น3'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: addressController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกที่อยู่';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'ที่อยู่'),
              ),

              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await FormController().submitForm(
                      id: idController.text,
                      name: nameController.text,
                      age: ageController.text,
                      status: selectedStatus ?? '',
                      address: addressController.text,
                    );

                    idController.clear();
                    nameController.clear();
                    ageController.clear();
                    addressController.clear();
                    setState(() {
                      selectedStatus = null;
                    });
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('บันทึกข้อมูลสำเร็จ'),
                          content:
                              Text('ข้อมูลของคุณได้รับการบันทึกเรียบร้อยแล้วค่ะ/ครับ'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('ปิด'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('บันทึก'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormController {
  Future<void> submitForm({
    required String id,
    required String name,
    required String age,
    required String status,
    required String address,
  }) async {
    try {
      var result = await http.post(
        Uri.parse(
          "https://script.google.com/macros/s/AKfycbyhmrlLvdRO6qhHVJdb8Az1YkcYe9Uh0_EBDZ_bfwre3Om-Pa9q_Re80XGKXevIWIAk/exec",
        ),
        body: {
          'action': 'insert',
          'table': 'Users',
          'id': id,
          'name': name,
          'age': age,
          'status': status,
          'address': address,
        },
      );

      if (result.statusCode == 200) {
        var responseJson = jsonDecode(result.body);
        print('Response from server: $responseJson');
        if (responseJson == 'SUCCESS') {
          print('Form submitted successfully!');
        } else {
          print('Error submitting form. Response: $responseJson');
        }
      } else {
        print('Error submitting form: ${result.body}');
      }
    } catch (e) {
      print('Exception submitting form: $e');
    }
  }
}
