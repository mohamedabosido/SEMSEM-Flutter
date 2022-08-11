import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/api/api_settings.dart';
import 'package:http/http.dart' as http;

final codeProvider = StateProvider<String>((ref) => '');
final voucherCodeProvider = FutureProvider.autoDispose<double>((ref) async {
  final code = ref.watch(codeProvider);
  var url = Uri.parse('${ApiSettings.CODE}/search/$code');
  var response = await http.get(url);
  var jsonResponse = jsonDecode(response.body);
  var jsonArray = jsonResponse as List;
  return double.parse(jsonArray.first['percentage'].toString());
});
