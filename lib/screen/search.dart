import 'package:flutter/material.dart';

import '../constants/Gaps.dart';
import '../constants/sizes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  void onBackTap(){
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size16,vertical: Sizes.size24,),
          child: Column(
            children: [
              Row(children: [
                GestureDetector(
                  onTap: onBackTap,
                  child: Icon(Icons.arrow_back_ios,size: 25,),
                ),
                Expanded(
                  child: TextFormField(

                    decoration: InputDecoration(
                      fillColor: Colors.red,
                      hintText: '원하는 모임을 검색해보세요!'

                    )
                  ),
                ),
                Gaps.h20,
                Gaps.h5
              ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text('최근 검색어',style: TextStyle(color: Colors.black,fontSize: 15),),
                      Icon(Icons.more_vert,size: 20,)
                    ],)
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
