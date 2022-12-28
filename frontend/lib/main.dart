import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:mobile_cot_app/views/dashbord.dart';
import 'package:mobile_cot_app/views/humidityhustory.dart';
import 'package:mobile_cot_app/views/login.dart';
import 'package:mobile_cot_app/views/monitoring.dart';
import 'package:mobile_cot_app/views/singin.dart';
import 'package:mobile_cot_app/views/welcomescreen.dart';
import 'package:mobile_cot_app/views/temprature_history.dart';



ThemeData lightTheme = ThemeData.light();
ThemeData darkTheme = ThemeData.dark();

void main() {
  runApp(const Home());
}


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return ThemeProvider(
      initTheme: lightTheme,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/':(ctx)=>  const WelcomeScreen() ,
          '/Login':(ctx)=> const Login(),
          '/Sing':(ctx)=> const Singin(),
           '/dashboard':(ctx)=>  const Dashbord() ,
           '/monitore':(ctx)=>  Monotoring() ,
           '/tmp_history':(ctx)=> const TemperatureHistory() ,
           '/hum_history':(ctx)=> const HumidityHistory() ,


        },
      ),
    ) ;
  }
}