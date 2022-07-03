import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vdo_app/widgets/video_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            title: Row(
              children: [
                Icon(
                  Icons.play_circle_filled_sharp,
                  color: Colors.yellow,
                ),
                Text('Vdo App'),
              ],
            ),
          ),
        ],
        body: VideoList(),
      ),
    );
  }
}
