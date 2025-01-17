
import 'package:cloud_firestore/cloud_firestore.dart';

class DBService{
  Future addTask(Map<String,dynamic> userTask, String id)async{
    return await FirebaseFirestore.instance.collection("Task").doc(id).set(userTask);
  }

  Future retreveTask(String task)async{
    return await FirebaseFirestore.instance.collection(task).snapshots();
  }
}

