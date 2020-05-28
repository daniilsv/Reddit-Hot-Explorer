import 'package:draw/draw.dart';
import 'package:stacked/stacked.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class SubmissionViewModel extends BaseViewModel {
  SubmissionViewModel(this.submission) {
    if (submission.isVideo == true) {
      videoPlayerController = VideoPlayerController.network(
        submission.data['media']['reddit_video']['hls_url'] as String,
      );

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        allowMuting: true,
        showControls: true,
        looping: true,
        autoInitialize: true,
      );
    }
  }
  @override
  void dispose() {
    if (videoPlayerController != null) videoPlayerController.dispose();
    if (chewieController != null) chewieController.dispose();
    super.dispose();
  }

  final Submission submission;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
}
