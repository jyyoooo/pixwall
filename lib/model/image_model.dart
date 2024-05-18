class ImageModel {
  final int id;
  final String pageURL;
  final String type;
  final String tags;
  final String previewURL;
  final int previewWidth;
  final int previewHeight;
  final String webformatURL;
  final int webformatWidth;
  final int webformatHeight;
  final String largeImageURL;
  final int imageWidth;
  final int imageHeight;
  final int imageSize;
  final int views;
  final int downloads;
  final int collections;
  final int likes;
  final int comments;
  final int userId;
  final String user;
  final String userImageURL;

  ImageModel({
    required this.id,
    required this.pageURL,
    required this.type,
    required this.tags,
    required this.previewURL,
    required this.previewWidth,
    required this.previewHeight,
    required this.webformatURL,
    required this.webformatWidth,
    required this.webformatHeight,
    required this.largeImageURL,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageSize,
    required this.views,
    required this.downloads,
    required this.collections,
    required this.likes,
    required this.comments,
    required this.userId,
    required this.user,
    required this.userImageURL,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      pageURL: json['pageURL'],
      type: json['type'],
      tags: json['tags'],
      previewURL: json['previewURL'],
      previewWidth: json['previewWidth'],
      previewHeight: json['previewHeight'],
      webformatURL: json['webformatURL'],
      webformatWidth: json['webformatWidth'],
      webformatHeight: json['webformatHeight'],
      largeImageURL: json['largeImageURL'],
      imageWidth: json['imageWidth'],
      imageHeight: json['imageHeight'],
      imageSize: json['imageSize'],
      views: json['views'],
      downloads: json['downloads'],
      collections: json['collections'],
      likes: json['likes'],
      comments: json['comments'],
      userId: json['user_id'],
      user: json['user'],
      userImageURL: json['userImageURL'],
    );
  }
}

/*{
  "id": 2695569,
  "pageURL": "https://pixabay.com/photos/milky-way-stars-night-sky-2695569/",
  "type": "photo",
  "tags": "milky way, stars, night sky",
  "previewURL": "https://cdn.pixabay.com/photo/2017/08/30/01/05/milky-way-2695569_150.jpg",
  "previewWidth": 150,
  "previewHeight": 84,
  "webformatURL": "https://pixabay.com/get/gc8344d70543c7df822f39b8f32de7c8ff7669f0c2194244ae484a0e2653ab672472944f92db5805daaeab5c0dd3cd0989318ba8fd0b8e9990ae670f1b0950397_640.jpg",
  "webformatWidth": 640,
  "webformatHeight": 359,
  "largeImageURL": "https://pixabay.com/get/gbeb4dabe3eed61e24e4147deeddbc1708a34e9d31d55ca09f76781446fad8900e07131257835c58bcef646af46f07e27cf02e33f026a903f38c6ea95a8e36d39_1280.jpg",
  "imageWidth": 6070,
  "imageHeight": 3414,
  "imageSize": 14622947,
  "views": 8187610,
  "downloads": 5254239,
  "collections": 6533,
  "likes": 6767,
  "comments": 1224,
  "user_id": 4397258,
  "user": "FelixMittermeier",
  "userImageURL": "https://cdn.pixabay.com/user/2024/03/06/21-40-30-298_250x250.jpg"
} */