

import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_cot_app/modles/room.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../modles/authTokens.dart';
import '../modles/util/ressourceApi.dart';



class TemperatureHistory extends StatefulWidget {
  const TemperatureHistory({Key? key}) : super(key: key);

  @override
  State<TemperatureHistory> createState() => _TemperatureHistoryState();
}

class _TemperatureHistoryState extends State<TemperatureHistory> {
  late List<SensorValues> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    setUpTimedFetch();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _tooltipBehavior = TooltipBehavior(enable: true);
    final arg = ModalRoute.of(context)!.settings.arguments as Map   ;
    AuthTokens authTokens= AuthTokens(arg['accessToken'], arg['refreshToken']);
    ResourceApi resourceApi=ResourceApi(authTokens.accessToken,authTokens.refreshToken);

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.blueGrey,
              index: 1,
              items: const <Widget>[
                Icon(Icons.navigate_before, size: 30),
                Icon(Icons.home, size: 30),
                Icon(Icons.navigate_next, size: 30),
              ],
              onTap: (index) {
                if (index == 0) {
                  Navigator.pop(context);
                } //Handle button tap
              },
            ),
            body: FutureBuilder(
                future:resourceApi.getSensorData("sensor1","sensor2") ,

                builder:  (context, snapshot  ){
                  return snapshot.hasData ?
                   Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: SfCartesianChart(
                          title: ChartTitle(text: 'Temperature forecasting'),
                          legend: Legend(isVisible: true),
                          tooltipBehavior: _tooltipBehavior,
                          series: <ChartSeries>[
                            LineSeries<SensorValues, double>(
                                name: 'Temperature',
                                dataSource: convertSensorValues(snapshot.data[0]['values']),
                                xValueMapper: (SensorValues mesure, _) => mesure.value,
                                yValueMapper: (SensorValues mesure, _) => mesure.time,
                                dataLabelSettings: const DataLabelSettings(isVisible: true),
                                enableTooltip: true)
                          ],

                          primaryXAxis: NumericAxis(
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                          ),

                          primaryYAxis: NumericAxis(
                            labelFormat: '{value}°C',
                          ),
                        ),
                      ),
                    ],

                  ) :const Center(
                    child: CircularProgressIndicator(),
                  );
                }
            )
        )
    );
  }




  setUpTimedFetch() {
    Timer.periodic(const Duration(milliseconds: 5000), (timer) {
      setState(() {});
    });
  }




  List<SensorValues> getChartData() {
    final List<SensorValues> chartData = [
      SensorValues(0, -10),
      SensorValues(5, 12),
      SensorValues(10, 24),
      SensorValues(15, 18),
      SensorValues(20, 30),
      SensorValues(25, 10),
      SensorValues(30, 10),
      SensorValues(35, 10),
      SensorValues(40, 10),
      SensorValues(45, 10),
      SensorValues(50, 10),
      SensorValues(55, 10),
      SensorValues(60, 10),
      SensorValues(65, 10),
    ];

    return chartData;
  }
}


