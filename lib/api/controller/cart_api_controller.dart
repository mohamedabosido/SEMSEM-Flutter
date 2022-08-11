import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/Models/product.dart';
import 'package:tokoto/api/api_settings.dart';
import 'package:tokoto/api/controller/voucher_code_api_controller.dart';
import 'package:tokoto/prefs/user_preferences_controller.dart';
import 'package:http/http.dart' as http;

final cartsProvider =
    StateNotifierProvider<GetCartsFromApi, Map<ProductModel, int>>((ref) {
  return GetCartsFromApi();
});

class GetCartsFromApi extends StateNotifier<Map<ProductModel, int>> {
  GetCartsFromApi() : super({}) {
    getData();
  }

  Future getData() async {
    var url = Uri.parse(
        '${ApiSettings.CART}/?uid=${UserPreferencesController().user.id}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse as List;
      for (int i = 0; i < jsonArray.length; i++) {
        state[ProductModel.fromJson(jsonArray[i]['product'])] =
            jsonArray[i]['count'];
        state = {...state};
      }
    } else {
      //
    }
  }

  Future add({
    required ProductModel product,
    required int count,
  }) async {
    state = {...state, product: count};
    var url = Uri.parse(ApiSettings.CART);
    await http.post(url, body: {
      'uid': UserPreferencesController().user.id,
      'pid': product.id.toString(),
      'count': count.toString(),
    });
  }

  Future delete({
    required ProductModel product,
  }) async {
    state.remove(product);
    state = {...state};
    var url = Uri.parse(
        //it' should delete
        '${ApiSettings.CART}/delete?uid=${UserPreferencesController().user.id}&pid=${product.id}');
    await http.post(url);
  }

  double getTotal() {
    double total = 0;
    state.forEach((key, value) {
      total += value * key.price!;
    });
    total = total - (0 * total / 100);
    return double.parse(total.toStringAsFixed(2));
  }
}

final cartTotalProvider = Provider.autoDispose<AsyncValue<double>>((ref) {
  final cartState = ref.watch(cartsProvider);
  double total = 0;
  return ref.watch(voucherCodeProvider).whenData((data) {
    cartState.forEach((key, value) {
      total += value * key.price!;
    });
    total = total - (data * total / 100);
    return double.parse(total.toStringAsFixed(2));
  });
});
