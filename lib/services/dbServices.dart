import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabb/consts/enums.dart';
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

  static Future<bool> addWordToPoolById(String poolId, WordModel wordModel) async {
    try {
      print("Adding word ${wordModel.word} to pool id: $poolId");
      final docRef = db.collection(POOLS_COLLECTION_NAME).doc(poolId);
      final docSnapshot = await docRef.get();
      int totalWordsCount = docSnapshot.data()!["totalWordsCount"];
      int unvisitedWordsCount = docSnapshot.data()!["unvisitedWordsCount"];
      await docRef.update({
        "words": FieldValue.arrayUnion([wordModel.toJson()]),
        "totalWordsCount": totalWordsCount + 1,
        "unvisitedWordsCount": unvisitedWordsCount + 1
      });
      print("Updated pool with new word");
      return true;
    } catch(e) {
      print("Error trying to add a new word ${wordModel.word} to pool id $poolId: $e");
      return false;
    }
  }

  static Future<PoolModel?> getPoolById(String poolId) async {
    try {
      print("Fetching pool details for pool id: $poolId");
      final docRef = db.collection(POOLS_COLLECTION_NAME).doc(poolId);
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        print("The pool with ID: $poolId does not exist.");
      } else if (docSnapshot.data() == null || docSnapshot.data()!.isEmpty) {
        print("Pool with ID: $poolId has no data");
      } else {
        return PoolModel.fromJson(docRef.id, docSnapshot.data()!);
      }
    } catch (e) {
      print("Error trying to fetch pool with ID: $poolId: $e");
    }
  }

  static Future<bool> updatePool(PoolModel poolModel) async {
    try {
      final docRef = db.collection(POOLS_COLLECTION_NAME)
          .doc(poolModel.id);
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        print("No pool found with name ${poolModel.name}");
        return false;
      } else {
        await docRef.set(poolModel.toJson());
        return true;
      }
    } catch (e) {
      print("Error updating pool ${poolModel.name}: $e");
      return false;
    }
  }

  static Future<bool> deleteWordFromPoolById(String poolId, WordModel wordModel) async {
    try {
      final docSnapshot = await db.collection(POOLS_COLLECTION_NAME)
                            .doc(poolId)
                            .get();

      if (!docSnapshot.exists) {
        print("Pool $poolId not found");
        return false;
      }

      var wordsList = docSnapshot.data()!['words'] as List<dynamic>? ?? [];
      int totalWordsCount = docSnapshot.data()!["totalWordsCount"];
      String learningStatusField = switch(wordModel.learningStatus) {
        LearningStatus.mastered => "masteredWordsCount",
        LearningStatus.learning => "learningWordsCount",
        LearningStatus.reviewing => "reviewingWordsCount",
        LearningStatus.unknown => "unvisitedWordsCount"
      };
      int learningStatusFieldCount = docSnapshot.data()![learningStatusField];
      Map<String, dynamic>? wordToDelete = wordsList.firstWhere(
        (wordJson) => wordJson['word'].toLowerCase() == wordModel.word.toLowerCase(),
        orElse: () => null,
      ) as Map<String, dynamic>?;

      if (wordToDelete == null) {
        print("Word ${wordModel.word} not found in pool $poolId");
        return false;
      }

      await db.collection(POOLS_COLLECTION_NAME)
          .doc(poolId)
          .update({
            "words": FieldValue.arrayRemove([wordToDelete]),
            "totalWordsCount": totalWordsCount - 1,
            learningStatusField: learningStatusFieldCount - 1
          });

      return true;
    } catch (e) {
      print("Error deleting word ${wordModel.word} from pool $poolId: $e");
      return false;
    }
  }
}