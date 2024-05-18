import 'dart:developer';

import 'package:get/state_manager.dart';

class ImageAnimationController extends GetxController {
  double scale = 1.0;

  void scaleDown() {
    log('scaleDown');
    scale = 0.95;
    update();
  }

  void scaleUp() {
    log('scaleUp');
    scale = 1;
    update();
  }
}
