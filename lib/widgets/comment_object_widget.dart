import 'package:daram/constants/Colors.dart';
import 'package:daram/constants/Gaps.dart';
import 'package:daram/constants/Images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Comment extends StatefulWidget {
  const Comment({super.key});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 18,
      ),
      constraints: BoxConstraints(minHeight: 82.h),
      width: 356.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 4,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 20.w,
                  backgroundImage: const NetworkImage(
                    "https://via.placeholder.com/40x40",
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'sogummming',
                        style: TextStyle(
                          color: COLORS.defaultBlack,
                          fontSize: 15.sp,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.45,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                        ),
                        child: Text(
                          '2시간전',
                          style: TextStyle(
                            color: COLORS.defaultGrey,
                            fontSize: 12.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            // height: 0,
                            letterSpacing: -0.36,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '저는 몬스터 드링크 장착하고 앉았어요~! 오늘도 화이팅 입니다.',
                    style: TextStyle(
                      color: COLORS.defaultGrey2,
                      fontSize: 15.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.45,
                    ),
                  ),
                  Gaps.v6,
                  Row(
                    children: [
                      Image.asset(
                        IMAGES.heart,
                        width: 13.65.w,
                        height: 13.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 2,
                        ),
                        child: Text(
                          '21',
                          style: TextStyle(
                            color: COLORS.defaultBlack,
                            fontSize: 12.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Gaps.h16,
                      Image.asset(
                        IMAGES.comment,
                        width: 13.43.w,
                        height: 13.43.h,
                      ),
                      Text(
                        '16',
                        style: TextStyle(
                          color: COLORS.defaultBlack,
                          fontSize: 12.sp,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gaps.h16,
                      Text(
                        '답글달기',
                        style: TextStyle(
                          color: COLORS.defaultBlack,
                          fontSize: 12.sp,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
