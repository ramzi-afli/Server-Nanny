

class Room {
  String userEmail;
  String id;
  Room(this.userEmail, this.id);
}

class SensorValues{
  double value ;
  double time ;
  SensorValues(this.value,this.time);
}

List<SensorValues> convertSensorValues(List<dynamic> data){
  List<SensorValues> normalizedList=[];
  data=data.sublist(0,15);
  SensorValues aux=new SensorValues(0,0);
  int i =0 ;
  data.forEach((element) {
    normalizedList.add(SensorValues(1.0*data.indexOf(element),element));
    i++;
  });
  return normalizedList ;


}