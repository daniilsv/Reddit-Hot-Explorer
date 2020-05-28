import 'package:draw/draw.dart';
import 'package:injectable/injectable.dart';
import 'package:reddit_explorer/app/locator.dart';
import 'package:reddit_explorer/services/reddit.dart';

@lazySingleton
class SubredditsService {
  final _redditService = locator.getAsync<RedditService>();

  final List<Subreddit> _subreddits = [];
  List<Subreddit> get subreddits => _subreddits;
  String _after;
  bool get hasPosts => _subreddits != null && _subreddits.isNotEmpty;

  Future<List<Subreddit>> getNextSubreddits() async {
    Reddit reddit = (await _redditService).reddit;
    Map<String, dynamic> value =
        await reddit.get('/subreddits/popular', params: {
      'after': _after,
    }) as Map<String, dynamic>;
    _subreddits.addAll((value['listing'] as List).cast<Subreddit>());
    _after = value['after'] as String;
    return _subreddits;
  }
}
