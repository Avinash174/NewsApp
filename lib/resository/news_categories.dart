import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/actegories_news_model.dart';

class ChannelCategories {
  Future<CategoriesNewsModel> fetchCategoriesNewsChannel(
      String Categories) async {
    String url =
        'https://newsapi.org/v2/everything?q=${Categories}&apiKey=605863575875479abbca9bdd2c420208';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception("Error");
  }
}
