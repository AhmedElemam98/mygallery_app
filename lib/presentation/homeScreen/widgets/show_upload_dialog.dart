import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'dart:io';
import 'package:gallery_app/cubits/albums/album_cubit.dart';
import './build_alert_buttons.dart';

import '../../../core/constant.dart';

showUploadDialog(BuildContext context) {
  showDialog(
    barrierColor: Colors.white.withOpacity(0),
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return Dialog(
        elevation: 50,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(33.sp),
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 7),
            child: Container(
              width: 500.w,
              height: 310.h,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(33.sp)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 25.h),
                    child: ButtonOfAlert(
                      onTap: () async {
                        File? imageFile =
                            await BlocProvider.of<AlbumCubit>(context)
                                .getImageFromGallery();
                        if (imageFile != null) {
                          // ignore: use_build_context_synchronously
                          await BlocProvider.of<AlbumCubit>(context)
                              .uploadPhotoToAlbum(imageFile);
                        }
                      },
                      icon: gallery,
                      color: const Color(0xffEFD8F9),
                      text: 'Gallery',
                    ),
                  ),
                  ButtonOfAlert(
                    onTap: () async {
                      File? imageFile =
                          await BlocProvider.of<AlbumCubit>(context)
                              .getImageFromCamera();
                      if (imageFile != null) {
                        // ignore: use_build_context_synchronously
                        await BlocProvider.of<AlbumCubit>(context)
                            .uploadPhotoToAlbum(imageFile);
                      }
                    },
                    icon: cameraButtonIcon,
                    color: Colors.white,
                    text: 'Camera',
                  ),
                  _buildPhotoSubmitedBloc()
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildPhotoSubmitedBloc() {
  return BlocListener<AlbumCubit, AlbumState>(
    listenWhen: (previous, current) {
      return previous != current;
    },
    listener: (context, state) {
      if (state is AlbumPhotoAdded) {
        Navigator.pop(context);
        BlocProvider.of<AlbumCubit>(context).getAlbum();
        String errorMsg = 'Photo Uploaded to server';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.black,
            duration: const Duration(seconds: 3),
          ),
        );
      }

      if (state is AlbumError) {
        String errorMsg = 'something has wrong try again';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.black,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    },
    child: Container(),
  );
}
