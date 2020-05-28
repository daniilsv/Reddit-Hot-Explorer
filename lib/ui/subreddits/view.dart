import 'package:cached_network_image/cached_network_image.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reddit_explorer/ui/subreddit/view.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:scroll_bottom_navigation_bar/scroll_bottom_navigation_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:supercharged/supercharged.dart';

import 'viewmodel.dart';

class SubredditsView extends StatelessWidget {
  const SubredditsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubredditsViewModel>.reactive(
      viewModelBuilder: () => SubredditsViewModel(),
      onModelReady: (model) => model.loadNext(),
      builder: (context, model, child) {
        Widget body = Container();
        if (model.data.isEmpty && model.isBusy)
          body = const Center(child: CircularProgressIndicator());
        else
          body = ListView.separated(
            separatorBuilder: (c, i) => const Divider(),
            controller: model.scrollController,
            itemCount: model.data.length + (model.isBusy ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == model.data.length)
                return const Center(child: CircularProgressIndicator());

              Subreddit subreddit = model.data[index];
              String color = subreddit.data['primary_color'].toString();
              if (color == '') color = null;

              return ListTile(
                title: Text(subreddit.title),
                subtitle: Text(
                  '${subreddit.data['display_name_prefixed'].toString()}'
                  '\n${subreddit.data['subscribers'].toString()} subs.',
                ),
                leading: buildLeading(context,
                    subreddit.data['header_img'].toString(), color?.toColor()),
                onTap: () {
                  Get.to<void>(SubredditView(subreddit: subreddit));
                },
              );
            },
          );
        return Scaffold(
          backgroundColor: '#DAE0E6'.toColor(),
          appBar: ScrollAppBar(
            backgroundColor: Colors.white,
            controller: model.scrollController, // Note the controller here
            title: Row(
              children: [
                SvgPicture.asset(
                  'assets/reddit.svg',
                  fit: BoxFit.fitHeight,
                  height: kToolbarHeight - 20,
                ),
                const SizedBox(width: 12),
                const Flexible(
                  child: Text(
                    'Hot',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
          ),
          bottomNavigationBar: ScrollBottomNavigationBar(
            controller: model.scrollController,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                  icon: Icon(Icons.ac_unit), title: Text('')),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.access_alarms), title: Text('')),
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

  Widget buildLeading(BuildContext context, String imageUrl, Color color) {
    if (imageUrl == '') return const SizedBox(width: 36, height: 36);
    return Container(
      width: 36,
      height: 36,
      decoration: color == null
          ? null
          : BoxDecoration(
              border: Border.all(color: color),
            ),
      padding: const EdgeInsets.all(2),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        alignment: Alignment.center,
      ),
    );
  }
}
