import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_app/cubits/auth/auth_cubit.dart';
import 'package:gallery_app/core/constant.dart';
import '../../data/models/user.dart';
import '../AuthScreen/auth_screen.dart';
import 'widgets/images_viewer.dart';
import 'widgets/show_upload_dialog.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffDDCDFF),
        body: Stack(
          children: [
            SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  homeScreenBG,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(20.h, 20.h, 20.h, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Welcome',
                                style: TextStyle(
                                  fontSize: 31,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                user.name!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 31,
                                  color: Color(0xff4A4A4A),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 15.w, 30.h),
                        child: Container(
                          height: 60.h,
                          width: 60.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.sp),
                              image: const DecorationImage(
                                  image: AssetImage(profile))),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 22.h, horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            BlocProvider.of<AuthCubit>(context).logout();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LogInScreen()),
                                (route) => false);
                          },
                          child: Container(
                            width: 145.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.sp),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 30.h,
                                  width: 30.h,
                                  child: Image.asset(
                                    logOutIcon,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text(
                                  'Log out',
                                  style: TextStyle(
                                    color: Color(0xff4A4A4A),
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showUploadDialog(context);
                          },
                          child: Container(
                            width: 145.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.sp),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 30.h,
                                  width: 30.h,
                                  child: Image.asset(
                                    uploadIcon,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text(
                                  'Upoad',
                                  style: TextStyle(
                                    color: Color(0xff4A4A4A),
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const ImagesViewer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
