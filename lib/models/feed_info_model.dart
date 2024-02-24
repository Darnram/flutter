class FeedInfoModel {
  final String title, duration, date, time, location, description;
  final int present, quota;

  FeedInfoModel.fromJson()
      : title = " React같이 공부하실 분",
        duration = "2023.3.23 ~ 2023.5.22",
        date = "월수금",
        time = "15:00",
        location = "경기도 과천시",
        present = 8,
        quota = 10,
        description =
            'React 공부방입니다. 성실하고 적극적으로 임하실 분들만 받습니다. 2회 이상 미참시 강퇴됩니다. 칼관리중';
}
