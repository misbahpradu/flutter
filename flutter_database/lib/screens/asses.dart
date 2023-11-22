import 'package:flutter/material.dart';

class AssessmentForm extends StatefulWidget {
  @override
  _AssessmentFormState createState() => _AssessmentFormState();
}

class _AssessmentFormState extends State<AssessmentForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? selectedGender;
  String? selectedVisualImpairment;

  Map<String, String> answers = {
    'การทำงานของการเห็น (b210)': '',
    'การเคลื่อนที่ไปในที่ต่างๆ (d460)': '',
    'การใช้การขนส่ง (d470)': '',
    'การรักษาสุขภาพตัวเอง (d570)': '',
    'การเตรียมอาหาร (d630)': '',
    'การทำงานบ้าน (d640)': '',
    'การศึกษา (d839)': '',
    'การพึ่งพาตนเองทางเศรษฐกิจ (d870)': '',
    'ชีวิตในชุมชน (d910)': '',
    'นันทนาการและกิจกรรมยามว่าง (d920)': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แบบประเมินสมรรถภาพ',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
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
                  value: selectedGender,
                  onChanged: (newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาเลือกเพศ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'เลือกเพศ'),
                  items: [
                    DropdownMenuItem(
                      value: 'ชาย',
                      child: Text('ชาย'),
                    ),
                    DropdownMenuItem(
                      value: 'หญิง',
                      child: Text('หญิง'),
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
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedVisualImpairment,
                  onChanged: (newValue) {
                    setState(() {
                      selectedVisualImpairment = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาเลือกระดับความพิการทางการเห็น';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'เลือกระดับความพิการทางการเห็น'),
                  items: [
                    DropdownMenuItem(
                      value: 'H54.0',
                      child: Text('H54.0'),
                    ),
                    DropdownMenuItem(
                      value: 'H54.1',
                      child: Text('H54.1'),
                    ),
                    DropdownMenuItem(
                      value: 'H54.2',
                      child: Text('H54.2'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'ระดับความบกพร่องในการทำงานของร่างกาย',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 300,
                  child: ListView(
                    shrinkWrap: true,
                    children: answers.keys
                        .map(
                          (question) => AssessmentTile(
                            question: question,
                            selectedOption: answers[question]!,
                            onOptionChanged: (option) {
                              setState(() {
                                answers[question] = option;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await FormController().submitForm(
                        id: idController.text,
                        name: nameController.text,
                        age: ageController.text,
                        status: statusController.text,
                        address: addressController.text,
                        gender: selectedGender,
                        visualImpairment: selectedVisualImpairment,
                      );

                      idController.clear();
                      nameController.clear();
                      ageController.clear();
                      statusController.clear();
                      addressController.clear();
                      setState(() {
                        selectedGender = null;
                        selectedVisualImpairment = null;
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
      ),
    );
  }
}

class AssessmentTile extends StatelessWidget {
  final String question;
  final String selectedOption;
  final ValueChanged<String> onOptionChanged;

  const AssessmentTile({
    required this.question,
    required this.selectedOption,
    required this.onOptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                OptionButton('.0', selectedOption, onOptionChanged),
                OptionButton('.1', selectedOption, onOptionChanged),
                OptionButton('.2', selectedOption, onOptionChanged),
                OptionButton('.3', selectedOption, onOptionChanged),
                OptionButton('.4', selectedOption, onOptionChanged),
                OptionButton('.8', selectedOption, onOptionChanged),
                OptionButton('.9', selectedOption, onOptionChanged),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String option;
  final String selectedOption;
  final ValueChanged<String> onOptionChanged;

  const OptionButton(
    this.option,
    this.selectedOption,
    this.onOptionChanged,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onOptionChanged(option);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: option == selectedOption ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          option,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
    String? gender,
    String? visualImpairment,
  }) async {
    print('Form submitted with data:');
    print('ID: $id');
    print('Name: $name');
    print('Age: $age');
    print('Status: $status');
    print('Address: $address');
    print('Gender: $gender');
    print('Visual Impairment: $visualImpairment');
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AssessmentForm(),
  ));
}
