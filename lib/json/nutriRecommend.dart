Product _$nutriStatFromJson(Map<String, dynamic> json) {
  var aas = json['amino-acids'] as List;
  List<Suppl> aaList = aas.map((i) => Suppl.fromJson(i)).toList();
  var vits = json['vitamins'] as List;
  List<Suppl> vitList = vits.map((i) => Suppl.fromJson(i)).toList();
  var mins = json['minerals'] as List;
  List<Suppl> minList = mins.map((i) => Suppl.fromJson(i)).toList();

  return Product(
    aminoAcid: aaList,
    vitamin: vitList,
    mineral: minList,
    username: json['name'] as String,
  );
}

class Product {
  final List<Suppl> aminoAcid;
  final List<Suppl> vitamin;
  final List<Suppl> mineral;
  final String username;

  Product(
      {required this.aminoAcid,
      required this.vitamin,
      required this.mineral,
      required this.username});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$nutriStatFromJson(json);
  // Map<String, dynamic> toJson() => _$nutriStatToJson(this);

}

class Suppl {
  final String title;
  final String url;
  final int price;

  Suppl({required this.title, required this.url, required this.price});

  factory Suppl.fromJson(Map<String, dynamic> json) {
    return Suppl(
      title: json['title'] as String,
      url: json['nutrsuppl_url'] as String,
      price: json['price'] as int,
    );
  }
}
