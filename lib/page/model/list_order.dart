class ListOrder {
  String orderID;
  String orderPrice;
  String orderTime;

  ListOrder(
      String orderID, String orderPrice,  String orderTime) {
    this.orderID = orderID;
    this.orderPrice = orderPrice;
    this.orderTime = orderTime;
  }

  ListOrder.fromJson(Map json)
      : orderID = json['order_id'],
        orderPrice = json['order_price'],
        orderTime = json['order_time'];

  Map toJson() {
    return {
      orderID: 'orderID',
      orderPrice: 'orderPrice',
      orderTime: 'orderTime'
    };
  }
}
