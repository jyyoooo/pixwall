import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pixwall/controller/theme_controller.dart';
import 'package:pixwall/model/image_model.dart';
import 'package:pixwall/controller/permission_controller.dart';

class ViewImage extends StatefulWidget {
  final ImageModel image;

  ViewImage({Key? key, required this.image}) : super(key: key);

  @override
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage>
    with SingleTickerProviderStateMixin {
  final ThemeController themes = Get.put(ThemeController());

  Offset position = Offset.zero; // Current position of the image
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.addListener(() {
      setState(() {
        position = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animateToCenter() {
    _animation = Tween<Offset>(
      begin: position,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        CupertinoIcons.xmark,
                        color: CupertinoColors.activeBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        // Update position while maintaining the bounds
                        position += details.delta;
                        final screenSize = MediaQuery.of(context).size;
                        final maxOffsetX = screenSize.width / 2 -
                            50; // Adjust according to image size and screen width
                        final maxOffsetY = screenSize.height / 2 -
                            50; // Adjust according to image size and screen height
                        position = Offset(
                          position.dx.clamp(-maxOffsetX, maxOffsetX),
                          position.dy.clamp(-maxOffsetY, maxOffsetY),
                        );
                      });
                    },
                    onPanEnd: (details) {
                      // Animate position back to the center when the drag ends
                      _animateToCenter();
                    },
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: position,
                          child: child,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Hero(
                            tag: widget.image.id,
                            child: Image.network(
                              widget.image.webformatURL,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return const Center(
                                  child: CupertinoActivityIndicator(
                                      color: Colors.white),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                      child: CupertinoButton(
                        color: CupertinoColors.white.withOpacity(.5),
                        child: Text(
                          'Download',
                          style: TextStyle(
                            color: themes.isDarkMode.value
                                ? CupertinoColors.activeBlue
                                : CupertinoColors.activeBlue,
                          ),
                        ),
                        onPressed: () async {
                          // Call the saveImage function here
                          await saveImage(context, widget.image.largeImageURL);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
