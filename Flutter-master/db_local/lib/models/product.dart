class Product {
  int? id;
  String? name ;
  String? description ;
  double? unitPrice ;

  Product ( this.id, this.name, this.description , this.unitPrice);
  Map<String , dynamic > toMapProduct() {
  var map = Map<String ,dynamic>();
  map["name"] = name;
  map["description"] = description;
  map["unitPrice"] = unitPrice;
  if(id != null) {
    map["id"] = id;
  }
  return map;
}
 Product.fromObj(dynamic o ) {
    this.id =int.tryParse(o["id"]);
    this.description = o["description"];
    this.name = o["name"];
    this.unitPrice = double.tryParse(o["unitPrice"]) ;
   }
}