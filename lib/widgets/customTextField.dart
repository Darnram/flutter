import 'package:daram/constants/Colors.dart';
import 'package:daram/controller/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  // final PostController postController;
  final String id;
  final int maxLength;

  const CustomTextField({
    super.key,
    required this.hintText,
    // required this.postController,
    required this.id,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final postController = Get.find<PostController>();
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
          // controller: postController.controller,
          controller: postController.getController(id),
          maxLength: maxLength,
          style: TextStyle(
            color: COLORS.defaultBlack,
            fontSize: 15.sp,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: COLORS.categoryText,
              fontSize: 15.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              height: 0.08,
              letterSpacing: -0.30,
            ),
            contentPadding: const EdgeInsets.only(
              top: 20,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: COLORS.main),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: COLORS.hrGrey),
            ),
            counterText: '',
          ),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(
              top: 20,
              right: 6,
            ),
            child: Text(
              '${postController.getTextLength(id)}/$maxLength',
              style: TextStyle(
                color: postController.getIsFilled(id)
                    ? COLORS.main
                    : COLORS.defaultGrey2,
                fontSize: 12.sp,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                height: 0.14,
                letterSpacing: -0.50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
