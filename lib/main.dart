import 'package:daram/screen/home/home.dart';
import 'package:daram/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'constants/Colors.dart';
import 'controller/party.dart';

void main() async{
  await dotenv.load(fileName: '.env').then((value){

    print('값1 == ${dotenv.env['KAKAO_NATIVE_KEY']}');
    print('값2 == ${dotenv.env['DARNRAM_URL']}');
  });
  KakaoSdk.init(nativeAppKey: '${dotenv.env['KAKAO_NATIVE_KEY']}');

  runApp(const Daram());
}
const String SORT_TYPE = '0';
const String PAGES = '0';
class Daram extends StatelessWidget {
  const Daram({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          bottomAppBarTheme: const BottomAppBarTheme(
            elevation: 0,
            color: Colors.white,
          ),
          primaryColor: COLORS.main,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
