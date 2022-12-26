import 'package:flutter/material.dart';

import '../modles/util/authApi.dart';
import '../widgets/input_decoration.dart';




class Singin extends StatefulWidget {
  const Singin({Key? key}) : super(key: key);
  @override
  _SinginState createState() => _SinginState();
}

class _SinginState extends State<Singin> {
  AuthAPI _authAPI = AuthAPI();
  String username ="" ;
  String email ="" ;
  String password="" ;
  String confirmPassword="" ;


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height ;
    final width=MediaQuery.of(context).size.width ;
    return Scaffold(
      body:SingleChildScrollView(
        child: Center(
          child: Stack(
              children:[
                SizedBox(
                  height: height,
                  width: width,

                ),
                Positioned(
                  top: 4,
                  left: 40,
                  right: 40,
                  child: Container(
                    height: height/3,
                    width: width/2,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/logo.png"),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(120)
                        )
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  right: 10,
                  top: 210,
                  child: Container(
                    height: height/1.2,
                    width: width/2,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)
                        )
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                              child: TextField(
                                  decoration: buildInputDecoration(Icons.account_circle ,"Full  Name"),
                                  onChanged:(val) =>setState(() => username = val) ,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                              child: TextField(
                                  decoration: buildInputDecoration( Icons.email ,"Email"),
                                  onChanged:(val) =>setState(() => email = val) ,

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                              child: TextField(
                                  decoration:  buildInputDecoration(Icons.password,"Password"),
                                  onChanged:(val) =>setState(() => password = val) ,

                              ),
                            ),
                            Padding(
                              padding:  const EdgeInsets.fromLTRB(20, 40, 20, 0),
                              child: TextField(
                                  obscureText: true,
                                  decoration: buildInputDecoration(Icons.password," Confirm Password"),
                                onChanged:(val) =>setState((){
                                confirmPassword = val;
                                }

                                ) ,
                              ),
                            ),
                            Padding(padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                              child: Container(
                                height: height / 18,
                                width: width / 2,
                                decoration: BoxDecoration(
                                    color:Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
                                child: TextButton(
                                  onPressed: () {
                                    if(password.isEmpty || confirmPassword.isEmpty ||password.isEmpty ) {
                                      //
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible: false,
                                        // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Error Accursed'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: const <Widget>[
                                                  Text(
                                                      'Please check your password'),

                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                    else {
                                      _authAPI.signUp(email, username, username, password).then((value) => print(value.body));

                                    }
                                  },
                                  child: const Text(
                                    'Create',
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}