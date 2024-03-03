import 'package:daram/constants/Colors.dart';
import 'package:daram/constants/Images.dart';
import 'package:daram/controller/feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ParticipationDialog extends StatefulWidget {
  const ParticipationDialog({super.key});

  @override
  State<ParticipationDialog> createState() => _ParticipationDialogState();
}

class _ParticipationDialogState extends State<ParticipationDialog> {
  final passwordController = TextEditingController();

  bool isValid() {
    return (passwordController.text.length >= 4 &&
        passwordController.text.length <= 8);
  }

  bool checkPassword(password) {
    return ('abcd' == password);
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.blue.shade100,
          cursorColor: Colors.blue,
        ),
      ),
      child: CupertinoAlertDialog(
        title: Text(
          '참여 코드 입력',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: COLORS.defaultBlack,
            fontSize: 17.sp,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            letterSpacing: -0.51,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '참여 코드 입력이 필요한 채팅방입니다.',
            ),
            const Text('방장이 알려준 참여 코드를 입력해 주세요.'),
            SizedBox(
              height: 20.h,
            ),
            CupertinoTextField(
              controller: passwordController,
              maxLength: 8,
              placeholder: '영문/숫자 4~8자리',
              // cursorColor: COLORS.defaultBlue,
              style: TextStyle(
                fontSize: 15.sp,
              ),
              onChanged: (text) {
                setState(() {});
              },
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: COLORS.defaultGrey,
                  width: 0.5,
                ),
              ),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text(
              "취소",
              style: TextStyle(color: COLORS.defaultBlue),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: isValid()
                ? () {
                    if (checkPassword(passwordController.text)) {
                      Get.find<FeedController>().toggleParticipate();
                      Navigator.of(context).pop(); // CupertinoAlertDialog 닫기
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            width: double.maxFinite,
                            height: 232,
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                            ),
                            child: Column(
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
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 7.54,
                                  ),
                                  child: Text(
                                    '모임에 가입되었어요!',
                                    style: TextStyle(
                                      color: COLORS.defaultBlack,
                                      fontSize: 17.sp,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.51,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Text(
                                    '소구밍님이 목표한 바를 이루길 바랄게요!',
                                    style: TextStyle(
                                      color: COLORS.defaultGrey2,
                                      fontSize: 15.sp,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.45,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 358,
                                    height: 56,
                                    margin: const EdgeInsets.only(
                                      top: 50,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: COLORS.defaultOrange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '확인',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.sp,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.51,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }
                : null,
            child: const Text(
              "확인",
              style: TextStyle(color: COLORS.defaultBlue),
            ),
          ),
        ],
      ),
    );
  }
}
