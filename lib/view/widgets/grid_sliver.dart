import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pixwall/controller/animation_controller.dart';
import 'package:pixwall/controller/get_controller.dart';
import 'package:pixwall/controller/theme_controller.dart';
import 'package:pixwall/model/image_model.dart';

class CategoryGridView extends StatelessWidget {
  final String category;
  final ImageController imageController;
  final ThemeController themes;

  const CategoryGridView({
    super.key,
    required this.category,
    required this.imageController,
    required this.themes,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final images =
            imageController.categoryImages[category] ?? <ImageModel>[].obs;
        return GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(6),
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 11,
            maxCrossAxisExtent: 280,
            mainAxisExtent: 380,
          ),
          itemBuilder: (context, index) {
            final ImageAnimationController imageAnimationController = Get.put(
                ImageAnimationController(),
                tag: images[index].id.toString());
            return _animatedImageCard(
                images, index, imageAnimationController, context);
          },
        );
      },
    );
  }

  GetBuilder<ImageAnimationController> _animatedImageCard(
      RxList<ImageModel> images,
      int index,
      ImageAnimationController imageAnimationController,
      BuildContext context) {
    return GetBuilder<ImageAnimationController>(
      tag: images[index].id.toString(),
      builder: (controller) => GestureDetector(
        onTapDown: (_) => imageAnimationController.scaleDown(),
        onTapCancel: () => imageAnimationController.scaleUp(),
        onTapUp: (_) => imageAnimationController.scaleUp(),
        onTap: () =>
            imageController.navigateToViewImage(context, images[index]),
        child: AnimatedContainer(
          transformAlignment: Alignment.center,
          transform:
              Matrix4.identity().scaled(controller.scale, controller.scale),
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: const Offset(1, 1.01),
                blurRadius: 2,
                spreadRadius: .1,
                color: themes.isDarkMode.value
                    ? Colors.grey.withOpacity(.5)
                    : CupertinoColors.systemGrey,
              )
            ],
            borderRadius: BorderRadius.circular(30),
            color: Colors.transparent,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Hero(
                    tag: images[index].id,
                    flightShuttleBuilder: (
                      BuildContext flightContext,
                      Animation<double> animation,
                      HeroFlightDirection flightDirection,
                      BuildContext fromHeroContext,
                      BuildContext toHeroContext,
                    ) {
                      return AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              images[index].webformatURL,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    },
                    child: Image.network(
                      images[index].webformatURL,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }

                        return SizedBox(
                          height: 100,
                          child: Shimmer.fromColors(
                            direction: ShimmerDirection.btt,
                            baseColor: Colors.black87,
                            highlightColor: Colors.black54,
                            child: Container(
                              height: 100,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(CupertinoIcons.exclamationmark_circle),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
