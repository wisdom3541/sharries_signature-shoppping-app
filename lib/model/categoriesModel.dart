class Categoriesmodel {
  final String? title;
  final String? price;
  final String? imageUrl;
  final bool addedInCart;

  const Categoriesmodel(
      {required this.title,
      required this.price,
      required this.imageUrl,
      required this.addedInCart});

  factory Categoriesmodel.fromJson(Map<String, dynamic> json) {
    var appendurl = json["photos"][0]["url"];
    return Categoriesmodel(
        title: json["name"] as String,
        price: json["current_price"][0]["USD"][0].toString(),
        //imageUrl: json["photos"][0]["url"]);
        imageUrl: "https://api.timbu.cloud/images/$appendurl",
        addedInCart: false);
  }
}
