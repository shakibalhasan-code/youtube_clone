import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:intl/intl.dart';
import 'package:my_tube/core/models/video_model.dart' as video_model;

class PlayVideoState extends GetXState {
  final isVideo = true.obs;
  var isLoading = false.obs;
  var message = ''.obs;
  var audioUrl = ''.obs;

  var isShowDescription = false.obs;
  var isLoadingDes = false.obs;
  var publishedDate = ''.obs;
  var uploadDate = ''.obs;
  var description = ''.obs;

  var nextClickedVideo = ''.obs;

  RxList<video_model.Video> releatedVideos = <video_model.Video>[].obs;
  var isRelLoading = false.obs;

  var yt = YoutubeExplode();

  Future<void> initialAudio(String? videoId) async {
    if (videoId == null || videoId.isEmpty) {
      Get.snackbar('Error', 'Video Not Found');
      return;
    }

    isLoading.value = true;
    try {
      var manifest = await yt.videos.streams.getManifest(videoId);
      var selectedStream =
          manifest.audioOnly.firstWhere((stream) => stream.tag == 140);
      audioUrl.value = selectedStream.url.toString();
    } catch (e) {
      message.value = 'Failed to load audio: $e';
      Get.snackbar('Error', message.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> initVideoInfo(String? videoId) async {
    if (videoId == null || videoId.isEmpty) {
      Get.snackbar('Error', 'Video Not Found');
      return;
    }

    isLoadingDes.value = true;
    try {
      final video = await yt.videos.get(videoId);
      initRelVideo(video);
      description.value = video.description ?? 'No description available';
      publishedDate.value = formatPublishedAt(video.publishDate);
      uploadDate.value = formatPublishedAt(video.uploadDate);
    } catch (e) {
      message.value = 'Failed to load video info: $e';
      Get.snackbar('Error', message.value);
    } finally {
      isLoadingDes.value = false;
    }
  }

  Future<void> initRelVideo(video) async {
    try {
      isRelLoading.value = true;
      var relatedVideos = await yt.videos.getRelatedVideos(video);
      releatedVideos.assignAll(relatedVideos!.map((video) {
        return video_model.Video(
          id: video.id.toString(),
          title: video.title,
          thumbnailUrl: video.thumbnails.highResUrl,
          channelTitle: video.author,
          duration: video_model.Video.parseDuration(
              video.duration?.inSeconds.toString() ?? '0'),
          viewCount: video_model.Video.formatNumber(
              video.engagement.viewCount.toString()),
          likeCount: video_model.Video.formatNumber(
              video.engagement.likeCount?.toString() ?? '0'),
        );
      }).toList());
      isRelLoading.value = false;
    } catch (e) {
      print('rel: $e');
    } finally {
      isRelLoading.value = false;
    }
  }

  void nextViewClicked(String videoId) async {
    nextClickedVideo.value = videoId;
  }

  static String formatPublishedAt(DateTime? dateTime) {
    if (dateTime == null) return 'No Data';
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');
    return dateFormat.format(dateTime.toLocal());
  }
}
