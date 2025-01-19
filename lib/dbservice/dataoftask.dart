
import 'package:cloud_firestore/cloud_firestore.dart';

class DBService{
  Future addPersonalTask(Map<String,dynamic> userTask, String id)async{
    return await FirebaseFirestore.instance.collection("Personal").doc(id).set(userTask);
  }
  Future addWorkTask(Map<String,dynamic> userTask, String id)async{
    return await FirebaseFirestore.instance.collection("Workplace").doc(id).set(userTask);
  }
  Future addShopping(Map<String,dynamic> userTask, String id)async{
    return await FirebaseFirestore.instance.collection("Shopping").doc(id).set(userTask);
  }
}

