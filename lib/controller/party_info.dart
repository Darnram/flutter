import 'package:daram/controller/user.dart';
import 'package:daram/models/feed.dart';
import 'package:get/get.dart';

class PartyInfoController extends GetxController {
  final Rx<int> partyId = 0.obs;
  final Rx<int> memberId = 0.obs;
  final Rx<String> memberEmail = ''.obs;
  final Rx<String> img = ''.obs;
  final Rx<String> title = ''.obs;
  final Rx<String> description = ''.obs;
  final Rx<String?> password = Rx<String?>(null);
  final Rx<int> partyType = 0.obs;
  final Rx<int> max = 0.obs;
  final Rx<int> currentCount = 0.obs;
  final Rx<String> startedAt = ''.obs;
  final Rx<String> endAt = ''.obs;
  final Rx<String> location = ''.obs;
  final Rx<bool> deleted = false.obs;
  final Rx<String> updatedAt = ''.obs;
  final Rx<bool> isAdminister = false.obs;
  final Rx<bool> isParticipate = false.obs;

  void checkAdminStatus() {
    // UserController의 인스턴스를 찾음
    final UserController userController = Get.find<UserController>();

    // UserController의 memberId와 PartyInfoController의 memberId를 비교
    isAdminister.value = userController.memberId.value == memberId.value;
  }

  void fetchPartyInfo({required PartyInfo partyInfo}) {
    partyId.value = partyInfo.partyId;
    memberId.value = partyInfo.memberId;
    memberEmail.value = partyInfo.memberEmail;
    img.value = partyInfo.img;
    title.value = partyInfo.title;
    description.value = partyInfo.description;
    password.value = partyInfo.password;
    partyType.value = partyInfo.partyType;
    max.value = partyInfo.max;
    currentCount.value = partyInfo.currentCount;
    startedAt.value = partyInfo.startedAt;
    endAt.value = partyInfo.endAt;
    location.value = partyInfo.location;
    deleted.value = partyInfo.deleted;
    updatedAt.value = partyInfo.updatedAt;
  }

  void showPartyInfo() {
    print('showPartyInfo');
    print('memberId = $memberId');
  }
}
