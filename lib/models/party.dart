import 'package:flutter/material.dart';


class Party{
  late int partyId;
  late String img;
  late String title;
  late String password;
  late String startedAt;
  late String endAt;
  late String location;
  late int max;
  late int currentCount;
  late int partyType;
  late bool hasNextSlice;

  Party({
    required this.partyId,
    required this.img,
    required this.title,
    required this.password,
    required this.startedAt,
    required this.endAt,
    required this.location,
    required this.max,
    required this.currentCount,
    required this.partyType,
    required this.hasNextSlice,
});
  Party.fromJson(Map<String, dynamic>? map){
    partyId = map?['partyId'] ?? '';
    img = map?['img'] ?? '';
    title = map?['title'] ?? '';
    password = map?['password'] ?? '';
    startedAt = map?['startedAt'] ?? '';
    endAt = map?['endAt'] ?? '';
    location = map?['location'] ?? '';
    max = map?['max'] ?? '';
    currentCount = map?['currentCount'] ?? '';
    partyType = int.parse(map?['partyType'] ?? '0');
    hasNextSlice = map?['hasNextSlice'] ?? '';

  }

}