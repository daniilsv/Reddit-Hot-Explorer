import 'package:draw/draw.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_explorer/app/locator.dart';
import 'package:reddit_explorer/services/posts_service.dart';
import 'package:stacked/stacked.dart';

class PostsViewModel extends BaseViewModel {
  PostsViewModel(this.subreddit) : scrollController = ScrollController() {
    scrollController.addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        loadNext();
      }
    });
  }
  final Subreddit subreddit;
  final ScrollController scrollController;
  final _postsService = locator<PostsService>();
  List<Submission> data = [];
  Future<void> loadNext() async {
    setBusy(true);
    data = await _postsService.getNextPosts(subreddit.path);
    setBusy(false);
  }
}
