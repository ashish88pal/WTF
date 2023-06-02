import 'package:dio/dio.dart';

import 'model.dart';

const String BASE_URL = "https://devapi.wtfup.me/gym";

getAllCities() async {
  var res = await Dio().get("${BASE_URL}/cities");
  print(res.data);
}

Future<Autogenerated?> getGymData(
    int page, int count, double lat, double lng) async {
  Autogenerated? data;
  var res = await Dio().get(
      "$BASE_URL/nearestgym/new?page=$page&limit=$count&lat=$lat&long=$lng");

  if (res.statusCode == 200) {
    data = Autogenerated.fromJson(res.data);
  }

  return data;
}
