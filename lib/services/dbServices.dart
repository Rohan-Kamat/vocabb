import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabb/models/poolModel.dart';
import 'package:vocabb/models/wordModel.dart';

class DbServices {
  static final db = FirebaseFirestore.instance;
  static const POOLS_COLLECTION_NAME = "pools";

  static Future<bool> createPool(PoolModel poolModel) async {
    try {
      await db.collection(POOLS_COLLECTION_NAME).add(poolModel.toJson());
      return true;
    } catch(e) {
      print("Error while adding pool to database");
      return false;
    }
  }

  static Future<List<PoolModel>?> getAllPools() async {
    try {
      List<PoolModel> pools = [];
      print("Fetching pools");
      await db.collection(POOLS_COLLECTION_NAME).get().then(
        (querySnapshot) {
          for (var pool in querySnapshot.docs) {
            pools.add(PoolModel.fromJson(pool.data()));
          }
        },
        onError: (e) => print("Error while fetching all Pools: $e")
      );
      print("Fetched all pools from database");
      return pools;
    } catch(e) {
      print("Exception occured on trying to fetch all pools: $e");
    }
  }
}