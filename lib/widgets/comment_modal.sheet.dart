import 'package:daram/constants/Colors.dart';
import 'package:daram/constants/Gaps.dart';
import 'package:daram/constants/Images.dart';
import 'package:daram/controller/comment.dart';
import 'package:daram/controller/feed.dart';
import 'package:daram/controller/post.dart';
import 'package:daram/models/feed.dart';
import 'package:daram/provider/feed.dart';
import 'package:daram/widgets/comment_object_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommentModalSheet extends StatefulWidget {
  final int feedId, parentId;

  const CommentModalSheet({
    super.key,
    required this.feedId,
    required this.parentId,
  });

  @override
  State<CommentModalSheet> createState() => _CommentModalSheetState();
}

class _CommentModalSheetState extends State<CommentModalSheet> {
  final String id = 'commentTextField';
  late Future<List<CommentModel>> comments;

  @override
  void initState() {
    super.initState();
    comments = FeedApiService.commentAll(widget.feedId);
  }

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.put(PostController());
    FeedController feedController = Get.find<FeedController>();
    // CommentController commentController = Get.find<CommentController>();

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (_, ScrollController scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 146.w,
              height: 5,
              margin: const EdgeInsets.only(
                top: 12,
                bottom: 42,
              ),
              decoration: BoxDecoration(
                color: COLORS.hrGrey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            FutureBuilder<List<CommentModel>>(
              future: comments,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('데이터 로딩에 실패했습니다.'));
                } else {
                  final comments = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      // shrinkWrap: true, // 필요한 경우 shrinkWrap를 true로 설정
                      physics: const NeverScrollableScrollPhysics(),
                      // physics:
                      //     const NeverScrollableScrollPhysics(), // 스크롤이 중첩되지 않도록 설정할 수도 있음
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return Comment(comment: comments[index]); // 실제 댓글 위젯 생성
                      },
                    ),
                  );
                }
              },
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 96.h),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(
                  top: 13,
                  left: 12,
                  right: 12,
                ),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1, color: COLORS.hrGrey))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20.w,
                      backgroundImage: const NetworkImage(
                        //fix: memberAPI의 img가져와서 고치기
                        "https://via.placeholder.com/40x40",
                      ),
                    ),
                    Gaps.h8,
                    Expanded(
                      child: SizedBox(
                        child: TextField(
                          controller: postController.getController(id),
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                if (!postController.getIsFilled(id)) {
                                  return;
                                }
                                try {
                                  await FeedApiService.commentAdd(
                                    feedId: widget.feedId,
                                    parentId: 0,
                                    content:
                                        postController.getController(id).text,
                                  );

                                  print('Comment uploaded successfully.');

                                  postController.getController(id).clear();
                                } catch (e) {
                                  print('Failed to upload post: $e');
                                }
                              },
                              icon: Image.asset(
                                IMAGES.send,
                                width: 32.w,
                                height: 32.h,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(
                              top: 11,
                              left: 11,
                            ),
                            hintText: '댓글을 입력해보세요.',
                            hintStyle: TextStyle(
                              color: COLORS.categoryText,
                              fontSize: 15.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height: 0.08,
                              letterSpacing: -0.30,
                            ),
                            fillColor: COLORS.meetingCard,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                color: COLORS.meetingCard,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                color: COLORS.meetingCard,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   width: 318,
                    //   decoration: BoxDecoration(
                    //     color: COLORS.meetingCard,
                    //     borderRadius: BorderRadius.circular(20),
                    //     border: Border.all(
                    //       width: 1,
                    //       color: COLORS.meetingCard,
                    //     ),
                    //   ),
                    //   child: TextField(
                    //     maxLines: null,
                    //     keyboardType: TextInputType.multiline,
                    //     decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //       hintText: '댓글을 입력해보세요.',
                    //       hintStyle: TextStyle(
                    //         color: COLORS.categoryText,
                    //         fontSize: 15.sp,
                    //         fontFamily: 'Pretendard',
                    //         fontWeight: FontWeight.w400,
                    //         height: 0.08,
                    //         letterSpacing: -0.30,
                    //       ),
                    //     ),
                    //   ),
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
