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


  @override
  Widget build(BuildContext context) {


    return Obx(() =>
      Expanded(
        child: partyController.isPartyLoading.value ? Center(child: CircularProgressIndicator(),) : partyController.allParty.isEmpty ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(IMAGES.homeNoMeeting),
            Text('아직 참여하는 모임이 없어요',style:TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: COLORS.homeNoMeetingText,),),
          ],
        )
            : ListView.separated(
          padding: EdgeInsets.symmetric(vertical: Sizes.size20),
          separatorBuilder: (BuildContext context, int index) => Gaps.v16,
          itemCount: partyController.partyCategories[partyController.selectedCategory.value].length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {

            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FeedScreen())),
              child: Container(
                padding: EdgeInsets.all(
                  Sizes.size10,
                ),
                decoration: BoxDecoration(
                  color: COLORS.meetingCard,
                  borderRadius: BorderRadius.all(Radius.circular(
                    10,
                  ),),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
                      child: Image.network(partyController.partyCategories[partyController.selectedCategory.value][index].img,width: 100,height: 100,fit:BoxFit.cover),),
                    Gaps.h12,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          partyController.partyCategories[partyController.selectedCategory.value][index].title,
                          style: TextStyle(
                            color: COLORS.defaultBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(IMAGES.meetingCalendar),
                            Gaps.h5,
                            Text('${partyController.partyCategories[partyController.selectedCategory.value][index].startedAt} ~ ${partyController.partyCategories[partyController.selectedCategory.value][index].endAt}',
                              style: TextStyle(
                                color: COLORS.defaultGrey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Image.asset(IMAGES.meetingLocation,),
                                Gaps.h5,
                                Text(partyController.partyCategories[partyController.selectedCategory.value][index].location,
                                  style: TextStyle(
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
                                      style: TextStyle(color: COLORS.defaultGrey),
                                      children: [
                                        TextSpan(text:'${partyController.partyCategories[partyController.selectedCategory.value][index].currentCount}',
                                          style: TextStyle(color: COLORS.defaultBlack2,
                                          ),
                                        ),
                                        TextSpan(text:'/${partyController.partyCategories[partyController.selectedCategory.value][index].max}'),
                                      ]
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Text('#${categories[partyController.allParty[index].partyType]}',style:TextStyle(color: COLORS.defaultBlack2),),
                          decoration: BoxDecoration(
                            color: COLORS.hashTagBackground,
                            border: Border.all(color: COLORS.hashTagBorder,width: 1),
                            borderRadius:
                            BorderRadius.all(Radius.circular(60),),
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