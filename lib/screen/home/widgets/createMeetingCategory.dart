import 'package:daram/controller/party.dart';
import 'package:daram/models/party.dart';
import 'package:daram/provider/party.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/Colors.dart';
import '../../../constants/Gaps.dart';
import '../../../constants/sizes.dart';
import '../../../controller/new_party.dart';


class CreateMeetingCategories extends StatelessWidget {
  CreateMeetingCategories({
    super.key,
  });
  @override


  Widget build(BuildContext context) {
    final NewPartyController newPartyController = Get.find<NewPartyController>();
    List<int> index = [1,2,3,4,5,6];
    List<double> widthSize = [53,70,85,100];
    List<Widget> wraps = [
      for(int _index in index)
      GestureDetector(
        onTap: (){
          if(newPartyController.partyType.value == _index){
            newPartyController.partyType.value = 0;
            print('selectedCategory = ${newPartyController.partyType.value}');
            print('선택된 인덱스 =$_index');
          }else{
            newPartyController.partyType.value = _index;
            print('selectedCategory = ${newPartyController.partyType.value}');
            print('선택된 인덱스 =$_index');
          }
        },
        child:
        Obx(() =>Container(
          width: (_index == 3 || _index == 5 || _index == 6) ? widthSize[0] : ((_index == 4) ? widthSize[1] :(_index == 2) ?widthSize[2] : widthSize[3]),
          padding: EdgeInsets.symmetric(horizontal: Sizes.size10,vertical: Sizes.size4),
          decoration: BoxDecoration(
              color: COLORS.meetingCard,
              borderRadius: BorderRadius.all(Radius.circular(50),),
              border: newPartyController.partyType.value == _index ? Border.all(color: COLORS.main) : null),
          alignment: Alignment.center,
          child: Text('${categories[_index]}',
            style:TextStyle(color: newPartyController.partyType.value == _index ? COLORS.main : COLORS.categoryText,
              fontSize: 17,
            ),
          ),
        ),
        ),


      )
    ];
    return Wrap(

      direction: Axis.horizontal,
      spacing: 5, // 좌우 간격
      runSpacing: 5,
      alignment: WrapAlignment.start,
      children: wraps,
    );
  }
}