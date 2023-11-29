import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/new_channel_headline_model.dart';

class NewRepository {
  Future<NewChannelHeadlineModel> fetchNewsChannelHeadlineApi(
      String chnannelName) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=${chnannelName}&apiKey=605863575875479abbca9bdd2c420208";
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
