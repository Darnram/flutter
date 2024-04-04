import 'dart:io';
import 'package:daram/controller/feed.dart';
import 'package:daram/controller/party_info.dart';
import 'package:daram/models/feed.dart';
import 'package:daram/provider/feed.dart';
import 'package:daram/widgets/feed_object_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:daram/constants/Colors.dart';
import 'package:daram/constants/Images.dart';
import 'package:daram/controller/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

class NewPostScreen extends StatefulWidget {
  final PartyInfo? partyInfo;
  final Member? member;
  final FeedModel? feed;
  final int type;
  const NewPostScreen(
      {super.key, required this.type, this.partyInfo, this.member, this.feed});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  // final PostController postController = Get.put(PostController());
  final PostController postController = Get.put(PostController());
  FeedController feedController = Get.find<FeedController>();
  final PartyInfoController partyInfoController =
      Get.find<PartyInfoController>();

  final picker = ImagePicker();
// XFile? image; // 카메라로 촬영한 이미지를 저장할 변수
  List<XFile?> multiImage = []; // 갤러리에서 여러장의 사진을 선택해서 저장할 변수
  // List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수

  List<ImageItem> images = [];

  @override
  void initState() {
    super.initState();
    if (widget.feed != null) {
      postController.getController(id).text = widget.feed!.content;
      images = images = widget.feed!.images
          .map((image) => ImageItem(path: image.imageUrl, isNetwork: true))
          .toList();
    }
  }

  final String id = 'textField';
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
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              setState(() {
                images.clear();
              });

              // postController.controller.clear();
              postController.getController(id).clear();
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
          title: Text(
            '새 피드',
            style: TextStyle(
              color: COLORS.defaultBlack,
              fontSize: 18.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              letterSpacing: -0.44,
              height: 0,
            ),
          ),
          actions: [
            Obx(
              () => TextButton(
                onPressed: () async {
                  if (!postController.getIsFilled(id)) {
                    return;
                  }
                  try {
                    if (widget.type == 0) {
                      print('${partyInfoController.partyId.value}');
                      await FeedApiService.uploadPost(
                        memberEmail: widget.member!.email,
                        partyId: partyInfoController.partyId.value,
                        content: postController.getController(id).text,
                        images: images
                            .whereType<XFile>()
                            .toList(), // null이 아닌 이미지만 전송
                      );
                      print('Post uploaded successfully.');
                    } else {
                      await FeedApiService.editFeed(
                        feedId: widget.feed!.feedId,
                        content: postController.getController(id).text,
                        images: images
                            .whereType<XFile>()
                            .toList(), // null이 아닌 이미지만 전송
                      );
                      print('Feed Edit successfully.');
                    }
                    feedController.updateFeeds(widget.partyInfo!.partyId);
                    postController.getController(id).clear();
                    images.clear();
                    Navigator.pop(context);
                  } catch (e) {
                    print('Failed to upload post: $e');
                  }
                },
                child: Text(
                  '완료',
                  style: TextStyle(
                    color: postController.getIsFilled(id)
                        ? COLORS.main
                        : COLORS.hrGrey,
                    fontSize: 18.sp,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.44,
                  ),
                ),
              ),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 120.h,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          multiImage = await picker.pickMultiImage();
                          setState(() {
                            images.addAll(multiImage
                                .map((xFile) => ImageItem(
                                    path: xFile!.path, isNetwork: false))
                                .toList());
                          });
                        },
                        child: Container(
                          width: 104,
                          height: 104,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: COLORS.meetingCard,
                          ),
                          child: Image.asset(
                            IMAGES.camera,
                            width: 54,
                            height: 54,
                          ),
                        ),
                      ),
                      for (var imageItem in images)
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              width: 104,
                              height: 104,
                              margin: const EdgeInsets.only(left: 15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: imageItem.isNetwork
                                      ? NetworkImage(imageItem.path)
                                      : FileImage(File(imageItem.path))
                                          as ImageProvider,
                                ),
                              ),
                            ),
                            Positioned(
                              top: -5,
                              right: -5,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: COLORS.imageDelete.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        images.remove(imageItem);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 30.h,
                thickness: 1,
                color: COLORS.hrGrey,
              ),
              Expanded(
                child: TextField(
                  // controller: postController.controller,
                  controller: postController.getController(id),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: '내용을 입력해주세요.',
                    hintStyle: TextStyle(
                      color: COLORS.categoryText,
                      fontSize: 15.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      height: 0.08,
                      letterSpacing: -0.30,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
