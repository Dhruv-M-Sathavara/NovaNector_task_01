import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:random_string/random_string.dart';
import 'package:to_do/dbservice/dataoftask.dart';
import 'package:to_do/pages/taskpage.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {

  TextEditingController todoController = TextEditingController();

  TextEditingController SubtitleController = 
  TextEditingController();
  bool isDone = false;
  Stream?todoStreme;

  getonTheLoad()async{
    todoStreme = await DBService().retreveTask("Task");
    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget getWork(){
    return StreamBuilder(stream: todoStreme, builder: (context,AsyncSnapshot snapshot){
      if (snapshot.hasData) {
        return Expanded(child: ListView.builder(itemCount: snapshot.data.docs.length, itemBuilder: (context,index){
        DocumentSnapshot docSnap = snapshot.data.docs[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: 130,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://media.istockphoto.com/id/1303877287/vector/paper-checklist-and-pencil-flat-pictogram.jpg?s=612x612&w=0&k=20&c=NoqPzn94VH2Pm7epxF8P5rCcScMEAiGQ8Hv_b2ZwRjY='),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              docSnap["Title"],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Checkbox(
                              value: isDone,
                              onChanged: (value) {
                                setState(() {
                                  isDone = value!;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          docSnap["subtitle"],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 90,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 2),
                                  child: Row(
                                    children: [
                                      Text(
                                        'time',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                width: 90,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 2),
                                  child: Row(
                                    children: [
                                      Text(
                                        'edit',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
      } else {
        return ;
      }
    });
  }

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
                itemCount: 1,),
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
                    controller: todoController,
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
                    controller: SubtitleController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border:  InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height:20),
                Center(
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    
                   child: GestureDetector(
                    onTap: () {
                      String id = randomAlphaNumeric(10);
                      Map<String,dynamic>userTodo= {
                        "Title":todoController.text,
                        "Description":SubtitleController.text,
                        "id":id,
                        
                      };

                      DBService().addTask(userTodo,id);
                      Navigator.pop(context);
                    },
                     child: Center(
                       child: Text("Add",
                      style: TextStyle(
                        color: Colors.black
                      ),),
                     ),
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