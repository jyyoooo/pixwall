// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:pixwall/controller/get_controller.dart';

class ImageCard extends StatefulWidget {
  const ImageCard({
    super.key,
    required this.controller,
    required this.imageCount,
  });

  final ImageController controller;
  final int imageCount;

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.controller.wallpapers[widget.imageCount].largeImageURL,
      fit: BoxFit.cover,
    );
  }
}
