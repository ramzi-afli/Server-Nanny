
 import 'package:mobile_cot_app/modles/util/baseapi.dart';

import '../room.dart';
 import 'package:http/http.dart' as http;
 import 'dart:convert' as convert;



 class ResourceApi  extends BaseAPI{


 String  accessToken  ;
 String refreshToken ;
 ResourceApi(this.accessToken,this.refreshToken);


   Future<List<Room>> getAllRooms()  async{
     print(super.createProtectedHeader(accessToken));
     var response  =await http.get(Uri.parse(super.apisPath+"/room"),headers:super.createProtectedHeader(accessToken))  ;
    //
     if(response.statusCode==200){
       var jsonResponse = convert.jsonDecode(response.body) as List ;
       List responseList=[] ;
       Room room ;
        var  i=0;
       jsonResponse.forEach((element) {
         Room room = Room(element["id"], element["userEmail"]);
         responseList.add(room) ;
       });
       print(responseList.length);
        return responseList as List<Room> ;
     }else {
       print('Request failed with status: ${response.statusCode}.');
       return [] ;
     }

  }

   Future<List> getRoomsByIdUser(String email) async{
     var response  =await http.get(Uri.parse(super.apisPath+"/room"+email),headers:super.createProtectedHeader(accessToken)) ;
     if(response.statusCode==200){
       var jsonResponse = convert.jsonDecode(response.body) as List ;
       List responseList=[] ;
       Room room ;
       jsonResponse.forEach((element) {
         Room room = Room(element["id"], element["userEmail"]);
         responseList.add(room) ;
       });
       return responseList as List ;
     }else {
       print('Request failed with status: ${response.statusCode}.');
       return [] ;
     }


   }





}