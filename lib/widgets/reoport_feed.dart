import 'package:daram/constants/Colors.dart';
import 'package:daram/constants/Images.dart';
import 'package:daram/provider/feed.dart';
import 'package:daram/widgets/success_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportFeed extends StatefulWidget {
  final int feedId;
  const ReportFeed({super.key, required this.feedId});

  @override
  State<ReportFeed> createState() => _ReportFeedState();
}

class _ReportFeedState extends State<ReportFeed> {
  List<String> menuItems = [
    '상업적 광고 및 판매 신고',
    '욕설/비하/비난',
    '도배/가짜뉴스',
    '사칭/사기',
    '정치 선거운동',
    '음란물/불건전 대화 만남',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 489.h,
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
            },
            child: Container(
              margin: const EdgeInsets.only(
                top: 11,
                left: 354,
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
              top: 16.54,
              left: 32,
              bottom: 8,
            ),
            child: Text(
              '신고사유',
              style: TextStyle(
                color: COLORS.defaultBlack,
                fontSize: 17.sp,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                letterSpacing: -0.51,
                height: 0,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(
                left: 32,
                right: 32,
              ),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    FeedApiService.reportFeed(widget.feedId, index + 1);
                    Navigator.pop(context);
                    SuccessSnackBar.show(context, message: '귀하의 신고가 접수되었습니다.');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Text(
                      menuItems[index],
                      style: TextStyle(
                        color: COLORS.defaultBlack,
                        fontSize: 17.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: -0.51,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 1,
                  color: COLORS.hrGrey,
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 32,
              ),
              alignment: Alignment.center,
              width: 358.w,
              height: 56.h,
              decoration: BoxDecoration(
                color: COLORS.hrGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '취소',
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
          ),
        ],
      ),
    );
  }
}
