import 'package:flutter/material.dart';
import '../../core/constant.dart';
import 'widgets/login_form.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  logInBg,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                )),
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        top: 60.h,
                        left: 75.w,
                        child: SizedBox(
                          height: 131.h,
                          width: 131.h,
                          child: Image.asset(
                            camera,
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 206.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 122.h,
                                  width: 174.w,
                                  child: Text(
                                    'My Gallery',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 50.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff4A4A4A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30.h),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 28.w),
                              height: 450.h,
                              width: 390.w,
                              child: Image.asset(
                                underContainerIcons,
                                fit: BoxFit.cover,
                              ),
                            )
                          ]),
                      LogInContainerWidget(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
