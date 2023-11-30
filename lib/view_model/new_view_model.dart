import 'package:news_app/model/new_channel_headline_model.dart';
import 'package:news_app/resository/new_repository.dart';

class NewsViewModel {
  final _rep = NewRepository();

  Future<NewChannelHeadlineModel> fetchNewsChannelHeadlineApi(
      String channelName) async {
    final response = await _rep.fetchNewsChannelHeadlineApi(channelName);
    return response;
  }

  Future<NewChannelHeadlineModel> fetchNewsCategories(String category) async {
    final response = await _rep.fetchNewsCategories(category);

    return response;
  }
}
