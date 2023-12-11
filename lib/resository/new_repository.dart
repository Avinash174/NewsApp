import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/new_channel_headline_model.dart';

class NewRepository {
  Future<NewChannelHeadlineModel> fetchNewsChannelHeadlineApi(
      String chnannelName) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=${chnannelName}&apiKey=092b8ab9a0e44c67b875c9a0d74a2852";
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      log(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
 
      return NewChannelHeadlineModel.fromJson(body);
    }
    throw Exception("Error");
  }

  Future<NewChannelHeadlineModel> fetchNewsCategories(String category) async {
    String url =
        "https://newsapi.org/v2/everything?q=${category}&apiKey=092b8ab9a0e44c67b875c9a0d74a2852";
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      log(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return NewChannelHeadlineModel.fromJson(body);
    }
    throw Exception("Error");
  }
}
