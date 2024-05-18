import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixwall/controller/animation_controller.dart';
import 'package:pixwall/controller/get_controller.dart';
import 'package:pixwall/controller/theme_controller.dart';
import 'package:pixwall/view/widgets/grid_sliver.dart';
import 'package:pixwall/view/widgets/pix_appbar.dart';

class PixWallHome extends StatefulWidget {
  const PixWallHome({super.key});

  @override
  _PixWallHomeState createState() => _PixWallHomeState();
}

class _PixWallHomeState extends State<PixWallHome>
    with SingleTickerProviderStateMixin {
  final ImageController imageController = Get.put(ImageController());
  final ImageAnimationController imageAnimationController =
      Get.put(ImageAnimationController());
  final ThemeController themeController = Get.put(ThemeController());

  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: imageController.categories.length, vsync: this);
    _pageController = PageController();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        imageController.getCategoryImages(
            imageController.categories[_tabController.index]);
      }
    });

    _pageController.addListener(() {
      final pageIndex = _pageController.page?.round();
      if (pageIndex != null) {
        _tabController.animateTo(pageIndex);
        imageController
            .getCategoryImages(imageController.categories[pageIndex]);
      }
    });

    // Fetch initial category images
    imageController.getCategoryImages(imageController.categories[0]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: imageController.categories.length,
      child: Scaffold(
        body: CustomScrollView(
          scrollBehavior: const MaterialScrollBehavior(),
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            PixAppBar(
              themeController: themeController,
              tabController: _tabController,
              categories: imageController.categories,
              imageController: imageController,
            ),
            SliverFillRemaining(
              fillOverscroll: true,
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: imageController.categories.map((category) {
                  return CategoryGridView(
                    themes: themeController,
                    category: category,
                    imageController: imageController,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
