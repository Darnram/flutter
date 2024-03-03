import 'package:daram/constants/Colors.dart';
import 'package:daram/constants/Images.dart';
import 'package:daram/controller/feed.dart';
import 'package:daram/widgets/success_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeleteModalSheet extends StatelessWidget {
  final String title, subTitle, firstText, secondText;
  final Color firstColor, secondColor, secondTextColor, firstTextColor;
  FeedController feedController = Get.find<FeedController>();

  DeleteModalSheet({
    super.key,
    required this.title,
    required this.subTitle,
    required this.firstText,
    required this.firstColor,
    required this.firstTextColor,
    required this.secondText,
    required this.secondColor,
    required this.secondTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 232.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(
                left: 354,
                top: 11,
              ),
              child: Image.asset(
                IMAGES.close,
                width: 22,
                height: 22,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 7.54,
              left: 102,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: COLORS.defaultBlack,
                fontSize: 17.sp,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                height: 0,
                letterSpacing: -0.51,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 10,
              left: 60,
            ),
            child: Text(
              subTitle,
              style: TextStyle(
                color: COLORS.defaultGrey2,
                fontSize: 15.sp,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.45,
              ),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 171.w,
                  height: 56.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: firstColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    firstText,
                    style: TextStyle(
                      color: firstTextColor,
                      fontSize: 17.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.51,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.of(context).pop(),
                  Navigator.of(context).pop(),
                  if (secondText == '나가기')
                    {
                      feedController.toggleParticipate(),
                      SuccessSnackBar.show(context,
                          message: '모임에서 성공적으로 나갔어요!'),
                    }
                  else
                    {
                      SuccessSnackBar.show(context, message: '모임이 삭제되었어요!'),
                    }
                },
                child: Container(
                  width: 171.w,
                  height: 56.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: secondColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    secondText,
                    style: TextStyle(
                      color: secondTextColor,
                      fontSize: 17.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.51,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
