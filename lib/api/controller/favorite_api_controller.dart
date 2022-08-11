import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/Models/product.dart';
import 'package:tokoto/api/api_settings.dart';
import 'package:tokoto/prefs/user_preferences_controller.dart';
import 'package:http/http.dart' as http;

final favoritesProvider =
    StateNotifierProvider<GetFavoritesFromApi, List<ProductModel>>((ref) {
  return GetFavoritesFromApi();
});

class GetFavoritesFromApi extends StateNotifier<List<ProductModel>> {
  GetFavoritesFromApi() : super([]) {
    getData();
  }

  Future getData() async {
    var url = Uri.parse(
        '${ApiSettings.FAVORITE}/?uid=${UserPreferencesController().user.id}');
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

  Future add({
    required ProductModel product,
  }) async {
    if(!state.contains(product)){
      state = [...state, product];
    }
    var url = Uri.parse(ApiSettings.FAVORITE);
    await http.post(url, body: {
      'uid': UserPreferencesController().user.id,
      'pid': product.id.toString(),
    });
  }

  Future delete({
    required ProductModel product,
  }) async {
    state = [
      for (final P in state)
        if (P.id != product.id) P,
    ];
    var url = Uri.parse(
      //it' should delete
        '${ApiSettings.FAVORITE}/delete?uid=${UserPreferencesController().user.id}&pid=${product.id}');
    await http.post(url);
  }
}
