import 'package:flutter/material.dart';

class Hommepagge extends StatefulWidget {
  const Hommepagge({super.key});

  @override
  State<Hommepagge> createState() => _HommepaggeState();
}

class _HommepaggeState extends State<Hommepagge> {

  bool Personal = true, Work = false, Shopping = false ,isDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 70),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Text("Hello, ",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black
                ),),
              ),
              SizedBox(height: 10,),

              Container(
                padding: EdgeInsets.only(left: 5),
                child: Text("Let's the work begins!",style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54
                ),),
              ),

              SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 Personal ? Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text("Personal",style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),),
                    
                    ),
                  ):GestureDetector(
                    onTap: () {
                      Personal = true;
                      Work = false;
                      Shopping = false;
                      setState(() {
                        
                      });
                    },
                    child: Text("Personal",
                    style: TextStyle(
                      fontSize: 20,
                    ),),
                  ),


                  Work ? Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text("Work",style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),),
                    
                    ),
                  ):GestureDetector(
                    onTap: () {
                      Personal = false;
                      Work = true;
                      Shopping = false;
                      setState(() {
                        
                      });
                    },
                    child: Text("Work",
                    style: TextStyle(
                      fontSize: 20,
                    ),),
                  ),
                  
                  Shopping ? Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text("Shopping",style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),),
                    
                    ),
                  ):GestureDetector(
                    onTap: () {
                      Personal = false;
                      Work = false;
                      Shopping = true;
                      setState(() {
                        
                      });
                    },
                    child: Text("Shopping",
                    style: TextStyle(
                      fontSize: 20,
                    ),),
                  ),
                 
                ],
              ),
              SizedBox(height: 20,),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Container(
                  width: double.infinity,
                  height: 230,
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  )
                ],
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Container(
                      child: Text("D&T"),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [ Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      height: 130,
                      width: 100,
                      child: Image(image: NetworkImage('https://media.istockphoto.com/id/1303877287/vector/paper-checklist-and-pencil-flat-pictogram.jpg?s=612x612&w=0&k=20&c=NoqPzn94VH2Pm7epxF8P5rCcScMEAiGQ8Hv_b2ZwRjY='),
                        fit: BoxFit.cover,),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                     children: [ 
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        
                        child: Row(
                          children: [
                            Container(
                              child: Text("Title", style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                )),
                            ),
                              Container(
                                padding: EdgeInsets.only(left: 124),
                                child: Checkbox(value: isDone, onChanged: (value){
                                  setState(() {
                                    isDone = !isDone;
                                  });
                                }),
                              )
                          ],
                          
                        ),
                      ),
                      SizedBox(height: 5,),

                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                            "subtitle",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade400,
                            ),
                          ),
                      ),
                     ],
                    )
                    ]),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text("Priority",style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),),
                    
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 22,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text("Edit",style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                      ),),
                    
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 242, 93, 91),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text("Delete",style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                      ),),
                    
                    ),
                    
                      ]
                    )
                  ],
                ),
                ),
              )

            

          ],
        ),
      ),
    );
  }
}