import 'package:flutter/material.dart';
import 'package:vocabb/models/poolModel.dart';
import 'package:vocabb/services/dbServices.dart';

class PoolsProvider with ChangeNotifier {
  List<PoolModel>? pools;
  bool _hasFetched = false;
  bool _isUpdating = false;

  bool get hasFetched => _hasFetched;
  bool get isUpdating => _isUpdating;
  List<PoolModel>? get getAllPools => pools;
  

  void setIsUpdating(bool isUpdating) {
    _isUpdating = isUpdating;
    notifyListeners();
  }

  void fetchPools() async {
    setIsUpdating(true);
    pools = await DbServices.getAllPools();
    if (pools != null) {
      _hasFetched = true;
    }
    setIsUpdating(false);
  }

  Future<bool> addPool(PoolModel poolModel) async {
    setIsUpdating(true);
    bool response = await DbServices.createPool(poolModel);
    setIsUpdating(false);
    if (response) {
      pools!.add(poolModel);
      return true;
    } else {
      return false;
    }
    
  }
}