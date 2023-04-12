part of 'album_cubit.dart';

abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final Album album;

  AlbumLoaded(this.album);
}

class AlbumPhotoAdded extends AlbumState {}

class AlbumError extends AlbumState {
  final String errorMessage;

  AlbumError(this.errorMessage);
}
