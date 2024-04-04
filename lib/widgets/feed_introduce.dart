import 'package:daram/constants/Colors.dart';
import 'package:daram/constants/Images.dart';
import 'package:daram/controller/feed.dart';
import 'package:daram/controller/party.dart';
import 'package:daram/controller/party_info.dart';
import 'package:daram/provider/feed.dart';

import 'package:daram/screen/feed/administer_meeting_screen.dart';
import 'package:daram/screen/feed/alarm_screen.dart';
import 'package:daram/widgets/delete_modal_sheet.dart';
import 'package:daram/widgets/feed_object_widget.dart';
import 'package:daram/widgets/success_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../models/feed.dart';

class FeedIntroduce extends StatefulWidget {
  // final PartyInfo partyInfo;

  const FeedIntroduce({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedIntroduce> createState() => _FeedIntroduceState();
}

class _FeedIntroduceState extends State<FeedIntroduce> {
  final PartyInfoController partyInfoController =
      Get.find<PartyInfoController>();

  @override
  Widget build(BuildContext context) {
    FeedController feedController = Get.find<FeedController>();

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // widget.partyInfo.title,
                partyInfoController.title.value,
                style: TextStyle(
                  color: COLORS.defaultBlack,
                  fontSize: 17.sp,
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.34,
                ),
              ),
              const Spacer(),
              Obx(
                () {
                  return partyInfoController.isParticipate.value |
                          partyInfoController.isAdminister.value
                      ? InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  width: double.maxFinite,
                                  height: 232.h, // 바텀 시트의 높이를 설정합니다.
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
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
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AlarmScreen()));
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            left: 32,
                                            top: 16,
                                          ),
                                          child: Text(
                                            '알람리스트',
                                            style: TextStyle(
                                              color: COLORS.defaultBlack,
                                              fontSize: 17.sp,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.51,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 326.w,
                                        height: 2.h,
                                        margin: const EdgeInsets.only(
                                          left: 32,
                                          top: 16,
                                        ),
                                        color: COLORS.hrGrey,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          //모임 관리자라면 모임 관리 페이지로 이동
                                          if (partyInfoController
                                              .isAdminister.value) {
                                            print('');
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           AdministerMeetingScreen(
                                            //               partyInfo: partyInfoController.)),
                                            // );
                                          } else {
                                            //모임 관리자가 아니라면 모임 나가기 모달을 보여준다.
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return DeleteModalSheet(
                                                  title: '정말 모임에서 나가시겠어요?',
                                                  subTitle:
                                                      '한 번 모임에서 나가면 3일간 재가입 할 수 없어요!',
                                                  firstText: '취소',
                                                  firstColor:
                                                      COLORS.meetingCard,
                                                  firstTextColor:
                                                      COLORS.defaultBlack,
                                                  secondText: '나가기',
                                                  secondColor:
                                                      COLORS.defaultOrange,
                                                  secondTextColor: Colors.white,
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            left: 32,
                                            top: 16,
                                          ),
                                          child: Text(
                                            partyInfoController
                                                    .isAdminister.value
                                                ? '모임 관리'
                                                : '모임나가기',
                                            style: TextStyle(
                                              color: partyInfoController
                                                      .isAdminister.value
                                                  ? COLORS.defaultBlack
                                                  : COLORS.defaultRed,
                                              fontSize: 17.sp,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.51,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 358.w,
                                        height: 56.h,
                                        margin: const EdgeInsets.only(
                                          left: 16,
                                          top: 19,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: COLORS.hrGrey,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '취소',
                                            style: TextStyle(
                                              color: COLORS.defaultBlack,
                                              fontSize: 17.sp,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: -0.51,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            // color: Colors.amber,
                            width: 11,
                            height: 25,
                            alignment: Alignment.center,
                            child: Image.asset(
                              IMAGES.more,
                              width: 4.w,
                              height: 18.h,
                            ),
                          ),
                        )
                      : SizedBox(width: 4.w, height: 18.h);
                },
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 1),
                child: Image.asset(
                  IMAGES.calendar,
                  width: 14.w,
                  height: 14.53.h,
                  color: COLORS.defaultBlack2,
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                '${partyInfoController.startedAt.value} ~ ${partyInfoController.endAt.value}',
                style: TextStyle(
                  color: COLORS.defaultGrey,
                  fontSize: 13.sp,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.13,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                '월수금', //수정 필요
                style: TextStyle(
                  color: COLORS.main,
                  fontSize: 13.sp,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.13,
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Container(
                margin: const EdgeInsets.only(top: 1),
                child: Image.asset(
                  IMAGES.alarm,
                  width: 14.w,
                  height: 14.h,
                  color: COLORS.defaultBlack2,
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                '15:00', //수정 필요
                style: TextStyle(
                  color: COLORS.defaultGrey,
                  fontSize: 13.sp,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.13,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            children: [
              Image.asset(
                IMAGES.location,
                width: 14,
                height: 14.53,
                color: COLORS.defaultBlack2,
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                partyInfoController.location.value,
                style: TextStyle(
                    fontSize: 13.sp,
                    color: COLORS.defaultGrey,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.26),
              ),
              SizedBox(
                width: 12.w,
              ),
              Image.asset(
                IMAGES.user,
                width: 14,
                height: 14.53,
                color: COLORS.defaultBlack2,
              ),
              SizedBox(
                width: 3.w,
              ),
              Text(
                partyInfoController.currentCount.value.toString(),
                style: TextStyle(
                  color: COLORS.defaultGrey2,
                  fontSize: 13.sp,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.13,
                ),
              ),
              Text(
                '/${partyInfoController.max.value}',
                style: TextStyle(
                  color: COLORS.defaultGrey,
                  fontSize: 13.sp,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.13,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            partyInfoController.description.value,
            style: TextStyle(
              color: COLORS.defaultGrey2,
              fontSize: 15.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.45,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
        ],
      );
    });
  }
}
