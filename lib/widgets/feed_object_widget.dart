import 'package:carousel_slider/carousel_slider.dart';
import 'package:daram/constants/Images.dart';
import 'package:daram/controller/feed.dart';
import 'package:daram/models/feed.dart';
import 'package:daram/provider/feed.dart';
import 'package:daram/utils/helpers/calculate_time.dart';
import 'package:daram/widgets/comment_modal.sheet.dart';
import 'package:daram/widgets/feed_popup_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/Colors.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

class Feed extends StatefulWidget {
  const Feed({
    super.key,
    required this.feed,
    required this.feedId,
    required this.imageUrl,
    required this.nickname,
    required this.time,
    required this.like,
    required this.chatting,
    required this.comment,
    required this.member,
  });
  final FeedModel feed; //fix:밑에 변수 feed.image...로 바꾸기
  final String imageUrl, nickname, time, comment;

  final int like, chatting, feedId;
  final Member member;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  bool isExpanded = false;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _checkLiked();
  }

  Future<void> _checkLiked() async {
    final prefs = await SharedPreferences.getInstance();
    isLiked = prefs.getBool('${widget.feed.feedId}') ?? false;
    setState(() {});
  }

  Future<void> _toggleLike() async {
    final prefs = await SharedPreferences.getInstance();
    final currentState = prefs.getBool('${widget.feed.feedId}') ?? false;
    if (currentState) {
      await FeedApiService.unLikeFeed(widget.feed.feedId);
      setState(() {
        widget.feed.likeCount -= 1;
      });
    } else {
      await FeedApiService.likeFeed(widget.feed.feedId);
      setState(() {
        widget.feed.likeCount += 1;
      });
    }
    await prefs.setBool('${widget.feed.feedId}', !currentState);

    setState(() {
      isLiked = !currentState;
    });
  }

  FeedController feedController = Get.find<FeedController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(
        top: 24,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      width: double.maxFinite,

      // color: Colors.amber,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.w, // 반지름을 설정하여 원의 크기 조절
                backgroundImage: NetworkImage(
                  widget.imageUrl,
                ),
              ),
              SizedBox(
                width: 9.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.nickname,
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: COLORS.defaultBlack,
                          letterSpacing: -0.30,
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Obx(() {
                        if (feedController.isMemberLeader) {
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 2, //fix : 영어의 닉네임일 경우 margin 없애기
                            ),
                            height: 8.h,
                            width: 8.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: COLORS.pink,
                            ),
                            child: Center(
                              child: Image.asset(
                                IMAGES.star,
                                width: 6,
                                height: 6,
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      })
                    ],
                  ),
                  Text(
                    TimeCalculator.getTimeDifference(widget.time),
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: COLORS.defaultGrey,
                      letterSpacing: -0.36,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              const Spacer(),
              FeedPopupMenu(feed: widget.feed),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          CarouselSlider.builder(
            itemCount: widget.feed.images.length,
            itemBuilder: (context, index, realIndex) {
              return ClipRRect(
                borderRadius:
                    BorderRadius.circular(10), // 여기서 원하는 만큼의 둥근 모서리 반경을 설정하세요.
                child: Image.network(
                  widget.feed.images[index].imageUrl,
                  width: 358.w,
                  height: 240.h,
                  fit: BoxFit.fill,
                ),
              );
            },
            options: CarouselOptions(
              enableInfiniteScroll: false,
              aspectRatio: 1.5,
              viewportFraction: 1,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 8,
              left: 8,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _toggleLike,
                  child: Image.asset(
                    isLiked ? IMAGES.filledHeart : IMAGES.heart,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  widget.feed.likeCount.toString(),
                  style: TextStyle(
                    color: COLORS.defaultBlack,
                    fontSize: 15.sp,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.45,
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => CommentModalSheet(
                          feedId: widget.feedId,
                          parentId: widget.member.memberId),
                    );
                  },
                  child: Image.asset(
                    IMAGES.comment,
                    width: 22.w,
                    height: 22.h,
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  widget.chatting.toString(),
                  style: TextStyle(
                    color: COLORS.defaultBlack,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.45,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 8,
              top: 8,
            ),
            // color: Colors.amber,
            child: Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: '${widget.nickname}  ', // nickname 다음에 공백 추가
                      style: TextStyle(
                        color: COLORS.defaultBlack,
                        fontSize: 15.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.45,
                      ),
                      children: [
                        TextSpan(
                          text: isExpanded
                              ? widget.comment
                              : (widget.comment.length > 20
                                  ? '${widget.comment.substring(0, 19)}... '
                                  : widget.comment),
                          style: const TextStyle(
                            color: COLORS.defaultBlack2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        !isExpanded && widget.comment.length > 20
                            ? TextSpan(
                                text: '더보기',
                                style: const TextStyle(
                                  color: COLORS.defaultGrey,
                                  fontWeight: FontWeight.w400,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      isExpanded = true;
                                    });
                                  },
                              )
                            : const TextSpan(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
