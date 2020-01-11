class DataLogin {
  String id;
  String name_res;
  String name_owe;
  String lastname_owe;
  String image_res;

  DataLogin(String id, String name_res, String name_owe, String lastname_owe,
      String image_res) {
    this.id = id;
    this.name_res = name_res;
    this.name_owe = name_owe;
    this.lastname_owe = lastname_owe;
    this.image_res = image_res;
  }

  DataLogin.fromJson(Map json)
      : id = json['res_id'],
        name_res = json['res-name'],
        name_owe = json['res_owe_name'],
        lastname_owe = json['res_owe_lastname'],
        image_res = json['res_image'];

  Map toJson() {
    return {
      'id': id,
      'name_res': name_res,
      'name_owe': name_owe,
      'lastname_owe': lastname_owe,
      'image_res': image_res
    };
  }
}
