import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controllers/videos_controller.dart';
import 'package:recetas/widgets/video_widget.dart';

class VideoPage extends GetView<VideosController> {
  @override
  Widget build(BuildContext context) {
    final VideosController _controller = Get.put(VideosController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Video Recipe',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          Obx(() => IconButton(
                icon: Icon(controller.isListView.value
                    ? Icons.view_module
                    : Icons.view_list),
                onPressed: () {
                  controller.changeListView();
                },
                color: Colors.orangeAccent,
              ))
        ],
      ),
      body: SingleChildScrollView(child: Obx(() {
        int crossAxisCount = controller.isListView.value ? 1 : 2;
        int aux= controller.isListView.value ? 16 : 30;
        return GridView.builder(
          itemCount: 2, // Aquí se debe reemplazar por la cantidad de videos
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 16 / aux,
            mainAxisSpacing: 2.0,
          ),
          itemBuilder: (context, index) {
            return VideoWidget();
          },
        );
      })),
    );
  }
}
