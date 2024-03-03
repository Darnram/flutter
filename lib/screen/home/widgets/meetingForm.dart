import 'package:daram/controller/party.dart';
import 'package:daram/provider/party.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/Colors.dart';
import '../../../constants/Gaps.dart';
import '../../../constants/Images.dart';
import '../../../constants/sizes.dart';
import '../../../models/party.dart';
import '../../feed/feed_screen.dart';

class Parties extends StatelessWidget {
  Parties({
    super.key,
  });
  PartyController partyController = Get.find<PartyController>();

  void _loadMeeting() async {
    print('전체 미팅 불러오기');
    if (partyController.isPartyLoading.value != true) {
      partyController.isPartyLoading.value = true;
      await getParty();
      partyController.isPartyLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadMeeting();

    return Obx(
      () => Expanded(
        child: partyController.isPartyLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : partyController.allParty.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(IMAGES.homeNoMeeting),
                      const Text(
                        '아직 참여하는 모임이 없어요',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: COLORS.homeNoMeetingText,
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
                    separatorBuilder: (BuildContext context, int index) =>
                        Gaps.v16,
                    itemCount: partyController
                        .partyCategories[partyController.selectedCategory.value]
                        .length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FeedScreen(
                                      party: partyController.partyCategories[
                                          partyController
                                              .selectedCategory.value][index],
                                    ))),
                        child: Container(
                          padding: const EdgeInsets.all(
                            Sizes.size10,
                          ),
                          decoration: const BoxDecoration(
                            color: COLORS.meetingCard,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                child: Image.network(
                                    partyController
                                        .partyCategories[partyController
                                            .selectedCategory.value][index]
                                        .img,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover),
                              ),
                              Gaps.h12,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    partyController
                                        .partyCategories[partyController
                                            .selectedCategory.value][index]
                                        .title,
                                    style: const TextStyle(
                                      color: COLORS.defaultBlack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(IMAGES.meetingCalendar),
                                      Gaps.h5,
                                      Text(
                                        '${partyController.partyCategories[partyController.selectedCategory.value][index].startedAt} ~ ${partyController.partyCategories[partyController.selectedCategory.value][index].endAt}',
                                        style: const TextStyle(
                                          color: COLORS.defaultGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            IMAGES.meetingLocation,
                                          ),
                                          Gaps.h5,
                                          Text(
                                            partyController
                                                .partyCategories[partyController
                                                    .selectedCategory
                                                    .value][index]
                                                .location,
                                            style: const TextStyle(
                                              color: COLORS.defaultGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gaps.h16,
                                      Row(
                                        children: [
                                          Image.asset(IMAGES.meetingUser),
                                          Gaps.h5,
                                          RichText(
                                            text: TextSpan(
                                                style: const TextStyle(
                                                    color: COLORS.defaultGrey),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '${partyController.partyCategories[partyController.selectedCategory.value][index].currentCount}',
                                                    style: const TextStyle(
                                                      color:
                                                          COLORS.defaultBlack2,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          '/${partyController.partyCategories[partyController.selectedCategory.value][index].max}'),
                                                ]),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    decoration: BoxDecoration(
                                      color: COLORS.hashTagBackground,
                                      border: Border.all(
                                          color: COLORS.hashTagBorder,
                                          width: 1),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(60),
                                      ),
                                    ),
                                    child: Text(
                                      '#${categories[partyController.allParty[index].partyType]}',
                                      style: const TextStyle(
                                          color: COLORS.defaultBlack2),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
