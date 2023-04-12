import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/data/models/album.dart';

import '../../data/repositories/album_repository.dart';

part 'album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  final AlbumRepository _albumRepository;
  final String token;

  AlbumCubit(this._albumRepository, this.token) : super(AlbumInitial());

  void getAlbum() async {
    emit(AlbumLoading());
    try {
      final album = await _albumRepository.getAlbum(token);
      emit(AlbumLoaded(album));
    } catch (e) {
      emit(AlbumError('Failed to load albums: $e'));
    }
  }

  Future<void> uploadPhotoToAlbum(File imageFile) async {
    emit(AlbumLoading());
    try {
      await _albumRepository.uploadPhotoToAlbum(imageFile, token);
      emit(AlbumPhotoAdded());
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }

  // function to select image from gallery
  Future<File?> getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  Future<File?> getImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }
}
