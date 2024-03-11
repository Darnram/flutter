import 'package:daram/constants/Colors.dart';
import 'package:daram/constants/Images.dart';
import 'package:daram/models/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  // Future<List<AlarmInfo>>? _alarms;

  Future<List<AlarmInfo>> getAlarms() async {
    await Future.delayed(const Duration(seconds: 0));
    return alarm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0, //flutter scroll appbar 색상 변경 오류
        centerTitle: false,
        leadingWidth: 40,
        elevation: 0.0,
        leading: IconButton(
          padding: const EdgeInsets.only(
            left: 24,
            bottom: 3,
          ),
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 22,
          ),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ),
        title: Text(
          '알람리스트',
          style: TextStyle(
            color: COLORS.defaultBlack,
            fontSize: 20.sp,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            height: 0,
            letterSpacing: -0.44,
          ),
        ),
      ),
      body: FutureBuilder<List<AlarmInfo>>(
        future: getAlarms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: COLORS.main,
            ));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              children: snapshot.data!
                  .map(
                    (alarm) => Container(
                      width: 358.w,
                      height: 104.h,
                      margin: const EdgeInsets.only(top: 16),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(width: 1, color: COLORS.alarmListBorder),
                        boxShadow: const [
                          BoxShadow(
                            color: COLORS.alarmListShadow,
                            blurRadius: 11,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 17,
                                        left: 20,
                                      ),
                                      child: Text(
                                        '${alarm.alarmPeriod}',
                                        style: const TextStyle(
                                          color: COLORS.defaultBlack,
                                          fontSize: 22,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                          letterSpacing: -0.44,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                      ),
                                      child: Text(
                                        '${alarm.hour}:${alarm.minute}',
                                        style: const TextStyle(
                                          color: COLORS.defaultBlack,
                                          fontSize: 32,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                          letterSpacing: 0.32,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 14,
                                    right: 20,
                                  ),
                                  child: Switch(
                                    value: alarm.isWork,
                                    activeColor: COLORS.main,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        alarm.isWork = value ?? false;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 358.w,
                            height: 42.h,
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 20,
                            ),
                            decoration: const BoxDecoration(
                              color: COLORS.alarmListBorder,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: Wrap(
                              spacing: 4.0,
                              children: ['일', '월', '화', '수', '목', '금', '토']
                                  .map((day) => Text.rich(
                                        TextSpan(
                                          text: day,
                                          style: TextStyle(
                                            color:
                                                alarm.alarmDays!.contains(day)
                                                    ? COLORS.main
                                                    : COLORS.defaultGrey,
                                            fontSize: 15.sp,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.30,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
