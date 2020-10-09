import 'package:flutter/material.dart';
import 'package:hinergi_kwh/service/apiService.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class mainScreen extends StatefulWidget {
  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hinergi"),
        ),
        body: Stack(
          children: <Widget>[
            StreamBuilder(
                stream: Stream.periodic(Duration(seconds: 5)).asyncMap((i) =>
                    getThinkspeakData()), // i is null here (check periodic docs)
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      "Data : " + snapshot.data['field1'].toString(),
                      style: TextStyle(color: Colors.green),
                    );
                  } else {
                    return Text(
                      "Data : NULL",
                      style: TextStyle(color: Colors.red),
                    );
                  }
                } // builder should also handle the case when data is not fetched yet
                ),
            Center(
                child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      axisValue: 50,
                      positionFactor: 0.1,
                      widget: Text(
                        '30.0',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ))
                ], pointers: <GaugePointer>[
                  MarkerPointer(
                      value: 60,
                      color: Colors.red,
                      markerType: MarkerType.text,
                      text: "BUDGET"),
                  RangePointer(
                      value: 30, color: Colors.green, dashArray: <double>[8, 2])
                ])
              ],
            )),
          ],
        ),
      ),
    );
  }
}
