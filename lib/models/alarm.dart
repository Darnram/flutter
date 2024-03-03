class AlarmInfo {
  final String? alarmPeriod;

  final int? hour, minute;
  final List<String>? alarmDays;
  bool isWork;

  AlarmInfo(
      {this.alarmPeriod,
      this.hour,
      this.minute,
      this.alarmDays,
      required this.isWork});
}

List<AlarmInfo> alarm = [
  AlarmInfo(
      alarmPeriod: '오전',
      hour: 10,
      minute: 30,
      alarmDays: ['월', '수', '금'],
      isWork: true),
  AlarmInfo(
      alarmPeriod: '오전', hour: 11, minute: 30, alarmDays: [], isWork: false),
  AlarmInfo(
      alarmPeriod: '오후',
      hour: 14,
      minute: 30,
      alarmDays: ['일', '월', '화', '수', '목', '금', '토'],
      isWork: true),
];
