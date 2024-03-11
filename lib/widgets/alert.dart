import 'package:daram/constants/Colors.dart';
import 'package:flutter/material.dart';

import '../constants/Gaps.dart';

Future<void> showAlert({required BuildContext context}) async {
  await showDialog(
      context: context,
      barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('현재 지원하지 않는 기능이에요!',style: TextStyle(fontSize: 22),)),


          content: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('단람은 더 나은 서비스를 위해\n 2024년 3월 2차 출시를 앞두고 있어요!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15)),
                Gaps.v10,
                /*Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: COLORS.main,
                              borderRadius: BorderRadius.circular(30)
                            ),
                            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                            child: Text('예정 기능',style: TextStyle(fontSize: 14,color: Colors.white,),),
                          ),
                          Gaps.h4,
                          Text('알림, 채팅, 달성률, 친구추가기능',style: TextStyle(fontSize: 14),),
                        ],
                      )
                    ],
                  ),
                )*/
              ],
            ),

          ),

          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          actions: [
            Center(
              child: TextButton(
                child: const Text(
                  '확인',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
           /* Stack(
              children: [
                Positioned.fill(
                    child: Container(
                  decoration: BoxDecoration(
                      color: COLORS.alertColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                )),
                Center(
                  child: TextButton(
                    child: const Text(
                      '확인',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),*/
          ],
        );
      });
  //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SearchScreen()));
}
