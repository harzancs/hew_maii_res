import 'dart:convert';

class DataOrderDetail {
  String foodName;
  String foodNum;

  DataOrderDetail(String foodName, String foodNum) {
    this.foodName = foodName;
    this.foodNum = foodNum;
  }

  DataOrderDetail.fromJson(Map json) 
    :foodName = json['food_name'],
      foodNum = json['food_num'];
  
        

  Map toJson() {
    return {
      foodName: "foodName",
      foodNum: 'foodNum'
    };
  }
}
