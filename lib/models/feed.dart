import 'package:get/get.dart';

class PartyInfo {
  late int partyId;
  late int memberId;
  late String memberEmail;
  late String img;
  late String title;
  late String description;
  late String? password;
  late int partyType;
  late int max;
  late int currentCount;
  late String startedAt;
  late String endAt;
  late String location;
  late bool deleted;
  late String updatedAt;

  PartyInfo({
    required this.partyId,
    required this.memberId,
    required this.memberEmail,
    required this.img,
    required this.title,
    required this.description,
    required this.password,
    required this.partyType,
    required this.max,
    required this.currentCount,
    required this.startedAt,
    required this.endAt,
    required this.location,
    required this.deleted,
    required this.updatedAt,
  });

  PartyInfo.fromJson(Map<String, dynamic> json)
      : partyId = json['partyId'],
        memberId = json['memberId'],
        memberEmail = json['memberEmail'],
        img = json['img'],
        title = json['title'],
        description = json['description'],
        password = json['password'] ?? '',
        partyType = json['partyType'],
        max = json['max'],
        currentCount = json['currentCount'],
        startedAt = json['startedAt'],
        endAt = json['endAt'],
        location = json['location'],
        deleted = json['deleted'],
        updatedAt = json['updatedAt'];
}

class FeedModel {
  int feedId;
  int memberId;
  String memberName;
  String updatedAt;
  List<ImageInfo> images;
  String content;
  int likeCount;
  bool hasNextSlice;
  RxBool isLiked = false.obs; //fix : 임시로 obs로 설정

  FeedModel({
    required this.feedId,
    required this.memberId,
    required this.memberName,
    required this.updatedAt,
    required this.images,
    required this.content,
    required this.likeCount,
    required this.hasNextSlice,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      feedId: json['feedId'],
      memberId: json['memberId'],
      memberName: json['memberName'],
      updatedAt: json['updatedAt'],
      images: (json['images'] as List)
          .map((imageJson) => ImageInfo.fromJson(imageJson))
          .toList(),
      content: json['content'],
      likeCount: json['likeCount'],
      hasNextSlice: json['hasNextSlice'],
    );
  }
}

class ImageInfo {
  int imageId;
  String imageUrl;
  int memberId;
  String memberEmail;
  String description;
  String createdAt;

  ImageInfo({
    required this.imageId,
    required this.imageUrl,
    required this.memberId,
    required this.memberEmail,
    required this.description,
    required this.createdAt,
  });

  factory ImageInfo.fromJson(Map<String, dynamic> json) {
    return ImageInfo(
      imageId: json['imageId'],
      imageUrl: json['imageUrl'],
      memberId: json['memberId'],
      memberEmail: json['memberEmail'],
      description: json['description'],
      createdAt: json['createdAt'],
    );
  }
}

class Member {
  late int memberId;
  late String email;
  late String nickname;
  late String img;
  late bool pro;
  late bool ban;

  Member({
    required this.memberId,
    required this.email,
    required this.nickname,
    required this.img,
    required this.pro,
    required this.ban,
  });
  Member.fromJson(Map<String, dynamic> json)
      : memberId = json['memberId'],
        email = json['email'],
        nickname = json['nickname'],
        img = json['img'],
        pro = json['pro'],
        ban = json['ban'];
}

class FeedLike {
  late int feedId;
  late int likeCount;

  FeedLike({
    required this.feedId,
    required this.likeCount,
  });
  FeedLike.fromJson(Map<String, dynamic> json)
      : feedId = json['feedId'] ?? 0,
        likeCount = json['likeCount'] ?? 0;
}

class CommentModel {
  late int commentId;
  late int memberId;
  late String memberName;
  late String content;
  late int likeCount;
  late String profileImg;
  late String createdAt;

  CommentModel({
    required this.commentId,
    required this.memberId,
    required this.memberName,
    required this.content,
    required this.likeCount,
    required this.profileImg,
    required this.createdAt,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['commentId'],
      memberId: json['memberId'],
      memberName: json['memberName'],
      content: json['content'],
      likeCount: json['likeCount'],
      profileImg: json['profileImg'],
      createdAt: json['createdAt'],
    );
  }
}
