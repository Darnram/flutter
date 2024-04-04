import 'package:daram/constants/Colors.dart';
import 'package:daram/constants/Images.dart';
import 'package:daram/controller/feed.dart';
import 'package:daram/controller/new_party.dart';
import 'package:daram/controller/party_info.dart';
import 'package:daram/controller/user.dart';
import 'package:daram/models/feed.dart';
import 'package:daram/provider/feed.dart';
import 'package:daram/screen/feed/new_post_screen.dart';
import 'package:daram/widgets/reoport_feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FeedPopupMenu extends StatefulWidget {
  final FeedModel feed;
  const FeedPopupMenu({super.key, required this.feed});

  @override
  State<FeedPopupMenu> createState() => _FeedPopupMenuState();
}

class _FeedPopupMenuState extends State<FeedPopupMenu> {
  FeedController feedController = Get.find<FeedController>();
  PartyInfoController partyInfoController = Get.find<PartyInfoController>();
  UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    _checkIfMine();
  }

  void _checkIfMine() {
    bool isMine = userController.memberId.value == widget.feed.feedId;
    feedController.isMine.value = isMine;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      position: PopupMenuPosition.under,
      offset: const Offset(-1.5, 4),
      padding: const EdgeInsets.only(left: 20),
      constraints:
          partyInfoController.isParticipate.value && feedController.isMine.value
              ? BoxConstraints(maxWidth: 88.w, maxHeight: 80.h)
              : BoxConstraints(maxWidth: 88.w, maxHeight: 48.h),
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: COLORS.hrGrey),
        borderRadius: BorderRadius.circular(7),
      ),
      icon: Image.asset(
        IMAGES.more,
        width: 4.w,
        height: 18.h,
      ),
      itemBuilder: (context) {
        return partyInfoController.isParticipate.value &&
                feedController.isMine.value
            ? [
                _buildMenuItem(
                  value: 1,
                  text: '피드 수정',
                  color: COLORS.defaultBlack,
                ),
                _buildMenuItem(
                  value: 2,
                  text: '피드 삭제',
                  color: COLORS.defaultRed,
                  paddingBottom: 32,
                ),
              ]
            : [
                _buildMenuItem(
                  value: 3,
                  text: '피드 신고',
                  color: COLORS.defaultRed,
                  paddingBottom: 10,
                ),
              ];
      },
      onSelected: (value) {
        switch (value) {
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NewPostScreen(type: 1, feed: widget.feed)),
            );
            break;
          case 2:
            FeedApiService.deleteFeed(widget.feed.feedId);
            break;
          case 3:
            showModalBottomSheet(
              context: context,
              builder: (context) => ReportFeed(feedId: widget.feed.feedId),
            );
            break;
        }
      },
    );
  }
}

PopupMenuItem<int> _buildMenuItem({
  required int value,
  required String text,
  required Color color,
  double paddingBottom = 0.0,
}) {
  return PopupMenuItem(
    value: value,
    height: 40.h,
    padding: EdgeInsets.only(left: 10, bottom: paddingBottom),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 13.sp,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.26,
      ),
    ),
  );
}
