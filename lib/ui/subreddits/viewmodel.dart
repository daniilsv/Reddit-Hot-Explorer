import 'package:draw/draw.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_explorer/app/locator.dart';
import 'package:reddit_explorer/services/subreddits.dart';
import 'package:stacked/stacked.dart';

class SubredditsViewModel extends BaseViewModel {
  SubredditsViewModel() : scrollController = ScrollController() {
    scrollController.addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        loadNext();
      }
    });
  }
  final ScrollController scrollController;
  final _subredditsService = locator<SubredditsService>();
  List<Subreddit> data = [];
  Future<void> loadNext() async {
    setBusy(true);
    data = await _subredditsService.getNextSubreddits();
    setBusy(false);
  }
}
