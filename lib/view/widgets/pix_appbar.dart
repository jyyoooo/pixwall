import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:pixwall/controller/get_controller.dart';
import 'package:pixwall/controller/theme_controller.dart';

import 'pix_carousel.dart';

class PixAppBar extends StatelessWidget {
  const PixAppBar({
    super.key,
    required this.themeController,
    required TabController tabController,
    required this.categories,
    required this.imageController,
  }) : _tabController = tabController;

  final ThemeController themeController;
  final TabController _tabController;
  final List<String> categories;
  final ImageController imageController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverAppBar(
        forceMaterialTransparency: true,
        actions: [
          IconButton(
              onPressed: () {
                themeController.toggleTheme();
              },
              icon: Icon(
                themeController.isDarkMode.value
                    ? CupertinoIcons.sun_max_fill
                    : CupertinoIcons.moon_fill,
              ))
        ],
        title: Text('PixWall',
            style: GoogleFonts.nunitoSans(
                textStyle: const TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold))),
        centerTitle: true,
        elevation: 0,
        expandedHeight: 360,
        floating: false,
        pinned: true,
        snap: false,
        stretch: true,
        bottom: TabBar(splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
          splashBorderRadius: BorderRadius.circular(12),
          tabAlignment: TabAlignment.start,
          labelStyle: GoogleFonts.nunitoSans(),
          controller: _tabController,
          physics: const BouncingScrollPhysics(),
          dividerColor: Colors.transparent,
          isScrollable: true,
          tabs: categories
              .map((category) => Tab(
                    text: category.capitalizeFirst!,
                  ))
              .toList(),
        ),
        flexibleSpace: Stack(
          children: [
            Positioned.fill(
              child: SizedBox(
                child: ClipPath(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      color: themeController.isDarkMode.value
                          ? Colors.black87
                          : Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
            FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: PixWallCarousel(imageController: imageController),
            ),
          ],
        ),
      ),
    );
  }
}
