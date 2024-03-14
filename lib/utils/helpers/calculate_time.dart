class TimeCalculator {
  static String getTimeDifference(String time) {
    DateTime postTime = DateTime.parse(time);
    DateTime now = DateTime.now();
    Duration difference = now.difference(postTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else {
      return '${difference.inMinutes}분 전';
    }
  }
}
