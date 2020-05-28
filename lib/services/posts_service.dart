import 'package:draw/draw.dart';
import 'package:injectable/injectable.dart';
import 'package:reddit_explorer/app/locator.dart';
import 'package:reddit_explorer/services/reddit.dart';

@lazySingleton
class PostsService {
  final _redditService = locator.getAsync<RedditService>();

  final List<Submission> _posts = [];
  List<Submission> get posts => _posts;
  String _after;
  bool get hasPosts => _posts != null && _posts.isNotEmpty;

  Future<List<Submission>> getNextPosts(String subreddit) async {
    Reddit reddit = (await _redditService).reddit;
    Map<String, dynamic> value = await reddit.get('/${subreddit}hot', params: {
      'after': _after,
    }) as Map<String, dynamic>;
    _posts.addAll((value['listing'] as List).cast<Submission>());
    _after = value['after'] as String;
    return _posts;
  }
}
