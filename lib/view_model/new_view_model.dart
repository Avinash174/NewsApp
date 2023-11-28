import 'package:news_app/model/new_channel_headline_model.dart';
import 'package:news_app/resository/new_repository.dart';

class NewsViewModel {
  final _rep = NewRepository();

  Future<NewChannelHeadlineModel> fetchNewsChannelHeadlineApi() async {
    final response = await _rep.fetchNewsChannelHeadlineApi();
    return response;
  }
}
