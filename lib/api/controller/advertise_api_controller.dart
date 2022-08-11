import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/Models/advertise.dart';
import 'package:tokoto/api/api_settings.dart';
import 'package:http/http.dart' as http;

final advertiseProvider =
StateNotifierProvider<GetAdvertiseFromApi, List<AdvertiseModel>>((ref) {
  return GetAdvertiseFromApi();
});

class GetAdvertiseFromApi extends StateNotifier<List<AdvertiseModel>> {
  GetAdvertiseFromApi() : super([]) {
    getData();
  }

  Future getData() async {
    var url = Uri.parse(ApiSettings.ADVERTISE);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse as List;
      for (int i = 0; i < jsonArray.length; i++) {
        state = [...state, AdvertiseModel.fromJson(jsonArray[i])];
      }
    }
  }
}