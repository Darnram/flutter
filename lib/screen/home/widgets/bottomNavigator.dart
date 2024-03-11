import 'package:daram/screen/myPage/myPage.dart';
import 'package:daram/widgets/alert.dart';
import 'package:flutter/material.dart';

import '../../../constants/Colors.dart';
import '../../../constants/Images.dart';
import '../../../constants/sizes.dart';

class BottomNavigator extends StatelessWidget {
  BottomNavigator({
    super.key,
    required this.onCreateMeetingTap
  });
  final void Function() onCreateMeetingTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5, color: COLORS.bottomNavigatorBorder),
            right: BorderSide(width: 0.5, color: COLORS.bottomNavigatorBorder),
            top: BorderSide(width: 0.5, color: COLORS.bottomNavigatorBorder),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),),
        Center(child:
          Container(margin: EdgeInsets.only(bottom: 18),decoration: BoxDecoration(shape: BoxShape.circle,color: COLORS.main,),width: 64,height: 64,),),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 10,right: 10,left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  child: Column(
                    children: [
                      Image.asset(IMAGES.homeHomeIcon,color: COLORS.main,height: 24,width: 24,),
                      Text('홈',style: TextStyle(fontSize: 11,color: COLORS.main),),
                    ],
                  ),
                ),
                GestureDetector(onTap: ()async{
                  await showAlert(context: context);
                }, child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Image.asset(IMAGES.homeCalendarIcon,color: COLORS.bottomNavigatorImage,height: 24,width: 24,),
                      Text('알람일정',style: TextStyle(fontSize: 11,color: COLORS.bottomNavigatorImage),),
                    ],
                  ),
                )),
                GestureDetector(
                  onTap: onCreateMeetingTap,
                  child: Container(
                    width: 50,
                    child: Column(
                      children: [
                        Image.asset(IMAGES.homeAdd,color: Colors.white,height: 24,width: 24,),
                        Text('모임추가',style: TextStyle(fontSize: 11,color: Colors.white),),
                      ],
                    ),
                  ),
                ),
                GestureDetector(onTap: ()async{
                  await showAlert(context: context);
                }, child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Image.asset(IMAGES.homeFlag,color: COLORS.bottomNavigatorImage,),
                      Text('달성률',style: TextStyle(fontSize: 11,color: COLORS.bottomNavigatorImage),),
                    ],
                  ),
                )),
                GestureDetector(onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyPage()));
                }, child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Image.asset(IMAGES.homeCategory,color: COLORS.bottomNavigatorImage,),
                      Text('더보기',style: TextStyle(fontSize: 11,color: COLORS.bottomNavigatorImage),),
                    ],
                  ),
                ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
