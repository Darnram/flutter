import 'package:daram/constants/Colors.dart';
import 'package:daram/constants/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/feed_info_model.dart';

class FeedIntroduce extends StatelessWidget {
  final FeedInfoModel feedInfo;

  const FeedIntroduce({Key? key, required this.feedInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 20,
          color: Colors.amber,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                feedInfo.title,
                style: TextStyle(
                  color: COLORS.defaultBlack,
                  fontSize: 17.sp,
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.34,
                ),
              ),
              const Spacer(),
              Image.asset(IMAGES.more),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              color: COLORS.defaultBlack2,
              size: 15,
            ),
            SizedBox(
              width: 3.w,
            ),
            Text(
              feedInfo.duration,
              style: TextStyle(color: COLORS.defaultGrey, fontSize: 13.sp),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              feedInfo.date,
              style: TextStyle(color: COLORS.main, fontSize: 13.sp),
            ),
            SizedBox(
              width: 20.w,
            ),
            const Icon(
              Icons.alarm,
              color: COLORS.defaultBlack2,
              size: 15,
            ),
            SizedBox(
              width: 3.w,
            ),
            Text(
              feedInfo.time,
              style: TextStyle(color: COLORS.defaultGrey, fontSize: 13.sp),
            ),
          ],
        ),
        SizedBox(
          height: 3.h,
        ),
        Row(
          children: [
            const Icon(
              Icons.place_outlined,
              color: COLORS.defaultBlack2,
              size: 15,
            ),
            Text(
              feedInfo.location,
              style: TextStyle(fontSize: 13.sp, color: COLORS.defaultGrey),
            ),
            SizedBox(
              width: 15.w,
            ),
            const Icon(
              Icons.people_alt_outlined,
              color: COLORS.defaultBlack2,
              size: 15,
            ),
            SizedBox(
              width: 3.w,
            ),
            Text(
              '${feedInfo.present}/${feedInfo.quota}',
              style: TextStyle(
                color: COLORS.defaultGrey,
                fontSize: 13.sp,
              ),
            )
          ],
        ),
      ],
    );
  }
}
