


import 'dart:io';

import 'package:daram/controller/new_party.dart';
import 'package:daram/controller/party.dart';
import 'package:daram/controller/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../constants/Images.dart';
import '../main.dart';
import '../models/party.dart';



const List<String> categories = [
  '전체',
  '취업/시험',
  '자기계발',
  '운동',
  '식습관',
  '친목',
  '기타'
];
/// Todo : sortType, pages, token, memberId는 하드코딩 되면 안됨




Future<dynamic> addParty({required Map<String,dynamic> data})async{
  final UserController userController = Get.find<UserController>();
  final NewPartyController newPartyController = Get.find<NewPartyController>();
  Future<dynamic> uploadPost({
    required int partyId,
  }) async {
    print('이미지 추가 api 진입');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${dotenv.env['DARNRAM_URL']}/party/add/img'),
      )
        ..headers.addAll({
          'Content-Type': 'application/json',
          'Member-Id': 'DHI ${userController.memberId.value}',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userController.accessToken.value}',
        })
        ..fields['partyId'] = '$partyId';
      print('이미지 request = ${request}');
      for (var image in newPartyController.newImage) {
        if(image != null){
          print('이미지 추가하기');
          request.files.add(await http.MultipartFile.fromPath(
            'img',
            image.path,
          ));
          print('request.files 사이즈 = ${request.files[0].length}');
        }
      }

      print('streamedResponse시작');
      var streamedResponse = await request.send();
      print('streamedResponse 종료');
      var response = await http.Response.fromStream(streamedResponse);
      print('response = ${response.statusCode}');
      if (response.statusCode != 200) {
        print('실패함');
        print('Response body: ${response.body}');
        throw Exception('Failed to upload post.');
      }else{
        print('Response body: ${response.body}');
        return true;
      }
  }
  try{
    final dataEncode = jsonEncode(data);
    print('dataEncode = ${dataEncode}');
    var url = Uri.parse('${dotenv.env['DARNRAM_URL']}/party/add/without-img');
    debugPrint('API 주소 = $url');
    debugPrint('보내는 데이터 = ${dataEncode.runtimeType}');
    final postResponse = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Member-Id': 'DHI ${userController.memberId.value}',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userController.accessToken.value}',
    },body: dataEncode);
    final body = postResponse.body;
    print('body = ${body}');
    print('postResponse 값 = ${postResponse.statusCode}');
    //var body = jsonDecode(postResponse.body);
    if(postResponse.statusCode != 200){
      print('postResponse 헤더 = ${postResponse.headers}');
      print('postResponse statusCode = ${postResponse.statusCode}');
      postResponse.printError();
      debugPrint('http 연결 문제');
      debugPrint('============= FAIL =============');
      return false;
    }else{
      /// 받아온 Api 데이터가 있을 경우
      if(body.isNotEmpty){
        print('postResponse.body 값 = ${json.decode(body)}');

        //uploadPost(partyId: )
      }
      /// Todo : 모임 비어있을 경우 테스트 필요
      else{
        print('바디 비어있음');
      }
    }
    final mapData = json.decode(body);
    print('body party id = ${mapData['partyId']}');
    print('데이터 타입 = ${mapData['partyId'].runtimeType}');
    await uploadPost(partyId: mapData['partyId']).then((value){
      newPartyController.clearNewParty();
      if(value){
        return true;
      }else{
        return false;
      }
    });
  }catch(e){
    print('without-img 에러 = $e');
    debugPrint('============= FAIL =============');
    return false;
  }
  return true;
}



Future<dynamic> getMyParty()async{
  final UserController userController = Get.find<UserController>();
  print('getMyParty 시작');
  List<dynamic> myPartyRawData = [];
  try{
    var url = Uri.parse('${dotenv.env['DARNRAM_URL']}/party/my');
    debugPrint('API 주소 = $url');
    final getResponse = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userController.accessToken.value}',
      'Member-Id': 'DHI ${userController.memberId.value}'
    });

    var body = jsonDecode(getResponse.body);

    if(getResponse.statusCode != 200){
      debugPrint('http 연결 문제');
      debugPrint('============= FAIL =============');
      return null;
    }else{
      /// 받아온 Api 데이터가 있을 경우
      if(body.isNotEmpty){
        PartyController partyController = Get.find<PartyController>();
        print('body = ${body}');
        print('body type ${body.runtimeType}');
        myPartyRawData = body;

        partyController.myParty.clear();
        for (var rawData in myPartyRawData){
          partyController.fetchMyParty(party: Party.fromJson(rawData));
        }
      }
      /// Todo : 모임 비어있을 경우 테스트 필요
      else{
        print('바디 비어있음');
      }
    }
  }catch(e){
    print('getMyParty 에러 = $e');
    debugPrint('============= FAIL =============');
    return null;
  }
}

Future<dynamic> getParty()async{
  final UserController userController = Get.find<UserController>();
  final PartyController partyController = Get.find<PartyController>();
  print('getParty 시작');
  List<dynamic> allPartyRawData = [];
    try{
      print('토큰 값 = ${userController.accessToken.value}');
      var url = Uri.parse('${dotenv.env['DARNRAM_URL']}/party?sortType=${partyController.sortTypeIndex.value}');
      debugPrint('API 주소 = $url');
      final getResponse = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userController.accessToken.value}',
        'Member-Id': 'DHI ${userController.memberId.value}'
      });

      var body = jsonDecode(getResponse.body);

      if(getResponse.statusCode != 200){
        debugPrint('http 연결 문제');
        debugPrint('============= FAIL =============');
        return null;
      }else{
        /// 받아온 Api 데이터가 있을 경우
        if(body.isNotEmpty){
          PartyController partyController = Get.find<PartyController>();
          print('body type ${body.runtimeType}');
          print('body = ${body}');
          allPartyRawData = body;
          partyController.allParty.clear();
          for (var rawData in allPartyRawData){
            partyController.fetchParty(party: Party.fromJson(rawData));
          }
          partyController.classificationParty();
        }
        /// Todo : 모임 비어있을 경우 테스트 필요
        else{
          print('바디 비어있음');
        }
      }
    }catch(e){
      print('getParty 에러 = $e');
      debugPrint('============= FAIL =============');
      return null;
  }
}