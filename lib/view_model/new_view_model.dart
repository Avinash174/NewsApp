import 'package:news_app/model/actegories_news_model.dart';
import 'package:news_app/model/new_channel_headline_model.dart';
import 'package:news_app/resository/new_repository.dart';
import 'package:news_app/resository/news_categories.dart';

class NewsViewModel {
  final _rep = NewRepository();
  final _reposistory = ChannelCategories();

  Future<NewChannelHeadlineModel> fetchNewsChannelHeadlineApi(
      String channelName) async {
    final response = await _rep.fetchNewsChannelHeadlineApi(channelName);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsChannel(
      String category) async {
    final response = await _reposistory.fetchCategoriesNewsChannel(category);
    return response;
  }
}
