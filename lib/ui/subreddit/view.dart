import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:reddit_explorer/ui/submission/view.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:scroll_bottom_navigation_bar/scroll_bottom_navigation_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:supercharged/supercharged.dart';

import 'viewmodel.dart';

class SubredditView extends StatelessWidget {
  SubredditView({Key key, this.subreddit}) : super(key: key);
  final Subreddit subreddit;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostsViewModel>.reactive(
      viewModelBuilder: () => PostsViewModel(subreddit),
      onModelReady: (model) => model.data.isEmpty ? model.loadNext() : null,
      builder: (context, model, child) {
        Widget body = Container();
        if (model.data.isEmpty && model.isBusy)
          body = const Center(child: CircularProgressIndicator());
        else
          body = ListView.builder(
            controller: model.scrollController,
            itemCount: model.data.length + (model.isBusy ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == model.data.length)
                return const Center(child: CircularProgressIndicator());

              Submission submission = model.data[index];
              return SubmissionView(submission: submission);
            },
          );
        return Scaffold(
          backgroundColor: '#DAE0E6'.toColor(),
          appBar: ScrollAppBar(
            backgroundColor: Colors.white,
            controller: model.scrollController, // Note the controller here
            title: Text(
              subreddit.title,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          bottomNavigationBar: ScrollBottomNavigationBar(
            controller: model.scrollController,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.fiber_new),
                title: Text('New'),
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.show_chart),
                title: Text('Hot'),
              ),
            ],
          ),
          body: Snap(
            controller: model.scrollController.bottomNavigationBar,
            child: body,
          ),
        );
      },
    );
  }
}
