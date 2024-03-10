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
              Image.asset(IMAGES.homeHome,color: COLORS.main),
              GestureDetector(onTap: ()async{

                await showDialog(
                    context: context,
                    barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(child: Text('현재 지원하지 않는 기능이에요!',style: TextStyle(fontSize: 22),)),

                        content: Container(
                          height: MediaQuery.of(context).size.height*0.1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('단람은 더 나은 서비스를 위해\n 2024년 3월 2차 출시를 앞두고 있어요!',textAlign: TextAlign.center,style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                        insetPadding: const  EdgeInsets.fromLTRB(10,0,10, 0),
                        actions: [
                          Center(
                            child: TextButton(
                              child: const Text('확인'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      );
                    }
                );
              }, child: Image.asset(IMAGES.homeCalendar,color: COLORS.bottomNavigatorImage,)),
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
              GestureDetector(onTap: ()async{

                await showDialog(
                    context: context,
                    barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(child: Text('현재 지원하지 않는 기능이에요!',style: TextStyle(fontSize: 22),)),

                        content: Container(
                          height: MediaQuery.of(context).size.height*0.1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('단람은 더 나은 서비스를 위해\n 2024년 3월 2차 출시를 앞두고 있어요!',textAlign: TextAlign.center,style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                        insetPadding: const  EdgeInsets.fromLTRB(10,0,10, 0),
                        actions: [
                          Center(
                            child: TextButton(
                              child: const Text('확인'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      );
                    }
                );
              }, child: Image.asset(IMAGES.homeScore,color: COLORS.bottomNavigatorImage,)),
              GestureDetector(onTap: (){
Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyPage()));
              }, child: Image.asset(IMAGES.homeMore,color: COLORS.bottomNavigatorImage,))
            ],
          )),
    );
  }
}
