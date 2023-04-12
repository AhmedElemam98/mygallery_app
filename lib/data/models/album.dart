class Album {
  String? status;
  String? message;
  List<String>? images;

  Album({this.status, this.message, this.images});

  Album.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    List<dynamic> imagesList =
        json['data'] != null ? json["data"]["images"] : null;
    images = imagesList.map((image) => image.toString()).toList();
  }
}
