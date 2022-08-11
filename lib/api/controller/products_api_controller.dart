import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/Models/category.dart';
import 'package:tokoto/Models/product.dart';
import 'package:tokoto/api/api_settings.dart';
import 'package:tokoto/prefs/user_preferences_controller.dart';
import 'package:http/http.dart' as http;

//Get Products List
final productsProvider =
    StateNotifierProvider<GetProductsFromApi, List<ProductModel>>((ref) {
  return GetProductsFromApi();
});

class GetProductsFromApi extends StateNotifier<List<ProductModel>> {
  GetProductsFromApi() : super([]) {
    getData();
  }

  Future getData() async {
    var url = Uri.parse(ApiSettings.PRODUCTS);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse as List;
      for (int i = 0; i < jsonArray.length; i++) {
        state = [...state, ProductModel.fromJson(jsonArray[i])];
      }
    } else {
      //
    }
  }
}

//Get Products about Category List
final categoryProvider =
    FutureProvider.family<List<ProductModel>, int>((ref, cid) async {
  var url = Uri.parse('${ApiSettings.PRODUCTS}/searchByCategory/$cid');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var jsonArray = jsonResponse as List;
    return jsonArray
        .map((jsonObject) => ProductModel.fromJson(jsonObject))
        .toList();
  }
  return [];
});

//Get Search about keyword List
final keywordProvider = StateProvider<String>((ref) => '');
final searchListProvider =
    FutureProvider.autoDispose<List<ProductModel>>((ref) async {
  final keyword = ref.watch(keywordProvider);
  if (keyword.length > 1) {
    var url = Uri.parse('${ApiSettings.PRODUCTS}/search/$keyword');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse as List;
      return jsonArray
          .map((jsonObject) => ProductModel.fromJson(jsonObject))
          .toList();
    }
  }
  return [];
});

//Get Special For You List
final specialForYouProvider =
    StateNotifierProvider<GetSpecialForYou, List<CategoryModel>>((ref) {
  return GetSpecialForYou();
});

class GetSpecialForYou extends StateNotifier<List<CategoryModel>> {
  GetSpecialForYou() : super([]) {
    getSpecialForYou();
  }

  Future getSpecialForYou() async {
    var url = Uri.parse(
        '${ApiSettings.ORDER}?uid=${UserPreferencesController().user.id}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse as List;
      if (jsonArray.isNotEmpty) {
        for (int i = 0; i < jsonArray.length; i++) {
          state = [...state, CategoryModel.fromJson(jsonArray[i])];
        }
      } else {
        var url = Uri.parse(ApiSettings.CATEGORIES);
        var response = await http.get(url);
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          var jsonArray = jsonResponse as List;
          for (int i = 0; i < 3; i++) {
            state = [...state, CategoryModel.fromJson(jsonArray[i])];
          }
        }
      }
    }
  }
}

//Get Popular List
final popularProvider =
    StateNotifierProvider<GetPopularFromApi, List<ProductModel>>((ref) {
  return GetPopularFromApi();
});

class GetPopularFromApi extends StateNotifier<List<ProductModel>> {
  GetPopularFromApi() : super([]) {
    getData();
  }

  Future getData() async {
    var url = Uri.parse(ApiSettings.POPULAR);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse as List;
      for (int i = 0; i < jsonArray.length; i++) {
        state = [...state, ProductModel.fromJson(jsonArray[i])];
      }
    }
  }
}
