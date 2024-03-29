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
import 'widgets/bottomNavigator.dart';
import 'widgets/meetingCategory.dart';
import 'widgets/meetingForm.dart';




class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {

    final PartyController _partyController =  Get.put(PartyController());

    void _onSearchTap(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SearchScreen()));
    }
    void _onCreateMeetingTap(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CreateMeetingScreen()));
    }
    final MeetingTabController meetingTabController = Get.put(MeetingTabController());

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            foregroundColor: COLORS.defaultGrey,
            actions: [
              Image.asset(IMAGES.notification,width: 24,height: 24,color: COLORS.defaultGrey),
              Gaps.h10,
              Image.asset(IMAGES.chat,width: 24,height: 24,),
              Gaps.h20,
            ],
            leading: GestureDetector(onTap:_onSearchTap,child: Image.asset(IMAGES.search,width: 24,height: 24,)),
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
                                            child: Row(
                                              children: [
                                                Icon(Icons.filter_list_alt),
                                                Text('인기순',style:TextStyle(fontSize: 15,color: COLORS.defaultBlack2,),),
                                              ],
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