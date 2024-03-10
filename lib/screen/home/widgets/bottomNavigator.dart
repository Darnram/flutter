import 'package:daram/screen/myPage/myPage.dart';
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
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          padding: EdgeInsets.only(
            bottom: Sizes.size32,
            top: Sizes.size10,
            right: Sizes.size24,
            left: Sizes.size24,
          ),
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
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(IMAGES.homeHome,color: COLORS.bottomNavigatorImage),
              Image.asset(IMAGES.homeCalendar,color: COLORS.bottomNavigatorImage,),
              GestureDetector(
                onTap: onCreateMeetingTap,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: COLORS.main,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(IMAGES.homeAdd,color: Colors.white,),),
              ),
              Image.asset(IMAGES.homeScore,color: COLORS.bottomNavigatorImage,),
              GestureDetector(onTap: (){
Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyPage()));
              }, child: Image.asset(IMAGES.homeMore,color: COLORS.bottomNavigatorImage,))
            ],
          )),
    );
  }
}
