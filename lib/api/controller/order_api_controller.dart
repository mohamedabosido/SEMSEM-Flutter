import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/Models/product.dart';
import 'package:tokoto/api/api_settings.dart';
import 'package:tokoto/prefs/user_preferences_controller.dart';
import 'package:http/http.dart' as http;

final ordersProvider =
    StateNotifierProvider<GetOrdersFromApi, Map<ProductModel, int>>((ref) {
  return GetOrdersFromApi();
});

class GetOrdersFromApi extends StateNotifier<Map<ProductModel, int>> {
  GetOrdersFromApi() : super({});

  Future<bool> add({
    required ProductModel product,
    required int count,
  }) async {
    var url = Uri.parse(ApiSettings.ORDER);
    var response = await http.post(url, body: {
      'uid': UserPreferencesController().user.id,
      'pid': product.id.toString(),
      'count': count.toString(),
    });
    if (response.statusCode == 201) {
      state = {...state, product: count};
      var url =Uri.parse(
          //it' should delete
          '${ApiSettings.CART}/delete?uid=${UserPreferencesController().user.id}&pid=${product.id}');
      await http.post(url);
    }
    return false;
  }

  Future delete({
    required ProductModel product,
  }) async {
    state.remove(product);
    state = {...state};
    var url = Uri.parse(
        //it' should delete
        '${ApiSettings.ORDER}/delete?uid=${UserPreferencesController().user.id}&pid=${product.id}');
    await http.post(url);
  }
}
