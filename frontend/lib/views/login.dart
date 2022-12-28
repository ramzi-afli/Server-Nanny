import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../modles/util/authApi.dart';
import '../widgets/input_decoration.dart';
import '../modles/authTokens.dart';




class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
   AuthAPI _authAPI = AuthAPI();
   String email="";
   String password="";
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  color: Colors.white,
                ),
                Positioned(
                  top: 15,
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
                    top: 250,

                    child: Container(
                      height: height / 1.5,
                      width: width,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
                              child: TextField(
                                  decoration: buildInputDecoration( Icons.email ,"Email"),
                                onChanged:(val) =>setState(() => email = val) ,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                              child: TextField(
                                  obscureText: true,
                                  decoration: buildInputDecoration(Icons.password,"Password"),
                                  onChanged:(val) =>setState(() => password = val) ,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text('if you dont have account try  to',
                                    style: TextStyle(fontSize: 15,color: Colors.black
                                    ),),

                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/Sing');
                                    },
                                    child:const Text(
                                      'create account',
                                      style: TextStyle(
                                          color:Colors.blueGrey, fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Container(
                                height: height / 18,
                                width: width / 2,
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextButton(
                                  onPressed: () {
                                    print(email) ;
                                    print(password);
                                    _authAPI.login(email, password).then((value){
                                      if(value.statusCode==200){
                                        var data =jsonDecode(value.body) ;
                                        AuthTokens authtoken=new AuthTokens(data['accessToken'], data['refreshToken'])  ;
                                        Navigator.pushNamed(context,'/dashboard',    arguments: {"accessToken":data['accessToken'],
                                        "refreshToken":data['refreshToken']
                                        },
                                        );

                                      }else{
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
                                                        'Please check your email or password'),
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
                                    }
                                    );

                                    //your  migration to here
                                  },
                                  child: const Text('Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                )
              ]
          ),
        ),
      ),
    );
  }


}
