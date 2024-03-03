import 'package:daram/constants/Colors.dart';
import 'package:daram/constants/Gaps.dart';
import 'package:daram/constants/Images.dart';
import 'package:daram/controller/feed.dart';
import 'package:daram/controller/post.dart';
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
  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.put(PostController());
    FeedController feedController = Get.find<FeedController>();

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (_, controller) => Container(
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
            Flexible(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                ),
                children: const [
                  Comment(),
                ],
              ),
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
