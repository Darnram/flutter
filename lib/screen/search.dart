import 'package:flutter/material.dart';

import 'home/widgets/meetingForm.dart';


// 검색어

// 검색을 위해 앱의 상태를 변경해야하므로 StatefulWidget 상속



class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MemoApp', // 앱의 아이콘 이름
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20,),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '검색어를 입력해주세요.',

                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {

                },
              ),
            ),
            Expanded(
              child:  Column(children: [Parties()] ),
            ),
          ],
        ),
      ),
    );;
  }
}



/*
// 선택한 항목의 내용을 보여주는 추가 페이지
class ContentPage extends StatelessWidget {
  final String content;

  const ContentPage({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Content'),
      ),
      body: Center(
        child: Text(content),
      ),
    );
  }
}*/
