import 'package:daram/models/feed.dart';
import 'package:daram/provider/feed.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final Rx<int> likeCount = 0.obs;
  // final Rx<int> commentId = 0.obs;
  // final Rx<int> memberId = 0.obs;
  // final Rx<String> memberName = ''.obs;
  // final Rx<String> content = ''.obs;
  // final Rx<int> likeCount = 0.obs;
  // final Rx<String> createdAt = ''.obs;
  // final Rx<String> img = ''.obs;
  final RxList<CommentModel> comment = <CommentModel>[].obs;

  // void fetchComment({required CommentModel commentModel}) {
  //   commentId.value = commentModel.commentId;
  //   memberId.value = commentModel.memberId;
  //   memberName.value = commentModel.memberName;
  //   content.value = commentModel.content;
  //   likeCount.value = commentModel.likeCount;
  //   createdAt.value = commentModel.createdAt;
  // }
  void fetchComment({required CommentModel commentModel}) {
    comment.add(commentModel);
  }

  void fetchLikeCount({required CommentModel coommentModel}) {
    likeCount.value = coommentModel.likeCount;
  }

  List<CommentModel> getComment() {
    return comment;
  }

  // void showUser() {
  //   print('commentId :$commentId');
  //   print('memberId :$memberId');
  // }
}
