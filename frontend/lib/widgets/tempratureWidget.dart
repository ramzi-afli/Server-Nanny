import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';




Widget tempreatureWidget(BuildContext context , double  temperature  ){

  return  Container(
    height: 70,
    width: 90,
    child:  Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50,0,50,300),
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              backgroundImage:const AssetImage('images/light_frame.png'),
              minimum: -10,
              maximum: 120,
              interval: 20,
              radiusFactor: 0.5,
              showAxisLine: false,
              labelOffset: 5,
              useRangeColorForAxis: true,
              axisLabelStyle: GaugeTextStyle(fontWeight: FontWeight.bold),
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: -50,
                    endValue: -20,
                    sizeUnit: GaugeSizeUnit.factor,
                    color: Colors.green,
                    endWidth: 0.03,
                    startWidth: 0.03),
                GaugeRange(
                    startValue: -20,
                    endValue: 20,
                    sizeUnit: GaugeSizeUnit.factor,
                    color: Colors.yellow,
                    endWidth: 0.03,
                    startWidth: 0.03),
                GaugeRange(
                    startValue: -20,
                    endValue: 120,
                    sizeUnit: GaugeSizeUnit.factor,
                    color: Colors.red,
                    endWidth: 0.03,
                    startWidth: 0.03),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Text(
                      '°F',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    positionFactor: 0.8,
                    angle: 90)
              ],
            ),
            RadialAxis(

              ticksPosition: ElementsPosition.outside,
              labelsPosition: ElementsPosition.outside,
              minorTicksPerInterval: 5,
              axisLineStyle: AxisLineStyle(
                thicknessUnit: GaugeSizeUnit.factor,
                thickness: 0.1,
              ),
              axisLabelStyle: GaugeTextStyle(

                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              radiusFactor: 0.97,
              majorTickStyle: MajorTickStyle(
                  length: 0.1,
                  thickness: 2,

                  lengthUnit: GaugeSizeUnit.factor),
              minorTickStyle: MinorTickStyle(
                  length: 0.05,
                  thickness: 1.5,

                  lengthUnit: GaugeSizeUnit.factor),
              minimum: -10,
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
                    gradient: SweepGradient(stops: <double>[
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
                    value: temperature, //value must be  set here
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
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Text(
                      '°C',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
