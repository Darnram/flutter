import 'package:daram/constants/Colors.dart';
import 'package:daram/constants/Gaps.dart';
import 'package:daram/constants/Images.dart';
import 'package:daram/controller/comment.dart';
import 'package:daram/models/feed.dart';
import 'package:daram/provider/feed.dart';
import 'package:daram/utils/helpers/calculate_time.dart';
import 'package:daram/widgets/feed_object_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Comment extends StatefulWidget {
  final CommentModel comment;

  const Comment({super.key, required this.comment});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _checkLiked();
  }

  Future<void> _checkLiked() async {
    final prefs = await SharedPreferences.getInstance();
    isLiked = prefs.getBool('${widget.comment.commentId}') ?? false;
    setState(() {});
  }

  Future<void> _toggleLike() async {
    final prefs = await SharedPreferences.getInstance();
    final currentState = prefs.getBool('${widget.comment.commentId}') ?? false;
    if (currentState) {
      await FeedApiService.unLikeComment(widget.comment.commentId);
      setState(() {
        widget.comment.likeCount -= 1;
      });
    } else {
      await FeedApiService.likeComment(widget.comment.commentId);
      setState(() {
        widget.comment.likeCount += 1;
      });
    }
    await prefs.setBool('${widget.comment.commentId}', !currentState);

    setState(() {
      isLiked = !currentState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.45,
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: ((context) {
              FeedApiService.deleteComment(widget.comment.commentId);
            }),
            backgroundColor: COLORS.sliderBox,
            flex: 1,
            child: Image.asset(
              IMAGES.delete,
              width: 24.w,
              height: 24.h,
            ),
          ),
          CustomSlidableAction(
            onPressed: ((context) {}),
            flex: 1,
            child: Text(
              '신고',
              style: TextStyle(
                color: COLORS.sliderBox,
                fontSize: 15.sp,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                height: 0.09,
                letterSpacing: -0.45,
              ),
            ),
          ),
        ],
      ),
      child: Container(
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
                    backgroundImage: NetworkImage(widget.comment.profileImg),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.comment.memberName,
                          style: TextStyle(
                            color: COLORS.defaultBlack,
                            fontSize: 15.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            // height: 0,
                            letterSpacing: -0.45,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 3,
                            top: 2,
                          ),
                          child: Text(
                            TimeCalculator.getTimeDifference(
                                widget.comment.createdAt),
                            style: TextStyle(
                              color: COLORS.defaultGrey,
                              fontSize: 12.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: -0.36,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.comment.content,
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
                        GestureDetector(
                          onTap: _toggleLike,
                          child: Image.asset(
                            isLiked ? IMAGES.filledHeart : IMAGES.heart,
                            width: 13.65
                                .w, // 여기서 사용하는 .w와 .h는 본인의 화면 사이즈에 따라 조정하세요.
                            height: 13.h,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 2,
                          ),
                          child: Text(
                            widget.comment.likeCount.toString(),
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
      ),
    );
  }
}
