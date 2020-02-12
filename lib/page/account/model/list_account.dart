class ListAccount {
  String orderDate;
  String orderCount;
  String orderSum;

  ListAccount(String orderID, String orderPrice, String orderTime,
      String orderOther, String orderStatus) {
    this.orderDate = orderDate;
    this.orderCount = orderCount;
    this.orderSum = orderSum;
  }

  ListAccount.fromJson(Map json)
      : orderDate = json['date_order'],
        orderCount = json['count_order'],
        orderSum = json['sum_order'];

  Map toJson() {
    return {
      orderDate: 'orderDate',
      orderCount: 'orderCount',
      orderSum: 'orderSum'
    };
  }
}
