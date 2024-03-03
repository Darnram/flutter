import 'package:daram/constants/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeedAppBar extends StatefulWidget {
  final bool isScrolled; // isScrolled 변수 추가
  final String imageUrl;

  const FeedAppBar({
    Key? key,
    required this.isScrolled, // 생성자를 통해 isScrolled 변수 받기
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<FeedAppBar> createState() => _FeedAppBarState();
}

class _FeedAppBarState extends State<FeedAppBar> {
  @override
  Widget build(BuildContext context) {
    bool isScrolled = widget.isScrolled;

    return SliverAppBar(
      elevation: 0.0,
      scrolledUnderElevation: 0, //flutter scroll appbar 색상 변경 오류
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      backgroundColor: Colors.white,
      expandedHeight: 160,
      pinned: true,
      stretch: true,

      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          widget.imageUrl,
          fit: BoxFit.cover,
        ),
        stretchModes: const [
          // StretchMode.blurBackground,
          StretchMode.zoomBackground,
        ],
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: isScrolled ? Colors.black : Colors.white,
          size: 24,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(-3.0),
        child: Container(
          height: 24,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
