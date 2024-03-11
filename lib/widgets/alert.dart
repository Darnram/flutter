import 'package:flutter/material.dart';

Future<void> showAlert({required BuildContext context})async {
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
  //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SearchScreen()));
}