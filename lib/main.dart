import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixwall/api/api_service.dart';
import 'package:pixwall/controller/theme_controller.dart';
import 'view/home/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => ImageService());
  runApp(PixWall());
}

class PixWall extends StatelessWidget {
  PixWall({super.key});
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PixWall - Wallpapers',
        theme: themeController.lightTheme,
        darkTheme: themeController.darkTheme,
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        home: const PixWallHome(),
      ),
    );
  }
}
