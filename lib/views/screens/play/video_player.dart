import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:heroicons/heroicons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:marquee/marquee.dart';
import 'package:my_tube/core/models/video_model.dart' as video_model;
import 'package:my_tube/getx/play_video_state.dart';
import 'package:my_tube/util/constant.dart';
import 'package:my_tube/views/screens/play/position_data.dart';
import 'package:my_tube/views/screens/play/widgets/audio_controller.dart';
import 'package:my_tube/views/screens/play/widgets/content_counter.dart';
import 'package:my_tube/views/screens/play/widgets/suggested_video_item.dart';
import 'package:my_tube/views/screens/trends_screen/widgets/custom_essential.dart';
import 'package:my_tube/views/widgets/custom_rounded_shape.dart';
import 'package:my_tube/views/widgets/items/horizental_video_item.dart';
import 'package:my_tube/views/widgets/marquee_text_widget.dart';
import 'package:y_player/y_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:rxdart/rxdart.dart' as rx_dart;

class VideoPlayerScreen extends StatefulWidget {
  final video_model.Video video;
  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late String videoId;
  final PlayVideoState _playVideoState = Get.put(PlayVideoState());
  late YoutubeExplode _yt;
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    videoId = widget.video.id;
    if (!_playVideoState.isVideo.value) {
      initAudio();
    }
    _playVideoState.initVideoInfo(videoId);
  }

  Future<void> initAudio() async {
    if (_playVideoState.isVideo.value == false && videoId != null) {
      await _playVideoState.initialAudio(videoId);
      // Define the media item metadata
      MediaItem mediaItem = MediaItem(
        id: _playVideoState.audioUrl.value, // Unique ID for the media item
        title: widget.video.title,
        album: widget.video.channelTitle,

        artUri: Uri.parse(widget.video.thumbnailUrl), // Optional artwork URI
        playable: true,
      );

      // Attach the MediaItem as a tag to the AudioSource
      final audioSource = AudioSource.uri(
        Uri.parse(_playVideoState.audioUrl.value),
        tag: mediaItem,
      );

      // Set the AudioSource for the player
      await player.setAudioSource(audioSource);
      player.play();
    }
  }

  Stream<PositionData> get _positionData =>
      rx_dart.Rx.combineLatest3<Duration, Duration, Duration, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream.cast<Duration>(),
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));
  @override
  void dispose() {
    player.dispose();
    _playVideoState.isShowDescription.value =
        !_playVideoState.isShowDescription.value;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.3),
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: secondColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return _playVideoState.isVideo.value
                  ? video_view()
                  : audio_view();
            }),
            const SizedBox(
              height: 8,
            ),
            Obx(() {
              return _playVideoState.isVideo.value
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.video.title,
                        style: videoTitleStyle.copyWith(color: Colors.white),
                      ),
                    )
                  : SizedBox();
            }),
            const SizedBox(height: 10),
            SizedBox(
              height: 30,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContentCounter(
                      heroIcon: HeroIcons.eye,
                      textData: widget.video.viewCount),
                  const Spacer(),
                  ContentCounter(
                      heroIcon: HeroIcons.handThumbUp,
                      textData: widget.video.likeCount)
                ],
              ),
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondColor.withOpacity(0.3),
                            ),
                            onPressed: () async {
                              _playVideoState.isVideo.value =
                                  !_playVideoState.isVideo.value;
                              initAudio();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(() {
                                  return _playVideoState.isLoading.value
                                      ? SizedBox()
                                      : MyIcon(HeroIcons.musicalNote);
                                }),
                                const SizedBox(width: 10),
                                Obx(() {
                                  return _playVideoState.isLoading.value
                                      ? Center(
                                          child:
                                              const CircularProgressIndicator())
                                      : Text(
                                          _playVideoState.isVideo.value
                                              ? 'Switch to Audio'
                                              : 'Switch to Video',
                                          style: textMedium.copyWith(
                                              color: secondColor),
                                        );
                                }),
                              ],
                            )),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.withOpacity(0.3),
                                foregroundColor: Colors.white),
                            onPressed: () async {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(() {
                                  return _playVideoState.isLoading.value
                                      ? SizedBox()
                                      : Icon(
                                          Icons.download_rounded,
                                          color: Colors.white,
                                        );
                                }),
                                const SizedBox(width: 10),
                                Obx(() {
                                  return _playVideoState.isLoading.value
                                      ? Center(
                                          child:
                                              const CircularProgressIndicator())
                                      : Text(
                                          _playVideoState.isVideo.value
                                              ? 'Download Video'
                                              : 'Download Audio',
                                          style: textMedium.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        );
                                }),
                              ],
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Obx(() {
                    return InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        _playVideoState.isShowDescription.value =
                            !_playVideoState.isShowDescription.value;
                      },
                      child: CustomRoundedShape(
                        color: secondColor.withOpacity(0.3),
                        borderRadius: 25,
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Description',
                                      style: textMedium.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          _playVideoState
                                                  .isShowDescription.value =
                                              !_playVideoState
                                                  .isShowDescription.value;
                                        },
                                        icon: Icon(
                                          _playVideoState
                                                  .isShowDescription.value
                                              ? Icons.arrow_drop_up_rounded
                                              : Icons.arrow_drop_down_rounded,
                                          color: Colors.white,
                                          size: 32,
                                        ))
                                  ],
                                ),
                                if (_playVideoState.isLoadingDes.value &&
                                    _playVideoState.isShowDescription.value)
                                  Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                if (_playVideoState.isShowDescription.value)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Published: ${_playVideoState.publishedDate.value}',
                                        style: textMedium.copyWith(
                                            color: secondColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Text(
                                      //   'Uploaded: ${_playVideoState.uploadDate.value}',
                                      //   style: textMedium.copyWith(
                                      //       color: secondColor,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                      Text(_playVideoState.description.value,
                                          style: textMedium.copyWith(
                                              color: Colors.white
                                                  .withOpacity(0.5))),
                                    ],
                                  )
                              ],
                            )),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 07,
                    color: Colors.grey[800],
                  ),
                  Text(
                    'Rleated Videos',
                    style: textMedium.copyWith(
                        color: secondColor, fontWeight: FontWeight.bold),
                  ),
                  Obx(() {
                    return _playVideoState.isRelLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height *
                                  0.4, // 40% of screen height
                            ),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: _playVideoState.releatedVideos.length,
                              itemBuilder: (context, index) {
                                return SuggestedVideoItem(
                                  clicked: () {
                                    videoId =
                                        _playVideoState.nextClickedVideo.value;
                                  },
                                  video: _playVideoState.releatedVideos[index],
                                );
                              },
                            ),
                          );
                  })
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Container audio_view() => Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.video.thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              MarqueeTextWidget(text: widget.video.title),
              StreamBuilder<PositionData>(
                  stream: _positionData,
                  builder: (context, snapshot) {
                    final positionData = snapshot.data;
                    return ProgressBar(
                      barHeight: 8,
                      baseBarColor: Colors.grey[600],
                      bufferedBarColor: Colors.grey,
                      progressBarColor: secondColor,
                      thumbColor: secondColor,
                      timeLabelTextStyle: textMedium.copyWith(
                          color: secondColor, fontWeight: FontWeight.bold),
                      progress: positionData?.position ?? Duration.zero,
                      buffered: positionData?.bufferedPosition ?? Duration.zero,
                      total: positionData?.duration ?? Duration.zero,
                      onSeek: player.seek,
                    );
                  }),
              const SizedBox(
                height: 5,
              ),
              AudioController(player: player)
            ],
          ),
        ),
      );

  YPlayer video_view() {
    return YPlayer(
      color: secondColor,
      youtubeUrl: 'https://www.youtube.com/watch?v=$videoId',
      onStateChanged: (status) {
        print('Player Status: $status');
      },
      onProgressChanged: (position, duration) {
        print('Progress: ${position.inSeconds}/${duration.inSeconds}');
      },
      onControllerReady: (controller) {
        print('Controller is ready!');
      },
    );
  }
}
