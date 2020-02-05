class DataFoodDetail {
  String foodId;
  String foodName;
  String foodPrice;
  String foodUsing;

  DataFoodDetail(String foodId, String foodName, String foodPrice) {
    this.foodId = foodId;
    this.foodName = foodName;
    this.foodPrice = foodPrice;
    this.foodUsing = foodUsing;
  }

  DataFoodDetail.fromJson(Map json)
      : foodId = json['food_id'],
        foodName = json['food_name'],
        foodPrice = json['food_price'],
        foodUsing = json['food_using'];

  Map toJson() {
    return {
      foodId: 'foodId',
      foodName: "foodName",
      foodPrice: 'foodPrice',
      foodUsing: 'foodUsing'
    };
  }
}