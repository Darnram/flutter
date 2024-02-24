import 'package:daram/constants/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/Colors.dart';

class Feed extends StatelessWidget {
  const Feed({
    super.key,
    required this.imageUri,
    required this.nickname,
    required this.time,
    required this.feedImageUri,
    required this.like,
    required this.chatting,
    required this.comment,
  });

  final String imageUri, nickname, time, feedImageUri, comment;
  final int like, chatting;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      width: double.maxFinite,
      height: 340.h,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage(imageUri),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        nickname,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 8.h,
                            width: 8.w,
                            margin: const EdgeInsets.only(top: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffF97691)),
                          ),
                          Positioned(
                            left: 1,
                            top: 5,
                            // child: Icon(
                            //   IMAGES.star,
                            //   color: Colors.white,
                            //   size: 6,
                            // ),
                            child: Image.asset(IMAGES.star,
                                width: 6, height: 6, color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: COLORS.defaultGrey,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                  alignment: Alignment.centerRight,
                  onPressed: () {},
                  icon: Image.asset(IMAGES.star))
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Image.asset(IMAGES.feedImage),
        ],
      ),
    );
  }
}
