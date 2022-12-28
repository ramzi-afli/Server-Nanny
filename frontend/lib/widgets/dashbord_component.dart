import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../modles/room.dart';
import '../modles/util/ressourceApi.dart';
import '../views/monitoring.dart';
import 'custom_rect_tween.dart';
import 'hero_dialog_route.dart';



Widget dashbordComponent(BuildContext context , Color color, Room   room, ResourceApi resourceApi ) {
  return   SizedBox(
    width:160.0,
    height: 160.0,
    child: Card(
      color: color,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)
      ),
      child:Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed:(){
              // ur  logic  is  here
        Navigator.pushNamed(context,'/monitore',arguments:{
          'accessToken':resourceApi.accessToken,
          'refreshToken':resourceApi.refreshToken
        });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  <Widget>[
                  Text(
                    '${room.id}',
                    style: const  TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0
                    ),
                  ),

                  Text(
                    "${room.userEmail}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22
                    ),
                  ),
                  // Text(
                  //   "${medication.scheduleList}",
                  //style: TextStyle(fontSize: 20, color: Colors.white),

                  //),

                ],
              ),
            ),
          )
      ),
    ),
  ) ;

}
const String _heroAddTodo = 'add-todo-hero';


