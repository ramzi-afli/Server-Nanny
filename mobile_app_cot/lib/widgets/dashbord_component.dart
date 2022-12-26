import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../modles/room.dart';
import 'custom_rect_tween.dart';
import 'hero_dialog_route.dart';



Widget dashbordComponent(BuildContext context , Color color, Room   room ) {
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
                Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                  return  _AddTodoPopupCard();
                }));

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



class _AddTodoPopupCard extends StatelessWidget {


  _AddTodoPopupCard({Key ? key}) : super(key: key);
  final nameController = TextEditingController();
  final descriptionController=TextEditingController() ;
  final scheduleController=TextEditingController() ;
  String tmp ="";
  String nom ="" ;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin !, end: end !);
          },
          child: Material(
            color: Colors.blueGrey,
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Edit Medication ',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight:FontWeight.bold),) ,
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                      maxLines: 6,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),

                    TextField(
                      controller: descriptionController,
                      decoration: const  InputDecoration(
                        hintText: 'description',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                      maxLines: 6,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'schedule',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                      maxLines: 6,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    TextButton(
                      onPressed: () {
                        String  name=nameController.value.text   ;
                        String  description=descriptionController.value.text ;
                        String  schedule=scheduleController.value.text;
                        //update fonction must  be here



                      },
                      child: const Text('Edit' ,style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}