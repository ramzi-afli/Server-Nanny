import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_cot_app/modles/room.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../modles/authTokens.dart';
import '../modles/util/ressourceApi.dart';
import '../widgets/tempratureWidget.dart';


class Monotoring extends StatefulWidget {
  const Monotoring({Key? key}) : super(key: key);


  @override
  State<Monotoring> createState() => _MonotoringState();
}

class _MonotoringState extends State<Monotoring> {
  @override
  void initState() {
    super.initState();
    setUpTimedFetch();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;
    print("----------------------------------------");
    print(arg['refreshToken']);
    AuthTokens authTokens = new AuthTokens(
        arg['accessToken'], arg['refreshToken']);
    ResourceApi resourceApi = ResourceApi(
        authTokens.accessToken, authTokens.refreshToken);
    AudioPlayer audioPlugin = AudioPlayer();
    return Scaffold(
        backgroundColor: Colors.white70,
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
            future: resourceApi.getSensorData("sensor1","sensor2")  ,

            builder: (context, snapshot){
                 if(snapshot.hasData) {
                   if(snapshot.data[1]['values'][0]<90 && snapshot.data[0]['values'][0]<30){
                     return Center(
                       child: Padding(
                         padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
                         child: Column(
                           children: [
                             Expanded(
                               flex: 4,
                               child: ElevatedButton(
                                 onPressed: () {
                                   Navigator.pushNamed(
                                       context, '/tmp_history', arguments: {
                                     'accessToken': resourceApi.accessToken,
                                     'refreshToken': resourceApi.refreshToken
                                   });
                                 },
                                 style: ElevatedButton.styleFrom(
                                     elevation: 0,
                                     primary: Colors.transparent),
                                 child: SfRadialGauge(
                                   axes: <RadialAxis>[

                                     RadialAxis(

                                       backgroundImage: const AssetImage(
                                           'images/light_frame.png'),
                                       ticksPosition: ElementsPosition.outside,
                                       labelsPosition: ElementsPosition.outside,
                                       minorTicksPerInterval: 5,
                                       axisLineStyle: AxisLineStyle(
                                         thicknessUnit: GaugeSizeUnit.factor,
                                         thickness: 0.1,
                                       ),
                                       axisLabelStyle: const GaugeTextStyle(

                                           fontWeight: FontWeight.bold,
                                           fontSize: 16),
                                       radiusFactor: 0.97,
                                       majorTickStyle: const MajorTickStyle(
                                           length: 0.1,
                                           thickness: 2,

                                           lengthUnit: GaugeSizeUnit.factor),
                                       minorTickStyle: const MinorTickStyle(
                                           length: 0.05,
                                           thickness: 1.5,

                                           lengthUnit: GaugeSizeUnit.factor),
                                       minimum: 0,
                                       maximum: 60,
                                       interval: 10,
                                       startAngle: 115,
                                       endAngle: 65,
                                       ranges: <GaugeRange>[
                                         GaugeRange(
                                             startValue: -60,
                                             endValue: 120,
                                             startWidth: 0.1,
                                             sizeUnit: GaugeSizeUnit.factor,
                                             endWidth: 0.1,
                                             gradient: const SweepGradient(
                                                 stops: <double>[
                                                   0.2,
                                                   0.5,
                                                   0.75
                                                 ], colors: <Color>[
                                               Colors.green,
                                               Colors.yellow,
                                               Colors.red
                                             ]))
                                       ],
                                       pointers: <GaugePointer>[
                                         NeedlePointer(
                                             value: snapshot.data[0]['values'][0],
                                             //value must be set here
                                             needleColor: Colors.black,
                                             tailStyle: const TailStyle(
                                                 length: 0.18, width: 8,
                                                 color: Colors.black,
                                                 lengthUnit: GaugeSizeUnit
                                                     .factor),
                                             needleLength: 0.68,
                                             needleStartWidth: 1,
                                             needleEndWidth: 8,
                                             knobStyle: const KnobStyle(
                                                 knobRadius: 0.07,
                                                 color: Colors.white,
                                                 borderWidth: 0.05,
                                                 borderColor: Colors.black),
                                             lengthUnit: GaugeSizeUnit.factor)
                                       ],
                                       annotations: const <GaugeAnnotation>[
                                         GaugeAnnotation(
                                             widget: Text(
                                               '°C',
                                               style:
                                               TextStyle(fontSize: 20,
                                                   fontWeight: FontWeight.w600,
                                                   color: Colors.redAccent),
                                             ),
                                             positionFactor: 0.8,
                                             angle: 90)
                                       ],
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                             Expanded(
                                 flex: 1,
                                 child: Container()),
                             Expanded(
                               flex: 4,
                               child: ElevatedButton(
                                 onPressed: () {
                                   Navigator.pushNamed(
                                       context, '/hum_history', arguments: {
                                     'accessToken': resourceApi.accessToken,
                                     'refreshToken': resourceApi.refreshToken
                                   });
                                 },
                                 style: ElevatedButton.styleFrom(
                                     elevation: 0,
                                     primary: Colors.transparent),
                                 child: SfRadialGauge(
                                   axes: <RadialAxis>[

                                     RadialAxis(

                                       backgroundImage: const AssetImage(
                                           'images/light_frame.png'),
                                       ticksPosition: ElementsPosition.outside,
                                       labelsPosition: ElementsPosition.outside,
                                       minorTicksPerInterval: 5,
                                       axisLineStyle: const AxisLineStyle(
                                         thicknessUnit: GaugeSizeUnit.factor,
                                         thickness: 0.1,
                                       ),
                                       axisLabelStyle: const GaugeTextStyle(

                                           fontWeight: FontWeight.bold,
                                           fontSize: 16),
                                       radiusFactor: 0.97,
                                       majorTickStyle: const MajorTickStyle(
                                           length: 0.1,
                                           thickness: 2,

                                           lengthUnit: GaugeSizeUnit.factor),
                                       minorTickStyle: const MinorTickStyle(
                                           length: 0.05,
                                           thickness: 1.5,

                                           lengthUnit: GaugeSizeUnit.factor),
                                       minimum: 0,
                                       maximum: 100,
                                       interval: 10,
                                       startAngle: 115,
                                       endAngle: 65,
                                       ranges: <GaugeRange>[
                                         GaugeRange(
                                             startValue: -60,
                                             endValue: 120,
                                             startWidth: 0.1,
                                             sizeUnit: GaugeSizeUnit.factor,
                                             endWidth: 0.1,
                                             gradient: const SweepGradient(
                                                 stops: <double>[
                                                   0.2,
                                                   0.5,
                                                   0.75
                                                 ], colors: <Color>[
                                               Colors.green,
                                               Colors.yellow,
                                               Colors.blue
                                             ]))
                                       ],
                                       pointers: <GaugePointer>[
                                         NeedlePointer(
                                             value: snapshot.data[1]['values'][0],
                                             //value must be set here
                                             needleColor: Colors.black,
                                             tailStyle: const TailStyle(
                                                 length: 0.18, width: 8,
                                                 color: Colors.black,
                                                 lengthUnit: GaugeSizeUnit
                                                     .factor),
                                             needleLength: 0.68,
                                             needleStartWidth: 1,
                                             needleEndWidth: 8,
                                             knobStyle: const KnobStyle(
                                                 knobRadius: 0.07,
                                                 color: Colors.white,
                                                 borderWidth: 0.05,
                                                 borderColor: Colors.black),
                                             lengthUnit: GaugeSizeUnit.factor)
                                       ],
                                       annotations: const <GaugeAnnotation>[
                                         GaugeAnnotation(
                                             widget: Text(
                                               'H%',
                                               style:
                                               TextStyle(fontSize: 20,
                                                   fontWeight: FontWeight.w600,
                                                   color: Colors.blueAccent),
                                             ),
                                             positionFactor: 0.8,
                                             angle: 90)
                                       ],
                                     ),
                                   ],
                                 ),
                               ),
                             ),

                           ],
                         ),
                       ),

                     );
                   }else{
                     audioPlugin.play(AssetSource("alert.mp3"));
                       return SizedBox(
                       child: AlertDialog(
                         backgroundColor: Colors.red,
                         title: const Text(
                             'Danger '),
                         content: SingleChildScrollView(
                           child: ListBody(
                             children: const <Widget>[
                               Text(
                                   'Your Server is damaged  please check it immediately'),
                             ],
                           ),
                         ),
                         actions: <Widget>[
                           TextButton(
                             child: const Text('OK'),
                             onPressed: () {
                               audioPlugin.stop();

                               Navigator.of(context).pop();
                             },
                           ),
                         ],
                       ),
                     );
                   }
                 }else {
                   return const Center(
                     child: CircularProgressIndicator(),
                   );
                 }
               }
        )
    );
  }

  setUpTimedFetch() {
    Timer.periodic(const Duration(milliseconds: 5000), (timer) {
      setState(() {});
    });
  }
}