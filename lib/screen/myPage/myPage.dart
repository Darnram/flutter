import 'package:daram/constants/Gaps.dart';
import 'package:daram/controller/user.dart';
import 'package:daram/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/sizes.dart';
import '../../provider/login.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.v20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(

              children: [
                Container(
                  color: Colors.grey.shade100,
                  child: Icon(
                    Icons.person,
                    size: 100,
                  ),
                ),
                Gaps.h10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('닉네임',style: TextStyle(fontSize: 13),),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async{
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
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    children: [
                                      Text('프로필 수정',style: TextStyle(fontSize: 15),),
                                      Icon(Icons.settings,size: 15,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text('${userController.nickname.value}님',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                      Text(userController.email.value,style: TextStyle(fontSize: 15),)
                    ],
                  ),
                )
              ],
            ),
          ),
          Gaps.v20,
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade100,
          ),
Gaps.v20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('이용안내',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                Gaps.v9,
                Text('이용제한 내역',style: TextStyle(fontSize: 15),),
                Gaps.v9,
                Text('문의하기',style: TextStyle(fontSize: 15),),
                Gaps.v9,
                Text('유저신고하기',style: TextStyle(fontSize: 15),),
                Gaps.v9,
                Text('공지사항',style: TextStyle(fontSize: 15),),
                Gaps.v9,
                Text('오픈소스 라이선스',style: TextStyle(fontSize: 15),),
                Gaps.v9,
                Text('개인정보 처리 방침',style: TextStyle(fontSize: 15),),
                Gaps.v9,
                GestureDetector(onTap: ()async{
                  await deleteAutoLogin().then((value){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                  });
                }, child: Text('로그아웃',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
                Gaps.v5,
              ],
            ),
          )
        ],
      ),
    ));
  }
}
