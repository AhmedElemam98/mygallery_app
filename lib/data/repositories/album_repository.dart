import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../core/constant.dart';
import '../models/album.dart';

class AlbumRepository {
  Future<Album> getAlbum(String token) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstant.getAlbum),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        dynamic extractedData = json.decode(response.body);
        Album albumData = Album.fromJson(extractedData);
        return albumData;
      } else {
        throw Exception('Failed to load albums');
      }
    } catch (e) {
      throw Exception('Failed to load albums');
    }
  }

  Future<void> uploadPhotoToAlbum(File imageFile, String token) async {
    try {
      var uri = Uri.parse(ApiConstant.uploadPhotoToAlbum);
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $token';
      var length = await imageFile.length();
      var stream = imageFile.openRead().cast<List<int>>();
      var multipartFile = http.MultipartFile('img', stream, length,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
      var response = await request.send();
      if (response.statusCode == 200) {
        await response.stream.transform(utf8.decoder).join();
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      throw Exception('Failed to load image');
    }
  }
}
