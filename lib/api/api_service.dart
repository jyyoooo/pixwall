import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pixwall/model/image_model.dart';
import 'package:pixwall/secrets.dart';
import 'package:http/http.dart' as http;

class ImageService extends GetxService {
  
  Future<List<ImageModel>> fetchWallpapers() async {
    Uri uri = Uri.parse(wallpapers);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await jsonDecode(response.body);
        List allImages = data['hits'];
        return allImages.map((image) => ImageModel.fromJson(image)).toList();
      } else {
        throw Exception('Failed to fetch Images');
      }
    } catch (e) {
      log('Image Service issue: $e');
      return <ImageModel>[];
    }
  }

  Future<List<ImageModel>> fetchGeneralImages() async {
    Uri uri = Uri.parse('$baseUrl$apiKey&q=wallpapers');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await jsonDecode(response.body);
        List allImages = data['hits'];
        log(allImages.isEmpty.toString());
        return allImages.map((image) => ImageModel.fromJson(image)).toList();
      } else {
        throw Exception('Failed to fetch Images');
      }
    } catch (e) {
      log('Image Service issue: $e');
      return <ImageModel>[];
    }
  }

  Future<List<ImageModel>> fetchCategoryImages(String category) async {
    Uri uri = Uri.parse('$baseUrl$apiKey&q=$category');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List allImages = data['hits'];
        return allImages.map((image) => ImageModel.fromJson(image)).toList();
      } else {
        throw Exception('Failed to fetch images for category $category');
      }
    } catch (e) {
      log('Image Service issue: $e');
      return <ImageModel>[];
    }
  }
}
