import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reddit_explorer/app/locator.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:scroll_bottom_navigation_bar/scroll_bottom_navigation_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supercharged/supercharged.dart';

import 'viewmodel.dart';

class SubmissionView extends StatelessWidget {
  SubmissionView({Key key, this.submission}) : super(key: key);
  final Submission submission;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubmissionViewModel>.reactive(
      viewModelBuilder: () => SubmissionViewModel(submission),
      builder: (context, model, child) {
        Widget media = Container();
        if (model.chewieController != null) {
          media = Chewie(controller: model.chewieController);
        } else if (submission.preview != null)
          media = CachedNetworkImage(
            imageUrl:
                submission?.preview?.firstOrNull()?.source?.url?.toString() ??
                    '',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          );
        return Card(
          elevation: 4,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  submission.title,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                width: double.infinity,
                child: media,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_upward),
                  Text(formatNum(submission.upvotes)),
                  const SizedBox(width: 5),
                  const Icon(Icons.comment),
                  Text(formatNum(submission.data['num_comments'] as int)),
                  const SizedBox(width: 5),
                  const Icon(Icons.access_time),
                  Text(formatTime(submission.data['created_utc'] as double)),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () {
                      locator<DialogService>().showDialog(
                        title: 'Really Cool submission',
                        description: submission.title,
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget buildLeading(BuildContext context, String imageUrl) {
    if (imageUrl == '') return const SizedBox(width: 36, height: 36);
    return Container(
      width: 36,
      height: 36,
      padding: const EdgeInsets.all(2),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        alignment: Alignment.center,
      ),
    );
  }
}

String formatNum(int _num) {
  if (_num < 1000) return _num.toString();
  if (_num < 1000000) return '${(_num / 100).truncate() / 10}K';
  return '${(_num / 100000).truncate() / 10}M';
}

String formatTime(double _utc) {
  DateTime dt =
      DateTime.fromMillisecondsSinceEpoch(_utc.truncate() * 1000, isUtc: true)
          .toLocal();
  Duration dur = DateTime.now().difference(dt);
  if (dur.inHours < 1) return '${dur.inMinutes}m';
  if (dur.inDays < 1) return '${dur.inHours}h';
  return '${dur.inDays}d';
}
