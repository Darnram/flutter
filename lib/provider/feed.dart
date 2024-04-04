import 'dart:convert';

import 'package:daram/controller/comment.dart';
import 'package:daram/controller/party_info.dart';
import 'package:daram/controller/user.dart';
import 'package:daram/models/feed.dart';
import 'package:daram/widgets/comment_object_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

final UserController userController = Get.find<UserController>();

final Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer ${userController.accessToken.value}',
  'Member-Id': 'DHI ${userController.memberId.value}'
};

class FeedApiService {
  static Future<dynamic> getPartyInfo(int id) async {
    final PartyInfoController partyInfoController =
        Get.find<PartyInfoController>();

    final url = Uri.parse(
        "${dotenv.env['DARNRAM_URL']}/no-auth/party/info?partyId=$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final party = jsonDecode(response.body);
      print('PartyInfo response= $party');
      partyInfoController.fetchPartyInfo(partyInfo: PartyInfo.fromJson(party));
    } else {
      throw Error();
    }
  }

  static Future<List<FeedModel>> getFeedAll(int id, int page) async {
    List<FeedModel> feedInstances = [];
    try {
      final url = Uri.parse(
          "${dotenv.env['DARNRAM_URL']}/no-auth/feed/all?partyId=$id&page=$page");
      final response = await http.get(url, headers: headers);
      print('FeedResponse = ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> feeds = jsonDecode(utf8.decode(response.bodyBytes));
        for (var feed in feeds) {
          // print('feed = $feed');
          feedInstances.add(FeedModel.fromJson(feed));
        }

        return feedInstances;
      } else {
        print('Failed to call API: status code = ${response.statusCode}');
        throw Error();
      }
    } catch (e) {
      print('Failed to call API: $e');
      throw Error();
    }
  }

  static Future<Member> getMember() async {
    final url = Uri.parse("${dotenv.env['DARNRAM_URL']}/member");
    final response = await http.get(url, headers: headers);
    //fix:각 feed에 대한 memberId -> header에 담아 보내기
    if (response.statusCode == 200) {
      final member = jsonDecode(utf8.decode(response.bodyBytes));
      print('Member response= $member');
      return Member.fromJson(member);
    }
    throw Error();
  }

  static Future<List<PartyMember>> partyMember(int id) async {
    List<PartyMember> memberInstances = [];
    final url = Uri.parse(
        "${dotenv.env['DARNRAM_URL']}/no-auth/party/member/all?partyId=$id");
    final response = await http.get(url, headers: headers);
    print('All member response = $response');
    if (response.statusCode == 200) {
      final List<dynamic> memberJson =
          jsonDecode(utf8.decode(response.bodyBytes));
      for (var member in memberJson) {
        memberInstances.add(PartyMember.fromJson(member));
      }

      return memberInstances;
    } else {
      print('Failed to call API: status code = ${response.statusCode}');
      throw Error();
    }
  }

  static Future<void> likeFeed(int id) async {
    final url = Uri.parse("${dotenv.env['DARNRAM_URL']}/feed/like?feedId=$id");
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Like response = $data');
      return data;
    }
    throw Error();
  }

  static Future<void> unLikeFeed(int id) async {
    final url =
        Uri.parse("${dotenv.env['DARNRAM_URL']}/feed/unlike?feedId=$id");
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('UnLike response = $data');
      return data;
    }
    throw Error();
  }

  static Future<void> uploadPost({
    required String memberEmail,
    required int partyId,
    required String content,
    required List<XFile> images,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${dotenv.env['DARNRAM_URL']}/feed/add'),
    )
      ..headers.addAll(headers)
      ..fields['memberEmail'] = memberEmail
      ..fields['partyId'] = partyId.toString()
      ..fields['content'] = content;

    for (var image in images) {
      request.files.add(await http.MultipartFile.fromPath(
        'images',
        image.path,
      ));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      print('Response body: ${response.body}');
      throw Exception('Failed to upload post.');
    }
  }

  static Future<void> editFeed({
    required int feedId,
    String? content,
    List<XFile>? images,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${dotenv.env['DARNRAM_URL']}/feed/edit'),
    )
      ..headers.addAll(headers)
      ..fields['feedId'] = feedId.toString();
    // content가 null이 아니면 필드에 추가
    if (content != null && content.isNotEmpty) {
      request.fields['content'] = content;
    }

    // images가 null이 아니고, 비어 있지 않으면 각 이미지를 파일로 추가
    if (images != null && images.isNotEmpty) {
      for (var image in images) {
        request.files.add(await http.MultipartFile.fromPath(
          'images',
          image.path,
        ));
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      print('Response body: ${response.body}');
      throw Exception('Failed to upload post.');
    }
  }

  static Future<void> reportFeed(int id, int type) async {
    final url = Uri.parse(
        '${dotenv.env["DARNRAM_URL"]}/feed/report?feedId=$id&reportType=$type');
    final response = await http.get(url, headers: headers);
    print(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('report Response body : ${response.body}');
      return data;
    } else {
      print('Failed Api call : ${response.statusCode}');
      throw Error();
    }
  }

  static Future<void> deleteFeed(int id) async {
    final url =
        Uri.parse("${dotenv.env['DARNRAM_URL']}/feed/delete?feedId=$id");
    print(url);
    final response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      print('Suceess Delete Feed');
    } else {
      print('Failed to call API: status code = ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Error();
    }
  }

  // static Future<void> editFeed(int id, String )
  static Future<void> commentAdd({
    required int feedId,
    required int parentId,
    required String content,
  }) async {
    print('feedId: $feedId'); // feedId 출력
    print('parentId: $parentId'); // parentId 출력
    print('content: $content');

    var response = await http.post(
      Uri.parse('${dotenv.env['DARNRAM_URL']}/comment/add'),
      headers: headers,
      body: json.encode({
        'feedId': feedId,
        'parentId': parentId,
        'content': content,
      }),
    );

    print('requestBody:$headers');

    if (response.statusCode != 200) {
      print('Comment Response body: ${response.statusCode}');
      throw Exception('Failed to upload post.');
    } else {
      print('Success! Response: ${response.body}');
    }
  }

  static Future<List<CommentModel>> commentAll(int id) async {
    final CommentController commentController = Get.put(CommentController());
    List<CommentModel> commentInstances = [];
    try {
      final url = Uri.parse(
          "${dotenv.env['DARNRAM_URL']}/no-auth/comment/all?feedId=$id");
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final comments = jsonDecode(utf8.decode(response.bodyBytes));
        print('Comment response = $comments');
        for (var comment in comments) {
          commentInstances.add(CommentModel.fromJson(comment));

          // commentController.fetchLikeCount(
          //     commentModel: CommentModel.fromJson(comment));
        }
        return commentInstances;
      } else {
        print('Failed to call API: status code = ${response.statusCode}');
        throw Error();
      }
    } catch (e) {
      print('Failed to call API: $e');
      throw Error();
    }
  }

  static Future<void> deleteComment(int id) async {
    final url =
        Uri.parse("${dotenv.env['DARNRAM_URL']}/comment/delete?commentId=$id");
    print(url);
    final response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      print('Suceess Delete Comment');
    } else {
      print('Failed to call API: status code = ${response.statusCode}');
      throw Error();
    }
  }

  static Future<void> likeComment(int id) async {
    final url =
        Uri.parse("${dotenv.env['DARNRAM_URL']}/comment/like?commentId=$id");
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Like Comment response = $data');
      return data;
    }
    throw Error();
  }

  static Future<void> unLikeComment(int id) async {
    final url =
        Uri.parse("${dotenv.env['DARNRAM_URL']}/comment/unlike?commentId=$id");
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('unLike Comment response = $data');
      return data;
    }
    throw Error();
  }

  static Future<void> joinParty(int id) async {
    final url =
        Uri.parse("${dotenv.env['DARNRAM_URL']}/party/join?partyId=$id");
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('join Party response = $data');
      return data;
    }
    throw Error();
  }
}
