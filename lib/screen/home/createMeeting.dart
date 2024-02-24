import 'package:daram/controller/party.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/Gaps.dart';
import '../../provider/party.dart';
import 'widgets/meetingCategory.dart';
import 'image_edit_screen.dart';

class CreateMeetingScreen extends StatefulWidget {
  const CreateMeetingScreen({super.key});

  @override
  State<CreateMeetingScreen> createState() => _CreateMeetingScreenState();
}

class _CreateMeetingScreenState extends State<CreateMeetingScreen> {
  
  void _onImageEdit(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ImageUploadScreen()));
  }

  Future<void> _onCreateMeeting({required Map<String,dynamic>data, required String? imageFilePath})async{
    await addParty(imageFilePath: imageFilePath,data: data).then((value)async{
      final PartyController _partyController = Get.find<PartyController>();
      _partyController.isMyPartyLoading.value = true;
        await getMyParty();
          _partyController.isMyPartyLoading.value = false;

      _partyController.isPartyLoading.value = true;
        await getParty().then((value){
          _partyController.isPartyLoading.value = false;
          Navigator.of(context).pop();
        });

    });
  }

  @override
  Widget build(BuildContext context) {
    final int testNum = 1;
    Map<String, dynamic> meetingData = {
      'title' : 'title test$testNum',
      'description' : 'description$testNum',
      'password' : 'password$testNum',
      'partyType' : testNum,
      'max' : testNum,
      'location' :'location$testNum',
      'memberEmail' : 'memberEmail@email.com',
      'startedAt' : '2022-10-22',
      'endAt' : '2022-10-24',
    };
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('모임개설',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          actions: [
            TextButton(onPressed:()async => await _onCreateMeeting(data: meetingData, imageFilePath: null), child: Text('만들기'),),
          ],

        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:EdgeInsets.symmetric(horizontal: 20,vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _onImageEdit,
                  child: Container(height: 150,
                    alignment: Alignment.center,
                    child: Container(
                    width: 100,height: 100,
                    child: Center(child: Text('이미지')),decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300,),),
                  ),
                ),
                TextField(decoration: InputDecoration(hintText: '모임 이름을 입력해주세요.'),),
                Gaps.v20,
                Text('모임설명'),
                TextField(decoration: InputDecoration(hintText: '모임 설명을 입력해주세요.'),),
                Gaps.v20,
                Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('비공개 여부'), Switch(value: false,onChanged: (_){},)]),
                TextField(decoration: InputDecoration(hintText: '비밀번호를 입력해주세요.'),),
                Gaps.v20,
                Text('모임종류'),
                MeetingCategories(),
                Row(children: [Text('정원수'),Icon(Icons.people)]),
                Text('정원 수는 최대 10명까지 가능해요!',style:TextStyle(fontSize: 10,color: Colors.grey.shade300)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Icon(Icons.add),Text('1'),Icon(Icons.add)],),
                Gaps.v20,
                 Row(children: [Text('모임일정'),Icon(Icons.calendar_month)]),
                TextField(decoration: InputDecoration(hintText: '모임 설명을 입력해주세요.'),),
                Gaps.v20,
                Row(children: [Text('모임장소'),Icon(Icons.gps_fixed)]),
                TextField(decoration: InputDecoration(hintText: '모임 설명을 입력해주세요.'),),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
