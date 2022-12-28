import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';



Widget HumidityWidget(BuildContext context , double  humidityValue  ){

  return SfRadialGauge(
      axes: <RadialAxis>[

        RadialAxis(

          backgroundImage:const AssetImage('images/light_frame.png'),
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
                gradient: SweepGradient(stops: <double>[
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
                value: humidityValue, //value must be set here
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
                  'H%',
                  style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.blueAccent),
                ),
                positionFactor: 0.8,
                angle: 90)
          ],
        ),
      ],

  );
  void onPointerValueChanged(double value) {
  }

  }