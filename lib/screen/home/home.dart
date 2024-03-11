import 'package:daram/constants/Gaps.dart';
import 'package:daram/constants/sizes.dart';
import 'package:daram/controller/party.dart';
import 'package:daram/controller/tab.dart';
import 'package:daram/screen/home/createMeeting.dart';
import 'package:daram/screen/home/widgets/myMeetingForm.dart';
import 'package:daram/screen/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/Colors.dart';
import '../../constants/Images.dart';

import '../../models/party.dart';
import '../../provider/party.dart';
import '../../widgets/alert.dart';
import 'widgets/bottomNavigator.dart';
import 'widgets/meetingCategory.dart';
import 'widgets/meetingForm.dart';




class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {

    final PartyController _partyController =  Get.find<PartyController>();


    void _onCreateMeetingTap(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CreateMeetingScreen()));
    }
    final MeetingTabController meetingTabController = Get.put(MeetingTabController());

    void _loadMeeting()async{
      print('전체 미팅 불러오기');
      _partyController.isPartyLoading.value = true;
      await getParty();
      _partyController.isPartyLoading.value = false;
    }
    void changeSortType(){
      print('필터 버튼 클릭');
      if(_partyController.sortTypeIndex.value == 0){
        _partyController.sortTypeIndex.value = 1;
        _loadMeeting();

      }else if(_partyController.sortTypeIndex.value == 1){
        _partyController.sortTypeIndex.value = 0;
        _loadMeeting();
      }

    }

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            foregroundColor: COLORS.defaultGrey,
            actions: [
              GestureDetector(onTap: ()async{
                await showAlert(context: context);
              },  child: Image.asset(IMAGES.notification,width: 24,height: 24,color: COLORS.defaultGrey)),
              Gaps.h10,
              GestureDetector(onTap: ()async{
                await showAlert(context: context);
              }, child: Image.asset(IMAGES.chat,width: 24,height: 24,)),
              Gaps.h20,
            ],
            leading: GestureDetector(onTap:()async{
              await showAlert(context:context);
            },child: Image.asset(IMAGES.search,width: 24,height: 24,)),
            centerTitle: true,
            title: SizedBox(
              width: 106,
              height: 20,
              child: Image.asset(IMAGES.loginLogoText),
            ),
          ),
          body: Column(
            children: [

              TabBar(
                  controller: meetingTabController.controller,
                  indicatorColor: COLORS.defaultBlack,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontSize: 17,
                    color: COLORS.defaultBlack,
                    fontWeight: FontWeight.w600,),
                  indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 1,color: COLORS.main),insets: EdgeInsets.symmetric(horizontal: 14),),
                  tabs: meetingTabController.meetingTabs
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.size14,
                  ),
                  child:
                    TabBarView(
                      controller: meetingTabController.controller,
                      children: [
                        Column(
                          children: [
                            MeetingCategories(),
                            Expanded(
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('인기 단람', style:TextStyle(color: COLORS.defaultBlack,fontSize: 22,fontWeight: FontWeight.w600,),),
                                          GestureDetector(
                                            onTap: (){
                                              changeSortType();
                                            },
                                            child: Obx(() =>
                                              Row(
                                                children: [
                                                  Image.asset(IMAGES.homeSwap,color: Colors.black,),
                                                  Text('${_partyController.sortType[_partyController.sortTypeIndex.value]}',style:TextStyle(fontSize: 15,color: COLORS.defaultBlack2,),),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text('지금 단람에서 가장 인기 있는 모임이에요!',style:TextStyle(fontSize: 17,color:COLORS.defaultBlack2),),
                                    ],
                                  ),
                                   Parties(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // 내 모임
                         Column(children: [MyParties()]),
                      ],
                    ),
                  ),
                ),

              //BottomNavigator(),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            padding: EdgeInsets.zero,
            child: BottomNavigator(onCreateMeetingTap: _onCreateMeetingTap),
          )
      ),

    );
  }
}