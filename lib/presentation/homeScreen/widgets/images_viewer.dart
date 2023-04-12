import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_app/cubits/albums/album_cubit.dart';

class ImagesViewer extends StatelessWidget {
  const ImagesViewer({
    key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumCubit, AlbumState>(builder: (context, state) {
      if (state is AlbumLoading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 250.h),
            Center(
              child: Text(
                'Loading....',
                style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff4A4A4A)),
              ),
            ),
          ],
        );
      } else if (state is AlbumError) {
        return Column(
          children: [
            SizedBox(height: 250.h),
            Center(
              child: Text(
                'Somthing has wrong try again',
                style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff4A4A4A)),
              ),
            ),
          ],
        );
      } else if (state is AlbumLoaded) {
        return Expanded(
          child: GridView.builder(
            itemCount: (state).album.images?.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.9,
                mainAxisSpacing: 16.w,
                crossAxisCount: 3,
                crossAxisSpacing: 16.h),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.sp),
                  color: Colors.white.withOpacity(0.5),
                  image: DecorationImage(
                    image: NetworkImage((state)
                        .album
                        .images![(state).album.images!.length - index - 1]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        );
      } else {
        return Column(
          children: [
            SizedBox(height: 250.h),
            Center(
              child: Text(
                'Somthing has wrong',
                style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffEFD8F9)),
              ),
            ),
          ],
        );
      }
    });
  }
}
