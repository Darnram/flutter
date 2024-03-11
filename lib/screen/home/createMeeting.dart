import 'dart:io';

import 'package:daram/controller/new_party.dart';
import 'package:daram/controller/party.dart';
import 'package:daram/screen/home/widgets/createMeetingCategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/Colors.dart';
import '../../constants/Gaps.dart';
import '../../constants/Images.dart';
import '../../provider/party.dart';
import 'widgets/meetingCategory.dart';
import 'image_edit_screen.dart';

class CreateMeetingScreen extends StatefulWidget {
  const CreateMeetingScreen({super.key});

  @override
  State<CreateMeetingScreen> createState() => _CreateMeetingScreenState();
}

class _CreateMeetingScreenState extends State<CreateMeetingScreen> {

  final TextEditingController inputTitle = TextEditingController();
  final TextEditingController inputDescription = TextEditingController();
  final TextEditingController inputPassword = TextEditingController();
  final TextEditingController inputCalendar = TextEditingController();
  final TextEditingController inputLocation = TextEditingController();

  final PartyController _partyController = Get.find<PartyController>();
  final NewPartyController _newPartyController = Get.find<NewPartyController>();

  bool isPasswordShow = false;

  @override
  void initState() {

    super.initState();
    inputTitle.addListener(() {
      print('inputTitle.value.text = ${inputTitle.value.text}');
      _newPartyController.title.value = inputTitle.value.text;
    });
    inputDescription.addListener(() {
      print('inputDescription.value.text = ${inputDescription.value.text}');
      _newPartyController.description.value = inputDescription.value.text;
    });
    inputPassword.addListener(() {
      print('inputPassword.value.text = ${inputPassword.value.text}');
      _newPartyController.password.value = inputPassword.value.text;
    });
    /*inputCalendar.addListener(() {
      print('inputCalendar.value.text = ${inputCalendar.value.text}');
      inputCalendar.text = '${_newPartyController.start} ~ ${_newPartyController.end}';
      //_newPartyController.startAt.value = inputCalendar.value.text;
    });*/
    inputLocation.addListener(() {
      print('inputLocation.value.text = ${inputLocation.value.text}');
      _newPartyController.location.value = inputLocation.value.text;
    });

  }

  @override
  void dispose() {
    inputTitle.dispose();
    inputDescription.dispose();
    inputPassword.dispose();
    inputCalendar.dispose();
    inputLocation.dispose();
    super.dispose();
  }

  void _onImageEdit(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ImageUploadScreen()));
  }

  Future<void> _onCreateMeeting({required Map<String,dynamic>data})async{
    await addParty(data: data).then((value)async{
      if(value){
        _partyController.isMyPartyLoading.value = true;
        await getMyParty();
        _partyController.isMyPartyLoading.value = false;

        _partyController.isPartyLoading.value = true;
        await getParty().then((value){
          _partyController.isPartyLoading.value = false;
          Navigator.of(context).pop();
        });
      }
    });
  }


void onTapScaffold(){
    FocusScope.of(context).unfocus();
}
  Future<void> selectDateTimeRange() async {
    final NewPartyController _newPartyController = Get.find<NewPartyController>();
    final selectedDateRange = await showDateRangePicker(

      context: context,
      saveText: "선택",
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              // primary: MyColors.primary,
              primary: Theme
                  .of(context)
                  .colorScheme
                  .primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            //.dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );

    if (selectedDateRange == null) {
      return null;
    } else {
      print('selectedDateRange = ${selectedDateRange}');
      print('start = ${selectedDateRange.start}');
      print('end = ${selectedDateRange.end}');
      _newPartyController.startAt.value = '${selectedDateRange.start}'.split(' ')[0];
      _newPartyController.endAt.value = '${selectedDateRange.end}'.split(' ')[0];
    }
  }



  @override
  Widget build(BuildContext context) {

    if(_newPartyController.startAt.value != '' && _newPartyController.endAt.value != ''){
      inputCalendar.text = '${_newPartyController.startAt} ~ ${_newPartyController.endAt}';
    }
    Map<String,dynamic> meetingImage = {
      'img' : null,
    };


    return GestureDetector(
      onTap:
        onTapScaffold
      ,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,

            centerTitle: true,
            leading: IconButton(icon: Icon(Icons.arrow_back,),onPressed: (){
              _newPartyController.clearNewParty();
              Navigator.of(context).pop();
            },),
            title: Text('모임개설',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            actions: [
              TextButton(onPressed:()async{

                _newPartyController.printAllNewParty();
                print('통과 유무 =${_newPartyController.checkNewParty()}');
                if(_newPartyController.checkNewParty()){
                  Map<String, dynamic> meetingData = {
                    'title' : '${_newPartyController.title}',
                    'description' : '${_newPartyController.description}',
                    'password' : '${_newPartyController.password}',
                    'partyType' : _newPartyController.partyType.value,
                    'max' : _newPartyController.max.value,
                    'location' :'${_newPartyController.location}',
                    'memberEmail' : '${_newPartyController.memberEmail}',
                    'startedAt' : '${_newPartyController.startAt}',
                    'endAt' : '${_newPartyController.endAt}',
                  };
                  await _onCreateMeeting(data: meetingData);
                 /* await addParty( data: meetingData).then((value){
                    if(value){
                      Navigator.of(context).pop();
                    }
                  });*/
                }
              }, child: Obx(() => Text('만들기',style: TextStyle(color:_newPartyController.checkNewParty() ? COLORS.main :  Colors.grey,fontSize: 22))),),
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
                      child: Obx(()=>
                         Container(
                        width: 100,height: 100,
                        child: (_newPartyController.newImage.value != null && _newPartyController.newImage.isNotEmpty ) ?Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image:
                              DecorationImage(
                                  fit: BoxFit.cover,  //사진을 크기를 상자 크기에 맞게 조절
                                  image: FileImage(File(_newPartyController.newImage[0]!.path   // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                                  ))
                              )
                          ),
                        ) : Center(child: Image.asset(IMAGES.homeCamera,)),decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.shade50,),),
                      ),
                    ),
                  ),
                  TextField(
                    controller: inputTitle,
                    onSubmitted: (value){
                      _newPartyController.title.value = value;
                    },
                    decoration: InputDecoration(hintText: '모임 이름을 입력해주세요.',),),
                  Gaps.v20,
                  Text('모임설명',style: TextStyle(fontSize: 17),),
                  TextField(
                    controller: inputDescription,
                    onSubmitted: (value){
                      _newPartyController.description.value = value;
                    },
                    decoration: InputDecoration(hintText: '모임 설명을 입력해주세요.'),),
                  Gaps.v20,
                  Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('비공개 여부',style: TextStyle(fontSize: 17),),
                        CupertinoSwitch(value: isPasswordShow,onChanged: (value){
                        setState(() {
                          if(value){
                            isPasswordShow = value;
                          }else{
                            isPasswordShow = value;
                          }
                        });

                      },)]),
                  TextField(
                    controller: inputPassword,
                    enabled: isPasswordShow,
                    onSubmitted: (value){
                      _newPartyController.password.value = value;
                    },
                    decoration: InputDecoration(hintText: isPasswordShow ? '비밀번호를 입력해주세요.' : '비공개 여부를 켜주세요.' ),),
                  Gaps.v20,
                  Text('모임종류',style: TextStyle(fontSize: 17),),
                  Gaps.v10,
                  CreateMeetingCategories(),
                  Gaps.v24,
                  Row(children: [Text('정원수',style: TextStyle(fontSize: 17),),Image.asset(IMAGES.meetingUser,color: Colors.black,width: 19,height: 20,)]),
                  Text('정원 수는 최대 10명까지 가능해요!',style:TextStyle(fontSize: 12,color: Colors.grey.shade500)),
                  Obx(() =>Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [IconButton(onPressed: (){
                      _newPartyController.decreaseMax();
                    }, icon: FaIcon(FontAwesomeIcons.minus,size: 20,)),Text('${_newPartyController.max.value}',style: TextStyle(fontSize: 17),),IconButton(
                        onPressed: (){
                          _newPartyController.increaseMax();
                        },
                        icon: FaIcon(FontAwesomeIcons.plus,size: 20,))],),
                  ),
                  Gaps.v20,
                   Row(children: [Text('모임일정',style: TextStyle(fontSize: 17),),Gaps.h4,Image.asset(IMAGES.homeCalendarIcon,width: 20,height: 20,color: Colors.black,)]),
                  TextField(
                    onTap:()async{
                      selectDateTimeRange().then((value){
                        setState(() {
                        });
                      });
                    },
                    readOnly: true,

                    controller: inputCalendar,
                      decoration: InputDecoration(hintText: '시작일과 종료일을 입력해주세요.')
                  )
                  ,
                  Gaps.v20,
                  Row(children: [Text('모임장소',style: TextStyle(fontSize: 17),),Image.asset(IMAGES.meetingLocation,width: 20,height: 20,color: Colors.black,)]),
                  TextField(
                    controller: inputLocation,
                    onSubmitted: (value){
                      _newPartyController.location.value = value;
                    },
                    decoration: InputDecoration(hintText: '모임 설명을 입력해주세요.'),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
