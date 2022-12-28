import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_cot_app/modles/authTokens.dart';

import '../modles/room.dart';
import '../modles/util/ressourceApi.dart';
import '../widgets/dashbord_component.dart';

class Dashbord extends StatefulWidget {
  const Dashbord({Key? key}) : super(key: key);


  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {

  List  back_data=[];
  var  length=0;
  List data = [
    {"color": const  Color(0xffff6968)},
    {"color": const  Color(0xff7a54ff)},
    {"color": const  Color(0xffff8f61)},
    {"color": const  Color(0xff2ac3ff)},
    {"color": const  Color(0xff5a65ff)},
    {"color": const  Color(0xff96da45)},
    {"color": const  Color(0xffff6968)},
    {"color": const  Color(0xff7a54ff)},
    {"color": const  Color(0xffff8f61)},
    {"color": const  Color(0xff2ac3ff)},
    {"color": const  Color(0xff5a65ff)},
    {"color":const   Color(0xff96da45)},

  ];


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    final arg = ModalRoute.of(context)!.settings.arguments as Map   ;
    print("----------------------------------------");
    print(arg['refreshToken']);
    AuthTokens authTokens=new AuthTokens(arg['accessToken'], arg['refreshToken']);
    ResourceApi resourceApi=ResourceApi(authTokens.accessToken,authTokens.refreshToken);
    List rooms;
    return Scaffold(
        backgroundColor: Colors.white70,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.blueGrey,
          index: 1,
          items: const  <Widget> [
            Icon(Icons.navigate_before, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.navigate_next, size: 30),
          ],
          onTap: (index) {
            if(index==0){ Navigator.pop(context) ; }            //Handle button tap
          },
        ),
        body:
        FutureBuilder(
            future: resourceApi.getAllRooms(),
            builder:  (context,snapshot  ) {
              print(snapshot);
              return snapshot.hasData ?
              Stack(
                  children:[ Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.fromLTRB(50 ,50,0,0),
                                child: Icon(Icons.arrow_back ,color: Colors.white,
                                ),
                              ) ,
                              Padding(
                                padding: EdgeInsets.fromLTRB(80.0,50,0,0),
                                child: Text("Schedule" ,style: TextStyle(color:Colors.white , fontSize: 30),),
                              )
                            ],
                          ) ,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              )
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 8,
                        child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return dashbordComponent(context ,data[index]["color"],snapshot.data![index],resourceApi);
                            }),
                      ),
                    ],
                  ),
                  ]

              ):const Center(
                child: CircularProgressIndicator(),
              );
            }
        )
    );

  }
}