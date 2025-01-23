import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do/dbservice/dataoftask.dart';
import 'package:to_do/dbservice/notification.dart';

class Hommepagge extends StatefulWidget {
  const Hommepagge({super.key});

  @override
  State<Hommepagge> createState() => _HommepaggeState();
}

class _HommepaggeState extends State<Hommepagge> {

  bool Personal = true, Work = false, Shopping = false ;

  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();

  Stream?todoStream;

  load()async{
    todoStream = await DBService().getTask(Personal?"Personal":Work?"Workplace" : "Shopping");
    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

Widget getWork() {
  return StreamBuilder(
    stream: todoStream,
    builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData
          ? Expanded(
              child: ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot docsnap = snapshot.data.docs[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                     child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Due Date: ${docsnap["Due_Date"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.red.shade400,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                      Text(
                                      docsnap["title"],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                Checkbox(
                                  value: docsnap["Yes"],
                                  activeColor: Colors.blue.shade600,
                                  onChanged: (newvalue) async {
                                    await DBService().checkMethod(
                                      docsnap["id"],
                                      Personal
                                          ? "Personal"
                                          : Work
                                              ? "Workplace"
                                              : "Shopping",
                                      newvalue!,
                                    );
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              docsnap["Subtitle"],
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: docsnap["Priority"] == "High"
                                        ? Colors.red.shade200
                                        : docsnap["Priority"] == "Medium"
                                            ? Colors.orange.shade200
                                            : Colors.green.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    docsnap["Priority"] ?? "Low",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        openEditBox(docsnap);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade400,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Future.delayed(
                                            Duration(seconds: 2));
                                        DBService().Delete(
                                          docsnap["id"],
                                          Personal
                                              ? "Personal"
                                              : Work
                                                  ? "Workplace"
                                                  : "Shopping",
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.red.shade400,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ): Padding(
              padding: EdgeInsets.symmetric(vertical: 200),
              child: Center(child: CircularProgressIndicator()),
            );
       },
    );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        OpenBox();
      },
      backgroundColor: Colors.blue.shade600,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    ),
    body: Container(
      padding: EdgeInsets.only(top: 70),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello,",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Let's get the work started!",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildCategoryButton("Personal", Personal, Colors.blue.shade300),
              buildCategoryButton("Workplace", Work, Colors.orange.shade300),
              buildCategoryButton("Shopping", Shopping, Colors.green.shade300),
            ],
          ), 
          getWork(),
        ],
      ),
    ),
  );
}

Widget buildCategoryButton(String title, bool isSelected, Color color) {
  return GestureDetector(
    onTap: () async {
      if (title == "Personal") {
        Personal = true;
        Work = false;
        Shopping = false;
      } else if (title == "Workplace") {
        Personal = false;
        Work = true;
        Shopping = false;
      } else {
        Personal = false;
        Work = false;
        Shopping = true;
      }
      await load();
      setState(() {});
    },
    child: Material(
      elevation: isSelected ? 5 : 0,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black : Colors.grey.shade600,
          ),
        ),
      ),
    ),
  );
}


Future OpenBox() {
  DateTime? selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  String selectedPriority = "Low";

  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: SingleChildScrollView(
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Task',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue.shade600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  controller: title,
                  decoration: InputDecoration(
                    labelText: 'Task Title',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: subtitle,
                  decoration: InputDecoration(
                    labelText: 'Task Details',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setDialogState(() {
                        selectedDate = pickedDate;
                        dateController.text =
                            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dateController.text.isNotEmpty
                              ? dateController.text
                              : "Select Due Date",
                          style: TextStyle(
                            fontSize: 14,
                            color: dateController.text.isNotEmpty
                                ? Colors.black
                                : Colors.grey.shade600,
                          ),
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: Colors.blue.shade600,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Select Priority:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ChoiceChip(
                      label: Text("High"),
                      labelStyle: TextStyle(
                        color: selectedPriority == "High" ? Colors.white : Colors.black,
                      ),
                      selected: selectedPriority == "High",
                      onSelected: (bool selected) {
                        setDialogState(() {
                          selectedPriority = "High";
                        });
                      },
                      selectedColor: Colors.red.shade400,
                      backgroundColor: Colors.grey.shade200,
                    ),
                    ChoiceChip(
                      label: Text("Medium"),
                      labelStyle: TextStyle(
                        color: selectedPriority == "Medium" ? Colors.white : Colors.black,
                      ),
                      selected: selectedPriority == "Medium",
                      onSelected: (bool selected) {
                        setDialogState(() {
                          selectedPriority = "Medium";
                        });
                      },
                      selectedColor: Colors.orange.shade400,
                      backgroundColor: Colors.grey.shade200,
                    ),
                    ChoiceChip(
                      label: Text("Low"),
                      labelStyle: TextStyle(
                        color: selectedPriority == "Low" ? Colors.white : Colors.black,
                      ),
                      selected: selectedPriority == "Low",
                      onSelected: (bool selected) {
                        setDialogState(() {
                          selectedPriority = "Low";
                        });
                      },
                      selectedColor: Colors.green.shade400,
                      backgroundColor: Colors.grey.shade200,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                   onPressed: () {
                      if (selectedDate != null) {
                        String id = randomAlphaNumeric(10);
                        Map<String, dynamic> userTodo = {
                          "title": title.text,
                          "Subtitle": subtitle.text,
                          "Due_Date": "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day} ${selectedDate!.hour}:${selectedDate!.minute}",
                          "id": id,
                          "Yes": false,
                          "Priority": selectedPriority,
                        };

                        if (Personal) {
                          DBService().addPersonalTask(userTodo, id);
                        } else if (Work) {
                          DBService().addWorkTask(userTodo, id);
                        } else if (Shopping) {
                          DBService().addShopping(userTodo, id);
                        }

                        // Schedule notifications for the task
                        scheduleNotifications(userTodo);

                        title.clear();
                        subtitle.clear();

                        Navigator.pop(context);
                      }
                    },

                    child: Text(
                      "Add Task",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                 ),
            ),
          ),
                ),],
            );},
     ),
  ),
    ),
  );
}


Future openEditBox(DocumentSnapshot docsnap) {
  DateTime? selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController(text: docsnap["title"]);
  TextEditingController subtitleController = TextEditingController(text: docsnap["Subtitle"]);
  TextEditingController dateController = TextEditingController(text: docsnap["Due_Date"]);

  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel),
                  ),
                  SizedBox(width: 60),
                  Text(
                    'Edit Task',
                    style: TextStyle(
                      color: Colors.blue.shade400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: TextField(
                  controller: subtitleController,
                  decoration: InputDecoration(
                    hintText: 'Subtitle',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              TableCalendar(
                firstDay: DateTime.utc(2000),
                lastDay: DateTime.utc(2100),
                focusedDay: selectedDate!,
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) {
                  return isSameDay(selectedDate, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    selectedDate = selectedDay;
                    dateController.text =
                        "${selectedDay.day}-${selectedDay.month}-${selectedDay.year}";
                  });
                },
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
              SizedBox(height: 20),
              
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    hintText: 'Selected Due Date',
                    border: InputBorder.none,
                  ),
                  readOnly: true,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        if (selectedDate != null) {
                          Map<String, dynamic> updatedTask = {
                            "title": titleController.text,
                            "Subtitle": subtitleController.text,
                            "Due_Date": dateController.text,
                          };

                          DBService().updateTask(
                            docsnap["id"],
                            Personal ? "Personal" : Work ? "Workplace" : "Shopping",
                            updatedTask,
                            titleController.text,
                          );

                          Navigator.pop(context);
                        } else {
                          print("No date selected!");
                        }
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

//notification function

Future<void> scheduleNotifications(Map<String, dynamic> taskData) async {
  final Notificationapi notificationApi = Notificationapi();
  DateTime dueDate = DateTime.parse(taskData['Due_Date']);

  
  DateTime oneDayBefore = dueDate.subtract(Duration(days: 1));
  DateTime oneHourBefore = dueDate.subtract(Duration(hours: 1));

  
  DateTime now = DateTime.now();

  
  if (oneDayBefore.isAfter(now)) {
    Future.delayed(oneDayBefore.difference(now), () {
      notificationApi.showLocalNotification(
        "Task Reminder: ${taskData['title']}",
        "Bas ek din baki hai khatam kar yaar!",
      );
    });
  }

  
  if (oneHourBefore.isAfter(now)) {
    Future.delayed(oneHourBefore.difference(now), () {
      notificationApi.showLocalNotification(
        "Task Reminder: ${taskData['title']}",
        "Only 1 hour left to complete your task!",
      );
    }); }
}


}