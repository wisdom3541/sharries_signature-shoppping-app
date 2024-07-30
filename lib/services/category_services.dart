import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:sharries_signature/model/categoriesModel.dart';
import 'package:http/http.dart' as http;

class CategoryServices {
  final String catergorySection;

  const CategoryServices({required this.catergorySection});
  Future<List<Categoriesmodel>> fetchCategoryDetails() async {
    final response = await http.get(Uri.parse(
        "https://api.timbu.cloud/products?organization_id=948bfff2d9814413b87042ea4492956e&reverse_sort=false&page=1&size=50&Appid=NHNNOHE1SCV6BNR&Apikey=3183ab50907e416893b594661287573120240704202043445117"));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var productsJson = jsonResponse["items"] as List;

      List<dynamic> justForYouCatergory = [];
      List<dynamic> dealsCatergory = [];
      List<dynamic> youmightlikeCatergory = [];

      for (int i = 0; productsJson.length > i; i++) {
        if (productsJson[i]["categories"].isNotEmpty) {
          var dir = productsJson[i]["categories"][0]["name"];
          if (dir == "justforyou") {
            justForYouCatergory.add(productsJson[i]);
          } else if (dir == "deals") {
            dealsCatergory.add(productsJson[i]);
            //add if case for other categories
          } else if (dir == "youmightlike") {
            youmightlikeCatergory.add(productsJson[i]);
            print(youmightlikeCatergory.length);
          }
        } else {
          print("no category");
        }
      }

      var catergoryList = justForYouCatergory
          .map((catergory) => Categoriesmodel.fromJson(catergory))
          .toList();

      var dealsList = dealsCatergory
          .map((category) => Categoriesmodel.fromJson(category))
          .toList();

      var mightLikeList = youmightlikeCatergory
          .map((category) => Categoriesmodel.fromJson(category))
          .toList();

      if (catergorySection == "justforyou") {
        print(catergoryList[0].imageUrl);
        return catergoryList;
      } else if (catergorySection == "deals") {
        print(catergoryList[0].imageUrl);
        return dealsList;
      } else if (catergorySection == "youmightlike") {
        return mightLikeList;
      } else {
        return catergoryList;
      }
    } else {
      throw Exception("Failed");
    }
  }
}
