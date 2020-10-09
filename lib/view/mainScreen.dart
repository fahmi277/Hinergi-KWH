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
        body: StreamBuilder(
            stream: Stream.periodic(Duration(seconds: 5)).asyncMap((i) =>
                getThinkspeakData()), // i is null here (check periodic docs)
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                double voltage = double.parse(snapshot.data['field1']);
                double energy = double.parse(snapshot.data['field4']);

                energy -= 772.3;
                voltage /= 10;
                return Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Card(
                          child: ListTile(
                            title: Text(snapshot.data['created_at']),
                            subtitle: Text(snapshot.data['created_at']),
                          ),
                        ),
                      ],
                    ),
                    Center(
                        child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                            startAngle: 180,
                            endAngle: 90,
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  axisValue: 50,
                                  positionFactor: 0.1,
                                  widget: Text(
                                    energy.toStringAsFixed(2).toString() +
                                        " KWH",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ))
                            ],
                            pointers: <GaugePointer>[
                              MarkerPointer(
                                  value: 60,
                                  color: Colors.red,
                                  markerType: MarkerType.text,
                                  text: "BUDGET"),
                              RangePointer(
                                  value:
                                      double.parse((energy.toStringAsFixed(0))),
                                  color: Colors.green,
                                  dashArray: <double>[8, 2])
                            ])
                      ],
                    )),
                  ],
                );
                // return Text(
                //   "Data : " + snapshot.data['field1'].toString(),
                //   style: TextStyle(color: Colors.green),
                // );
              } else {
                return Text(
                  "Data : NULL",
                  style: TextStyle(color: Colors.red),
                );
              }
            } // builder should also handle the case when data is not fetched yet
            ),
      ),
    );
  }
}
