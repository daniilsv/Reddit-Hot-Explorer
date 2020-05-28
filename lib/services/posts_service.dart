import 'package:draw/draw.dart';
import 'package:injectable/injectable.dart';
import 'package:reddit_explorer/app/locator.dart';
import 'package:reddit_explorer/services/reddit.dart';

@lazySingleton
class PostsService {
  final _redditService = locator.getAsync<RedditService>();

  List<Submission> posts(String subreddit) => _posts[subreddit] ?? [];
  final Map<String, String> _after = {};
  final Map<String, List<Submission>> _posts = {};
  Future<List<Submission>> getNextPosts(String subreddit) async {
    Reddit reddit = (await _redditService).reddit;
    Map<String, dynamic> value = await reddit.get('/${subreddit}hot', params: {
      'after': _after.containsKey(subreddit) ? _after[subreddit] : null,
    }) as Map<String, dynamic>;
    if (!_posts.containsKey(subreddit)) _posts[subreddit] = [];
    _posts[subreddit].addAll((value['listing'] as List).cast<Submission>());
    _after[subreddit] = value['after'] as String;
    return _posts[subreddit];
  }
}
