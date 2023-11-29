import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullImageSlider extends StatelessWidget {
  final String photo;

  FullImageSlider({required this.photo});

  @override
  Widget build(BuildContext context) {
    var imageBaseUrl = "https://codzshop.com/myapp/";

    final String photoData = photo;
    List<String> photoPaths = photoData.split(',');

    List<PhotoViewGalleryPageOptions> photoViewGalleryPageOptionsList = [];

    for (String path in photoPaths) {
      String imageUrl = '$imageBaseUrl$path';

      // Debugging logs
      print('Constructed URL: $imageUrl');

      photoViewGalleryPageOptionsList.add(
        PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(imageUrl),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: photo.isEmpty
            ? Text("Please Wait")
            : PhotoViewGallery.builder(
          itemCount: photoViewGalleryPageOptionsList.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider:
              photoViewGalleryPageOptionsList[index].imageProvider,
              minScale:
              photoViewGalleryPageOptionsList[index].minScale,
              maxScale:
              photoViewGalleryPageOptionsList[index].maxScale,
              heroAttributes:
              photoViewGalleryPageOptionsList[index].heroAttributes,
            );
          },
          scrollPhysics: BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(
            color: Colors.black,
          ),
          pageController: PageController(),
        ),
      ),
    );
  }
}
