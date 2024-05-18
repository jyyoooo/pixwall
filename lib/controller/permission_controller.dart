import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixwall/controller/theme_controller.dart';

final ThemeController themes = Get.put(ThemeController());

Future<bool> requestStoragePermission() async {
  final storageStatus = await Permission.storage.request();
  log('permission: $storageStatus');
  return storageStatus.isGranted;
}

Future<bool> downloadImageAndSave(String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));
  if (response.statusCode == 200) {
    final directory = await getExternalStorageDirectory();
    final downloadsDirectory = Directory('${directory!.path}/Downloads');
    if (!await downloadsDirectory.exists()) {
      await downloadsDirectory.create();
    }
    final filename = basename(imageUrl);
    final filePath = '${downloadsDirectory.path}/$filename';
    final file = File(filePath);
    try {
      log('file path ${file.path}');
      await file.writeAsBytes(response.bodyBytes);
      return true;
    } catch (e) {
      log("Error writing file: $e");
      return false;
    }
  } else {
    log("Failed to download image: ${response.statusCode}");
    return false;
  }
}

Future<void> saveImage(BuildContext context, String imageUrl) async {
  String? message;
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  try {
    final bool saved = await downloadImageAndSave(imageUrl);
    if (saved) {
      message = 'Image saved to disk';
    } else {
      message = 'Failed to save image';
    }
  } catch (e) {
    message = 'An error occurred while saving the image';
  }

  if (message.isNotEmpty) {
    scaffoldMessenger.showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      backgroundColor: themes.isDarkMode.value ? Colors.grey : Colors.black,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }
}
