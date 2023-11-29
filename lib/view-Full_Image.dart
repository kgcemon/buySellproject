import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullImage extends StatelessWidget {
  final String url;

  FullImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: url.isEmpty
            ? Text("Please Wait")
            : PhotoView(
          imageProvider: NetworkImage(url),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          enableRotation: true, // You can enable or disable rotation
        ),
      ),
    );
  }
}
