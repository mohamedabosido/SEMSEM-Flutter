import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/Models/category.dart';
import 'package:http/http.dart' as http;
import 'package:tokoto/api/api_settings.dart';

final categoriesProvider =
StateNotifierProvider<GetCategoriesFromApi, List<CategoryModel>>((ref) {
  return GetCategoriesFromApi();
});

class GetCategoriesFromApi extends StateNotifier<List<CategoryModel>> {
  GetCategoriesFromApi() : super([]) {
    getData();
  }

  Future getData() async {
    var url = Uri.parse(ApiSettings.CATEGORIES);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse as List;
      for (int i = 0; i < jsonArray.length; i++) {
        state = [...state, CategoryModel.fromJson(jsonArray[i])];
      }
    } else {
        //
    }
  }
}
