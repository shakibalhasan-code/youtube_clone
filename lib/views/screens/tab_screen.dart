import 'package:flutter/material.dart';
import 'package:my_tube/util/constant.dart';
import 'package:my_tube/views/screens/search/explore_search.dart';
import 'package:my_tube/views/screens/trends_screen/trend_screen.dart';
import 'package:my_tube/views/screens/music/music_screen.dart';
import 'package:my_tube/views/screens/news_screen/news_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Widget> _screens = [
    TrendingScreenVideos(),
    ExploreSearch(),
    const NewsScreen(),
    const MusicScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.3),
      appBar: AppBar(
        backgroundColor: primaryColor.withOpacity(0.3),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("myTube"),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(25), // Ensure the border matches
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed, // Fixed
            backgroundColor:
                primaryColor.withOpacity(0.3), // Make background transparent
            elevation: 3,
            currentIndex: currentIndex,
            selectedItemColor: secondColor,
            unselectedItemColor: Colors.grey.shade700,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.trending_up_rounded),
                label: 'Trending',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article),
                label: 'News',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note),
                label: 'Music',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
