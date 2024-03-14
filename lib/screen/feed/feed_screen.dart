import 'package:daram/constants/Images.dart';
import 'package:daram/controller/feed.dart';
import 'package:daram/controller/user.dart';
import 'package:daram/models/party.dart';

import 'package:daram/provider/feed.dart';
import 'package:daram/screen/feed/feed_appbar.dart';
import 'package:daram/widgets/participation_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/Colors.dart';
import '../../models/feed.dart';
import '../../widgets/feed_introduce.dart';
import '../../widgets/feed_object_widget.dart';
import './new_post_screen.dart';

class FeedScreen extends StatefulWidget {
  final Party party;
  const FeedScreen({Key? key, required this.party}) : super(key: key);
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();
  final UserController userController = Get.find<UserController>();
  bool _isScrolled = false;

  //자신의 feed
  bool isMine = true;
  late Future<List<FeedModel>> feeds;
  late Future<PartyInfo> partyInfo;
  // late Future<Member> member;

  @override
  void initState() {
    super.initState();
    userController.showUser();
    _scrollController.addListener(_scrollListener);
    partyInfo = FeedApiService.getPartyInfo(widget.party.partyId);
    feeds = FeedApiService.getFeedAll(widget.party.partyId, 0);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset > 100 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset < 100 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // FeedController feedController =
    //     Get.put(FeedController(partyId: widget.party.partyId));
    Get.put(FeedController()); //controller 등록
    FeedController feedController = Get.find<FeedController>();
    feedController.updateFeeds(widget.party.partyId);
    partyInfo.then((info) {
      feedController.setPartyInfo(info);
    });
    return Scaffold(
      floatingActionButton: Obx(
        () {
          return feedController.isParticipate.value |
                  feedController.isMemberLeader
              ? Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: COLORS.main),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 4,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NewPostScreen(
                              type: 0,
                              partyInfo: feedController.partyInfo.value!,
                              member: feedController.member.value!),
                        ),
                      );
                    },
                    child: Image.asset(IMAGES.edit),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ParticipationDialog();
                      },
                    );
                    // feedController.toggleParticipate();
                  },
                  child: Container(
                    width: 358,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: COLORS.main),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: COLORS.floatingButtonShadow,
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Text(
                      '모임 참여하기',
                      style: TextStyle(
                        color: COLORS.defaultBlack,
                        fontSize: 17.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.51,
                      ),
                    ),
                  ),
                );
        },
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          FeedAppBar(isScrolled: _isScrolled, imageUrl: widget.party.img),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Obx(() {
                  // Obx를 사용하여 partyInfo의 변화를 감지합니다.
                  var partyInfo = Get.find<FeedController>().partyInfo.value;
                  if (partyInfo == null) {
                    return const CircularProgressIndicator();
                  } else {
                    return FeedIntroduce(
                      partyInfo: partyInfo,
                    );
                  }
                }),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SpaceDelegate(
              widget: Container(
                height: 1,
                color: COLORS.hrGrey,
              ),
            ),
          ),
          Obx(() {
            if (feedController.feeds.isEmpty) {
              return SliverToBoxAdapter(
                  child: Container(
                child: const Text('no data'),
              ));
            } else {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    FeedModel feed = feedController.feeds[index];
                    return Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(
                        top: 8.h,
                      ),
                      child: Feed(
                          feed: feed,
                          feedId: feed.feedId,
                          imageUrl: feedController.member.value?.img ??
                              "https://via.placeholder.com/36x36",
                          nickname: feed.memberName,
                          time: feed.updatedAt,
                          like: feed.likeCount,
                          chatting: 10,
                          comment: feed.content,
                          member: feedController.member.value!),
                    );
                  },
                  childCount: feedController.feeds.length,
                ),
              );
            }
          }),
          SliverFillRemaining(
            child: Container(
              color: Colors.white,
              child: const Center(child: Text('Scrollable content here')),
            ),
          ),
        ],
      ),
    );
  }
}

class SpaceDelegate extends SliverPersistentHeaderDelegate {
  SpaceDelegate({required this.widget});

  Widget widget;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // 헤더의 내용을 구성하는 위젯을 반환합니다.
    return widget;
  }

  @override
  double get minExtent => 1;

  @override
  double get maxExtent => 1;

  @override
  bool shouldRebuild(SpaceDelegate oldDelegate) {
    // 헤더를 다시 빌드해야 하는지 여부를 반환합니다.
    return false;
  }
}
