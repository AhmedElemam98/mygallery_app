import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubmitedButton extends StatelessWidget {
  const SubmitedButton({
    key,
    required this.onPressed,
  });
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.sp),
          ),
          padding: EdgeInsets.symmetric(horizontal: 100.w)),
      child: Text(
        'SUBMIT',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.h),
      ),
    );
  }
}
