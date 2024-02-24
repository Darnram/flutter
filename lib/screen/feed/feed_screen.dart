// ignore_for_file: prefer_const_constructors

import 'package:daram/constants/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/Colors.dart';
import '../../models/feed_info_model.dart';
import '../../widgets/feed_introduce.dart';
import '../../widgets/feed_widget.dart';
import 'package:appbar_animated/appbar_animated.dart';
import './new_post_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  //참여상태
  bool isParticipate = true;

  //feed_Introduce api설정
  FeedInfoModel feedInfo = FeedInfoModel.fromJson();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: COLORS.main),
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          elevation: 4, //elevation 값 어떻게 ??
          onPressed: () {
            Navigator.of(context).push(NewPostScreen.route);
          },
          child: Image.asset(IMAGES.edit),
        ),
      ),
      body: ScaffoldLayoutBuilder(
        backgroundColorAppBar: ColorBuilder(Colors.transparent, Colors.white),
        textColorAppBar: ColorBuilder(Colors.white, Colors.white),
        appBarBuilder: _appBar,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                IMAGES.feedBackground,
                width: MediaQuery.of(context).size.width,
                height: 220.h,
                fit: BoxFit.cover,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 160,
                ),
                padding: EdgeInsets.only(
                  top: 32,
                  left: 16,
                  right: 20, //padding 줘야 하는지??
                ),
                height: 900.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: FeedIntroduce(feedInfo: feedInfo),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 380,
                ),
                height: 1.h,
                color: Color(0xffE5E5E5),
                width: double.maxFinite,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    top: 400,
                  ),
                  child: Column(
                    children: const [
                      Feed(
                        imageUri: IMAGES.avatar,
                        nickname: 'sogummming',
                        time: '2시간전',
                        feedImageUri: IMAGES.feedImage,
                        like: 3,
                        chatting: 10,
                        comment:
                            '새벽 공부 준비 완료! 다들 준비되셨나요? 저는 오늘 핫식스를 2병 마셨습니다. 저와 밤새 공부하실 분 없나요? 저는 오늘 핫식스를 2병 마셨습니다. 저와 밤새 공부하실 분 없나요? ',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _appBar(BuildContext context, ColorAnimated colorAnimated) {
  return AppBar(
      backgroundColor: colorAnimated.background,
      elevation: 0,
      leading: IconButton(
        //왼쪽 상단에 위젯 배치
        onPressed: () {},
        icon: Image.asset(
          IMAGES.arrowLeft,
          color: Colors.white,
          width: 24.w,
          height: 24.h,
        ),
      ),
      actions: [
        //앱바의 오른쪽 상단에 위젯 배치
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            IMAGES.chat,
            width: 21.49.w,
            height: 22.3.h,
            color: Colors.white,
          ),
        ),
      ]);
}
