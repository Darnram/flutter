import 'package:daram/constants/Colors.dart';
import 'package:daram/constants/Gaps.dart';
import 'package:daram/constants/Images.dart';
import 'package:daram/controller/edit_party.dart';
import 'package:daram/controller/post.dart';
import 'package:daram/models/feed.dart';
import 'package:daram/screen/home/image_edit_screen.dart';
import 'package:daram/widgets/customTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AdministerMeetingScreen extends StatefulWidget {
  final PartyInfo partyInfo;
  const AdministerMeetingScreen({super.key, required this.partyInfo});

  @override
  State<AdministerMeetingScreen> createState() =>
      _AdministerMeetingScreenState();
}

class _AdministerMeetingScreenState extends State<AdministerMeetingScreen> {
  final PostController postController = Get.put(PostController());
  final EditPartyController editPartyController =
      Get.find<EditPartyController>();
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  final picker = ImagePicker();
  XFile? image;

  final List<String> genderItems = [
    'sogummming',
    'sogummming',
    'sogummming',
    'sogummming',
    'sogummming',
  ];
  final LayerLink _layerLink = LayerLink();

  String? selectedValue;
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
            Padding(
              padding: EdgeInsets.only(
                right: 24,
              ),
              child: Text(
                '완료',
                style: TextStyle(
                  color: COLORS.hrGrey,
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: -0.44,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        image =
                            await picker.pickImage(source: ImageSource.gallery);
                      },
                      child: Container(
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
                      if (_isChecked) // _isChecked가 true일 때만 CustomTextField를 표시
                        const CustomTextField(
                          hintText: '비밀번호를 입력해주세요',
                          id: 'textField3',
                          maxLength: 30,
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
                      Obx(
                        () => Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  editPartyController.decreaseMax();
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.minus,
                                  size: 16,
                                ),
                                visualDensity:
                                    const VisualDensity(horizontal: -4),
                              ),
                              Text(
                                '${editPartyController.max.value}',
                                style: TextStyle(
                                  color: COLORS.defaultBlack,
                                  fontSize: 17.sp,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 0.07,
                                  letterSpacing: -0.50,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  editPartyController.increaseMax();
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.plus,
                                  size: 16,
                                ),
                                visualDensity:
                                    const VisualDensity(horizontal: -4),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gaps.v36,
                      // Row(
                      //   children: [
                      //     const Title(
                      //       title: '모임일정',
                      //     ),
                      //     Gaps.h4,
                      //     Image.asset(
                      //       IMAGES.calendar,
                      //       width: 16,
                      //       height: 17,
                      //       color: COLORS.defaultBlack,
                      //     )
                      //   ],
                      // ),
                      // Gaps.v16,
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Text(
                      //     '시작일과 종료일을 입력해주세요.',
                      //     style: TextStyle(
                      //       color: COLORS
                      //           .categoryText, // 여기서 COLORS는 앞서 정의한 색상 변수입니다.
                      //       fontSize: 15.sp,
                      //       fontFamily: 'Pretendard',
                      //       fontWeight: FontWeight.w400,
                      //       height: 0.08,
                      //       letterSpacing: -0.30,
                      //     ),
                      //   ),
                      // ),
                      // Gaps.v4,
                      // const Divider(
                      //   thickness: 1,
                      //   color: COLORS.hrGrey,
                      // ),
                      // Gaps.v32,
                      const Title(
                        title: '방장변경',
                      ),
                      Gaps.v16,
                      // Container(
                      //   width: 342.w,
                      //   height: 48.h,
                      //   padding: const EdgeInsets.only(left: 8),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(7),
                      //     border: Border.all(
                      //       width: 1,
                      //       color: COLORS.defaultOrange2,
                      //     ),
                      //   ),
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     '방장을 선택해주세요.',
                      //     style: TextStyle(
                      //       color: COLORS.defaultBlack,
                      //       fontSize: 15.sp,
                      //       fontFamily: 'Pretendard',
                      //       fontWeight: FontWeight.w400,
                      //       // height: 0.08,
                      //       letterSpacing: -0.30,
                      //     ),
                      //   ),
                      // )
                      DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 14),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide:
                                const BorderSide(color: COLORS.defaultGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide:
                                const BorderSide(color: COLORS.defaultOrange2),
                          ),
                        ),
                        hint: Text(
                          '방장을 선택해주세요',
                          style: TextStyle(
                            color: COLORS.defaultBlack,
                            fontSize: 15.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 0.08,
                            letterSpacing: -0.30,
                          ),
                        ),
                        items: genderItems
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      color: COLORS.defaultGrey,
                                      fontSize: 15.sp,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      height: 0.08,
                                      letterSpacing: -0.30,
                                    ),
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select gender.';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        onSaved: (value) {
                          selectedValue = value.toString();
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: COLORS.defaultBlack,
                          ),
                          iconSize: 24,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                      // Gaps.v24,
                      // const Title(title: '강퇴'),
                      Gaps.v32,
                      Text(
                        '모임 삭제',
                        style: TextStyle(
                          color: COLORS.defaultRed,
                          fontSize: 16.sp,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: -0.48,
                        ),
                      ),
                      const SizedBox(
                        height: 300,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
