import 'package:doctor_appointment_app/screens/asses.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
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
        child: SafeArea(
          child: SingleChildScrollView(
            // เพิ่ม SingleChildScrollView
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'ประเมินผู้ป่วย',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 15),
                      // Text
                      Text(
                        'สรุประดับความพิการทางสายตา',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: 180, 
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            _buildBarChart(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'สรุปพิกัดข้อมูลผู้พิการทางสายตา',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            _buildPieChart(),
                          ],
                        ),
                        Positioned(
                          top: 0, 
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'อัพเดทล่าสุด 11/2023',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AssessmentForm(),
            ),
          );
        },
        elevation: 10,
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.assessment,
          size: 38,
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    List<PieChartSampleData> pieData = _getPieData();

    return SfCircularChart(
      series: <PieSeries<PieChartSampleData, String>>[
        PieSeries<PieChartSampleData, String>(
          dataSource: pieData,
          xValueMapper: (PieChartSampleData data, _) => data.x,
          yValueMapper: (PieChartSampleData data, _) => data.y,
          pointColorMapper: (PieChartSampleData data, _) => data.color,
          dataLabelMapper: (PieChartSampleData data, _) => data.text,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
      legend: Legend(isVisible: true, position: LegendPosition.right),
    );
  }

  Widget _buildBarChart() {
    List<BarChartSampleData> barData = _getBarData();

    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <BarSeries<BarChartSampleData, String>>[
        BarSeries<BarChartSampleData, String>(
          dataSource: barData,
          xValueMapper: (BarChartSampleData data, _) => data.x,
          yValueMapper: (BarChartSampleData data, _) => data.y,
          color: Colors.yellow, 
        ),
      ],
      plotAreaBorderWidth: 1, 
      plotAreaBorderColor: Colors.white, 
    );
  }

  List<PieChartSampleData> _getPieData() {
    // Replace this with your actual pie chart data
    return <PieChartSampleData>[
      PieChartSampleData('อ.เมือง', 35.8, Colors.blue, '15.8%'),
      PieChartSampleData('อ.รามัน', 25.6, Colors.green, '25.6%'),
      PieChartSampleData('อ.ยะหา', 15.2, Colors.red, '15.2%'),
      PieChartSampleData('อ.กาบัง', 10.5, Colors.yellow, '10.5%'),
      PieChartSampleData('อ.กรงปินัง', 8.9, Colors.orange, '8.9%'),
      PieChartSampleData('อ.บันนังสตา', 4.0, Colors.purple, '4.0%'),
      PieChartSampleData('อ.ธารโต', 4.0, Colors.grey, '4.0%'),
      PieChartSampleData('อ.เบตง', 4.0, Colors.brown, '4.0%'),
    ];
  }
}

List<PieChartSampleData> _getPieData() {
  return <PieChartSampleData>[
    PieChartSampleData('อ.เมือง', 35.8, Colors.blue, '35.8%'),
    PieChartSampleData('อ.รามัน', 25.6, Colors.green, '25.6%'),
    PieChartSampleData('อใยะหา', 15.2, Colors.red, '15.2%'),
    PieChartSampleData('อ.กาบัง', 10.5, Colors.yellow, '10.5%'),
    PieChartSampleData('อ.กรงปินัง', 8.9, Colors.orange, '8.9%'),
    PieChartSampleData('อ.บันนังสตา', 4.0, Colors.purple, '4.0%'),
    PieChartSampleData('อ.ธารโต', 4.0, Colors.grey, '4.0%'),
    PieChartSampleData('อ.เบตง', 4.0, Colors.brown, '4.0%'),
  ];
}

List<BarChartSampleData> _getBarData() {
  return <BarChartSampleData>[
    BarChartSampleData('สายตาพิการ', 30),
    BarChartSampleData('ตาบอดชั้นหนึ่ง', 20),
    BarChartSampleData('ตาบอดชั้นสอง', 15),
    BarChartSampleData('ตาบอดชั้นสาม', 25),
  ];
}

class WebViewPage {
  WebViewPage({required String url});
}

class PieChartSampleData {
  PieChartSampleData(this.x, this.y, this.color, this.text);

  final String x;
  final double y;
  final Color color;
  final String text;
}

class BarChartSampleData {
  BarChartSampleData(this.x, this.y);

  final String x;
  final double y;
}
