class ProductModel {
  late String? id;
  late String? productName;
  late String? productImage;
  late int? productPrice;

  ProductModel(
      {this.id, this.productName, this.productImage, this.productPrice});

//getting data
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    productName = json["productName"];
    productPrice = json["productPrice"];
    productImage = json["productImage"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data["_id"] = id;
    _data["productName"] = productName;
    _data["productPrice"] = productPrice;
    _data["productImage"] = productImage;
    return _data;
  }
}
