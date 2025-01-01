import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:my_tube/core/models/video_model.dart';
import 'package:my_tube/getx/home_state.dart';
import 'package:my_tube/getx/seacrch_state.dart';
import 'package:my_tube/util/constant.dart';
import 'package:my_tube/views/screens/trends_screen/widgets/custom_essential.dart';
import 'package:my_tube/views/widgets/items/horizental_video_item.dart';
import 'package:my_tube/views/widgets/items/small_horizental_video_item.dart';

class ExploreSearch extends StatelessWidget {
  ExploreSearch({super.key});

  final TextEditingController _searchController = TextEditingController();
  final SearchState searchState = Get.put(SearchState());
  final TrendState _trendState = Get.put(TrendState());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Now',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    if (_searchController.text.trim().isEmpty) {
                      Get.snackbar(
                          'Error', 'Please input something and try again');
                      return; // Exit the function if the input is invalid
                    }

                    final query = _searchController.text.trim();
                    await searchState.searchVideos(
                        query); // Await the function call for consistency
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              return searchState.searchedVideos.isEmpty
                  ? Row(
                      children: [
                        MyIcon(HeroIcons.arrowTrendingUp),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Top 10 Trend Videos- BD',
                          style: videoTitleStyle.copyWith(color: secondColor),
                        ),
                        // Spacer(),
                        // MyIcon(HeroIcons.chevronDoubleRight),
                      ],
                    )
                  : const SizedBox();
            }),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Obx(() => _buildBody()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (searchState.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    //for search list
    if (searchState.searchedVideos.isNotEmpty) {
      return ListView.builder(
        itemCount: searchState.searchedVideos.length,
        itemBuilder: (context, index) {
          final video = searchState.searchedVideos[index];
          return HorizentalVideoItem(video: video);
        },
      );
    }

    //show progress indicator if loading
    if (_trendState.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    //show top trend videos if trendvideo isnt empty
    if (_trendState.trendVideos.isNotEmpty) {
      return GridView.builder(
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 2.5,
        ),
        itemBuilder: (context, index) {
          final video = _trendState.trendVideos[index];
          return SmallHorizentalVideoItem(video: video);
        },
      );
    }

    //else retrun an text
    return const Center(child: Text('No results found.'));
  }
}
