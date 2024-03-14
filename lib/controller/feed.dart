import 'package:daram/models/feed.dart';
import 'package:daram/provider/feed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedController extends GetxController {
  var isParticipate = true.obs;
  var isLeader = true.obs;
  var isMine = true.obs;
  var hasInput = false.obs;

  bool get isMemberLeader =>
      partyInfo.value?.memberId == member.value?.memberId; //fix: 확인해보기
  // var partyInfo = Rx<PartyInfo?>(null);

  void toggleParticipate() {
    isParticipate.value = !isParticipate.value;
  }

  void toggleLike(FeedModel feed) async {
    try {
      // FeedLike feedLike = await FeedApiService.getFeedLike(feed.feedId);

      feed.isLiked.value = !feed.isLiked.value;
      feed.likeCount += feed.isLiked.value ? 1 : -1;
      feeds.refresh();

      // feed.likeCount = feedLike.likeCount;
    } catch (e) {
      print('Error updating like count: $e');
    }
  }

  //Feed
  // final int partyId;
  var feeds = RxList<FeedModel>();
  Rx<PartyInfo?> partyInfo = Rx<PartyInfo?>(null);
  Rx<Member?> member = Rx<Member?>(null);

  // FeedController({});

  @override
  void onInit() {
    super.onInit();
    // fetchPartyInfo(partyId);
    // updateFeeds(partyId);
    fetchMember();
  }

  void updateFeeds(int partyId) async {
    try {
      var newFeeds = await FeedApiService.getFeedAll(partyId, 0);
      feeds.value = newFeeds;
    } catch (e) {
      print('Failed to update feeds: $e');
    }
  }

  void setPartyInfo(PartyInfo info) {
    partyInfo.value = info;
  }

  // void fetchPartyInfo(int partyId) async {
  //   try {
  //     var info = await FeedApiService.getPartyInfo(partyId);
  //     partyInfo.value = info;
  //   } catch (e) {
  //     print('Failed to fetch party info: $e');
  //   }
  // }

  void fetchMember() async {
    try {
      var info = await FeedApiService.getMember();
      member.value = info;
    } catch (e) {
      print('Failed to fetch member: $e');
    }
  }
}
