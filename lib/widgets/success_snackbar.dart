import 'package:daram/constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessSnackBar {
  static void show(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          height: 50,
          decoration: const BoxDecoration(
            color: COLORS.defaultOrange,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              height: 0,
              letterSpacing: -0.42,
            ),
          ),
        ),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
