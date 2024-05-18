import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixwall/api/api_service.dart';
import 'package:pixwall/model/image_model.dart';
import 'package:pixwall/view/widgets/image_view.dart';

class ImageController extends GetxController {
  final ImageService _imageService = Get.find();
  RxList<ImageModel> wallpapers = <ImageModel>[].obs;
  RxList<ImageModel> generalImages = <ImageModel>[].obs;
  var categoryImages = <String, RxList<ImageModel>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getWallpapers();
    getGeneralImages();
  }

  getWallpapers() async {
    try {
      final List<ImageModel> allImages = await _imageService.fetchWallpapers();
      wallpapers.assignAll(allImages);
      log('wallpapers: ${allImages.length.toString()}');
    } catch (e) {
      log('getImages error: $e');
    }
  }

  getGeneralImages() async {
    try {
      final List<ImageModel> allImages =
          await _imageService.fetchGeneralImages();
      generalImages.assignAll(allImages);
      log('general: ${allImages.length.toString()}');
    } catch (e) {
      log('getImages error: $e');
    }
  }

  getCategoryImages(String category) async {
    log('in getCatgoerywise images');
    if (categoryImages.containsKey(category)) {
      return; // Images already fetched for this category
    }

    try {
      final List<ImageModel> allImages =
          await _imageService.fetchCategoryImages(category);
      categoryImages[category] = allImages.obs;
      log('$category: ${allImages.length}');
    } catch (e) {
      log('getCategoryImages error: $e');
    }
  }

  void navigateToViewImage(BuildContext context, ImageModel image) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ViewImage(image: image);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: Builder(
              builder: (context) {
                final begin = BorderRadius.circular(25.0);
                const end = BorderRadius.zero;
                const curve = Curves.ease;
                final tween = BorderRadiusTween(begin: begin, end: end);
                final curvedAnimation = CurvedAnimation(
                    parent: animation, curve: curve, reverseCurve: curve);

                return AnimatedBuilder(
                  animation: curvedAnimation,
                  builder: (context, child) {
                    return ClipRRect(
                      borderRadius: tween.evaluate(curvedAnimation)!,
                      child: child,
                    );
                  },
                  child: child,
                );
              },
            ),
          );
        },
        opaque: false,
      ),
    );
  }

  final List<String> categories = [
    'Nature',
    'Animals',
    'Abstract',
    'Architecture',
    'Cars',
    'Technology',
    'Space',
    'Sports',
    'Food',
    'Travel',
    'Fashion',
    'Minimalist',
    'Fantasy',
    'Music',
    'Movies',
    'Gaming',
    'Art',
    'Vintage',
    'Quotes',
    'Patterns',
    'Flowers',
    'Seasons',
    'Underwater',
    'Landscapes',
    'Urban',
    'Portraits',
    'Mountains',
    'Beaches',
    'Forests',
    'Sunsets',
    'Night Sky'
  ];
}
