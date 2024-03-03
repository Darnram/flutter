import 'package:daram/constants/Colors.dart';
import 'package:daram/constants/Gaps.dart';
import 'package:daram/constants/Images.dart';
import 'package:daram/controller/post.dart';
import 'package:daram/widgets/customTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdministerMeetingScreen extends StatefulWidget {
  const AdministerMeetingScreen({super.key});

  @override
  State<AdministerMeetingScreen> createState() =>
      _AdministerMeetingScreenState();
}

class _AdministerMeetingScreenState extends State<AdministerMeetingScreen> {
  final PostController postController = Get.put(PostController());
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.grey.shade300,
          cursorColor: COLORS.defaultBlack,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 22,
              color: COLORS.defaultBlack,
            ),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
          ),
          titleTextStyle: const TextStyle(),
          title: const Padding(
            padding: EdgeInsets.only(
              top: 3,
            ),
            child: Text(
              '모임관리',
              style: TextStyle(
                color: COLORS.defaultBlack,
                fontSize: 18,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                height: 0,
                letterSpacing: -0.44,
              ),
            ),
          ),
          actions: const [
            Text(
              '완료',
              style: TextStyle(
                color: COLORS.hrGrey,
                fontSize: 18,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 0,
                letterSpacing: -0.44,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 104.w,
                    height: 104.h,
                    decoration: BoxDecoration(
                      color: COLORS.meetingCard,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      IMAGES.camera,
                      width: 54,
                      height: 54,
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextField(
                        hintText: '모임 이름을 입력해주세요.',
                        id: 'textField1',
                        maxLength: 30),
                    Gaps.v40,
                    const Title(
                      title: '모임설명',
                    ),
                    Gaps.v10,
                    const CustomTextField(
                        hintText: '모임 설명을 입력해주세요.',
                        id: 'textField2',
                        maxLength: 30),
                    Gaps.v36,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Title(
                          title: '비공개여부',
                        ),
                        CupertinoSwitch(
                          value: _isChecked,
                          activeColor: COLORS.main,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value ?? false;
                            });
                          },
                        )
                      ],
                    ),
                    Gaps.v28,
                    Row(
                      children: [
                        const Title(
                          title: '정원수',
                        ),
                        Gaps.h4,
                        Image.asset(
                          IMAGES.user,
                          width: 19,
                          height: 20,
                          color: COLORS.defaultBlack,
                        )
                      ],
                    ),
                    Gaps.v1,
                    Text(
                      '정원 수는 최대 10명까지 가능해요!',
                      style: TextStyle(
                        color: COLORS.categoryText,
                        fontSize: 12.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.24,
                      ),
                    ),
                    const CustomTextField(
                        hintText: '모임 이름을 입력해주세요.',
                        id: 'textField3',
                        maxLength: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String title;
  const Title({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: COLORS.defaultBlack,
        fontSize: 17.sp,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w600,
        height: 0.07,
        letterSpacing: -0.50,
      ),
    );
  }
}
