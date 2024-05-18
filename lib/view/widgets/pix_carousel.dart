import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixwall/controller/get_controller.dart';
import 'package:shimmer/shimmer.dart';

class PixWallCarousel extends StatelessWidget {
  const PixWallCarousel({super.key, required this.imageController});

  final ImageController imageController;
  final bool isErrorImage = false;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => imageController.generalImages.isEmpty
          ? SizedBox(
              height: 100,
              child: Shimmer.fromColors(
                direction: ShimmerDirection.ltr,
                baseColor: Colors.grey.withOpacity(.25),
                highlightColor: Colors.grey.withOpacity(.2),
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            )
          : CarouselSlider.builder(
              itemCount: imageController.generalImages.length,
              itemBuilder: (context, index, realIndex) => Padding(
                padding: const EdgeInsets.all(5),
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0, bottom: 50),
                  child: SizedBox(
                    height: 350,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: InkWell(
                        onTap: () {
                          imageController.navigateToViewImage(
                              context, imageController.generalImages[index]);
                        },
                        child: Hero(
                          tag: imageController.generalImages[index].id,
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
                                        imageController
                                            .generalImages[index].webformatURL,
                                        fit: BoxFit.cover));
                              },
                            );
                          },
                          child: Image.network(
                            imageController.generalImages[index].webformatURL,
                            errorBuilder: (context, error, stackTrace) =>
                                SizedBox(
                              height: 100,
                              child: Shimmer.fromColors(
                                direction: ShimmerDirection.btt,
                                baseColor: Colors.grey.withOpacity(.25),
                                highlightColor: Colors.grey.withOpacity(.15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                            ),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;

                              return SizedBox(
                                height: 100,
                                child: Shimmer.fromColors(
                                  direction: ShimmerDirection.btt,
                                  baseColor: Colors.grey.withOpacity(.25),
                                  highlightColor: Colors.grey.withOpacity(.15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                              );
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              options: CarouselOptions(
                animateToClosest: false,
                enlargeFactor: .5,
                enlargeCenterPage: true,
                viewportFraction: .9,
                scrollPhysics: const BouncingScrollPhysics(),
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                disableCenter: true,
                autoPlay: true,
              ),
            ),
    );
  }
}
