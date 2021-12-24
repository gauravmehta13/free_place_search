import 'package:dio/dio.dart';
import 'package:free_place_search/models/address.dart';

Future<List<SearchInfo>> addressSuggestion(String searchText,
    {int limitInformation = 5}) async {
  Response response = await Dio().get(
    "https://photon.komoot.io/api/",
    queryParameters: {
      "q": searchText,
      "limit": limitInformation == 0 ? "" : "$limitInformation"
    },
  );
  final json = response.data;
  return (json["features"] as List)
      .map((d) => SearchInfo.fromPhotonAPI(d))
      .toList();
}
