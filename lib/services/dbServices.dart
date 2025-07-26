import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabb/models/poolModel.dart';
import 'package:vocabb/models/wordModel.dart';

class DbServices {
  static final db = FirebaseFirestore.instance;
  static const POOLS_COLLECTION_NAME = "pools";

  static Future<PoolModel?> createPool(String name, String user, String description) async {
    try {
      Map<String, dynamic> poolInJson = {
        "name": name,
        "user": user,
        "description": description,
        "rating": 0,
        "words": [],
        "totalWordsCount": 0,
        "masteredWordsCount": 0,
        "reviewingWordsCount": 0,
        "learningWordsCount": 0,
        "unvisitedWordsCount": 0
      };
      var document = await db.collection(POOLS_COLLECTION_NAME).add(poolInJson);
      return PoolModel.fromJson(document.id, poolInJson);
    } catch(e) {
      print("Error while adding pool to database");
    }
  }

  static Future<List<PoolModel>?> getAllPools() async {
    try {
      List<PoolModel> pools = [];
      print("Fetching pools");
      db.collection(POOLS_COLLECTION_NAME).get().then(
        (querySnapshot) {
          for (var pool in querySnapshot.docs) {
            pools.add(PoolModel.fromJson(pool.id, pool.data()));
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
  
  static Future<bool> addWordToPoolByPoolName(String poolName, WordModel word) async {
    try {
      print("Adding word ${word.word} to pool $poolName");
      final querySnapshot = await db.collection(POOLS_COLLECTION_NAME)
          .where("name", isEqualTo: poolName).get();
      if (querySnapshot.docs.isEmpty) {
        print("No pool with name $poolName found");
        return false;
      } else {
        final doc = querySnapshot.docs.first.reference;
        await doc.update({
          "words": FieldValue.arrayUnion([word.toJson()]),
        });
        print("Updated pool with new word");
        return true;
      }
    } catch(e) {
      print("Error trying to add a new word ${word.word} to pool $poolName: $e");
      return false;
    }
  }

  static Future<bool> addWordToPoolById(String poolId, WordModel wordModel) async {
    try {
      print("Adding word ${wordModel.word} to pool id: $poolId");
      final docRef = db.collection(POOLS_COLLECTION_NAME).doc(poolId);
      final docSnapshot = await docRef.get();
      int totalWordsCount = docSnapshot.data()!["totalWordsCount"];
      await docRef.update({
        "words": FieldValue.arrayUnion([wordModel.toJson()]),
        "totalWordsCount": totalWordsCount + 1
      });
      print("Updated pool with new word");
      return true;
    } catch(e) {
      print("Error trying to add a new word ${wordModel.word} to pool id $poolId: $e");
      return false;
    }
  }

  static Future<PoolModel?> getPoolByName(String poolName) async {
    try {
      print("Fetching pool details for pool $poolName");
      final querySnapshot = await db.collection(POOLS_COLLECTION_NAME)
          .where("name", isEqualTo: poolName).get();
      if (querySnapshot.docs.isEmpty) {
        print("No pool found with name $poolName");
      } else {
        final poolDoc = querySnapshot.docs.first;
        if (poolDoc.data().isNotEmpty) {
          return PoolModel.fromJson(poolDoc.id, poolDoc.data());
        } else {
          print("Doc not found for pool $poolName");
        }
      }
    } catch (e) {
      print("Error trying to fetch pool $poolName: $e");
    }
  }

  static Stream<DocumentSnapshot> getWordStreamByPoolName(String poolName) {
    return db.collection(POOLS_COLLECTION_NAME)
             .where("name", isEqualTo: poolName)
             .limit(1)
             .snapshots()
             .map((snapshot) => snapshot.docs.first);
  }

  static Future<bool> updatePool(PoolModel poolModel) async {
    try {
      final querySnapshot = await db.collection(POOLS_COLLECTION_NAME)
          .where("name", isEqualTo: poolModel.name).get();
      if (querySnapshot.docs.isEmpty) {
        print("No pool found with name ${poolModel.name}");
        return false;
      } else {
        await querySnapshot.docs.first.reference.set(poolModel.toJson());
        return true;
      }
    } catch (e) {
      print("Error updating pool ${poolModel.name}: $e");
      return false;
    }
  }
}