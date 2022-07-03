import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:vdo_app/model/json_data.dart';
import 'package:vdo_app/model/video_data.dart';
import 'package:vdo_app/screens/VideoScreen.dart';
import 'package:vdo_app/widgets/video_tile.dart';

class VideoList extends StatefulWidget {
  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ReadJsonData(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text("${data.error}"));
        } else if (data.hasData) {
          var items = data.data as List<VideoDataModel>;
          return InViewNotifierList(
              isInViewPortCondition:
                  (deltaTop, deltaBottom, viewPortDimension) {
                return deltaTop > (0.012 * viewPortDimension) &&
                    deltaBottom < (0.62 * viewPortDimension);
              },
              itemCount: items.length,
              builder: (context, index) {
                return InViewNotifierWidget(
                  id: index.toString(),
                  builder: (context, inView, _) {
                    final videoUrl = items[index].videoURL ?? '';
                    final imageUrl = items[index].coverPicture ?? '';
                    return GestureDetector(
                      child: Card(
                        elevation: 10,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 200,
                              width: double.maxFinite,
                              child: VideoTile(
                                videoUrl: videoUrl,
                                playVideo: inView,
                                imageUrl: imageUrl,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    items[index].title.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoScreen(
                              name: items[index].title.toString(),
                              mediaURL: items[index].videoURL.toString(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              });
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
