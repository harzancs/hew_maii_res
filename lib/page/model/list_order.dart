class ListOrder {
  String orderID;
  String orderPrice;
  String orderTime;
  String orderOther;
  String orderStatus;

  ListOrder(String orderID, String orderPrice, String orderTime,
      String orderOther, String orderStatus) {
    this.orderID = orderID;
    this.orderPrice = orderPrice;
    this.orderTime = orderTime;
    this.orderOther = orderOther;
    this.orderStatus = orderStatus;
  }

  ListOrder.fromJson(Map json)
      : orderID = json['order_id'],
        orderPrice = json['order_price'],
        orderTime = json['order_time'],
        orderOther = json['order_other'],
        orderStatus = json['order_status'];

  Map toJson() {
    return {
      orderID: 'orderID',
      orderPrice: 'orderPrice',
      orderTime: 'orderTime',
      orderOther: 'orderOther',
      orderStatus: 'orderStatus'
    };
  }
}
