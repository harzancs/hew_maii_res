class ListOrder {
  String orderID;
  String orderPrice;
  String orderTime;
  String orderOther;

  ListOrder(
      String orderID, String orderPrice,  String orderTime,String orderOther) {
    this.orderID = orderID;
    this.orderPrice = orderPrice;
    this.orderTime = orderTime;
    this.orderOther = orderOther;
  }

  ListOrder.fromJson(Map json)
      : orderID = json['order_id'],
        orderPrice = json['order_price'],
        orderTime = json['order_time'],
        orderOther = json['order_other'];

  Map toJson() {
    return {
      orderID: 'orderID',
      orderPrice: 'orderPrice',
      orderTime: 'orderTime',
      orderOther: 'orderOther'
    };
  }
}
