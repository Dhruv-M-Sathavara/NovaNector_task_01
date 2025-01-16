import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:to_do/pages/taskpage.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  bool show = true;
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(onPressed: (){OpenBox();},backgroundColor: Colors.greenAccent,
        child: Icon(Icons.add_rounded,size: 30,),),
      ),

      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification){
            if(notification.direction == ScrollDirection.forward){
              setState(() {
                show = true;
              });
            }if(notification.direction == ScrollDirection.reverse){
              setState(() {
                show = false;
              });
            }return true;
          },
          child: ListView.builder(itemBuilder: (context,index){
          return Taskpage();
                },
                itemCount: 10,),
        )),
    );
    
  }
  OpenBox(){
    return showDialog(context: context, builder: (BuildContext context)=>AlertDialog(
      content:
        SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                   GestureDetector(
            onTap: (){
                Navigator.pop(context);
            },child: Icon(Icons.cancel),
          ),
          SizedBox(
            width:60
          ),
          Text('ADD Task',
          style: TextStyle(
            color: Colors.greenAccent.shade400
          ),)
                ],),
                SizedBox(height: 20,),
                Text('Add Text'),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2
                    )
                  ),
                  child: TextField(
                    decoration: InputDecoration(border: 
                    InputBorder.none, 
                      hintText: 'Title'
                    ),
                  ),
                ),

                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,
                    
                    width: 2)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Subtitle',
                      border:  InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height:20),
                Center(
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    
                   child: Center(
                     child: Text("Add",
                    style: TextStyle(
                      color: Colors.black
                    ),),
                   ),
                  ),
                )
              ],
            ),
          ),
        )
       
      
    ));
  }
}