import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabb/models/poolModel.dart';

class DbServices {

  static Future<bool> createPool(PoolModel poolModel) async {
     var db = FirebaseFirestore.instance;
    try {
      await db.collection("pools").add(poolModel.toMap());
      return true;
    } catch(e) {
      print("Error while adding pool to database");
      return false;
    }
  }
}