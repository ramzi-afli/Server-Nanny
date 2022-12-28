import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class Humidity extends StatefulWidget {
  const Humidity({Key? key}) : super(key: key);

  @override
  State<Humidity> createState() => _HumidityState();
}

class _HumidityState extends State<Humidity> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 70,
      width: 90,
      child:  Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(70,0,50,300),
          child: SfRadialGauge(
            axes: <RadialAxis>[

              RadialAxis(

                backgroundImage:const AssetImage('images/light_frame.png'),
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
                      gradient: const SweepGradient(stops: <double>[
                        0.2,
                        0.5,
                        0.75
                      ], colors: <Color>[
                        Colors.green,
                        Colors.yellow,
                        Colors.blue
                      ]))
                ],
                pointers: const <GaugePointer>[
                  NeedlePointer(
                      value: 90, //value must be set here
                      needleColor: Colors.black,
                      tailStyle: TailStyle(length: 0.18, width: 8,
                          color: Colors.black,
                          lengthUnit: GaugeSizeUnit.factor),
                      needleLength: 0.68,
                      needleStartWidth: 1,
                      needleEndWidth: 8,
                      knobStyle: KnobStyle(knobRadius: 0.07,
                          color: Colors.white, borderWidth: 0.05,
                          borderColor: Colors.black),
                      lengthUnit: GaugeSizeUnit.factor)
                ],
                annotations: const <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Text(
                        'H%',
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.blueAccent),
                      ),
                      positionFactor: 0.8,
                      angle: 90)
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }

  String _annotationValue = '90';
}

