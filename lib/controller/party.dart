import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/party.dart';

class PartyController extends GetxController{
  final RxList<RxList<Party>> partyCategories = <RxList<Party>>[].obs;
  final RxList<Party> allParty = <Party>[].obs;
  final RxList<Party> oneParty = <Party>[].obs;
  final RxList<Party> twoParty = <Party>[].obs;
  final RxList<Party> threeParty = <Party>[].obs;
  final RxList<Party> fourParty = <Party>[].obs;
  final RxList<Party> fiveParty = <Party>[].obs;
  final RxList<Party> sixParty = <Party>[].obs;
  final Rx<int> selectedCategory = 0.obs;
  final Rx<XFile?> image = (null as XFile?).obs;
  final Rx<bool> isPartyLoading = false.obs;
  final Rx<bool> isMyPartyLoading = false.obs;
  final RxList<Party> myParty = <Party>[].obs;
  final Rx<int> sortTypeIndex = 0.obs;
  final RxList<String> sortType = ['인기순','최신순'].obs;


  void addImage({required XFile? imageFile}){
    image.value = imageFile;
    print('image = $image');
  }
  void fetchParty({required Party party}){
    allParty.add(party);
  }
  void fetchMyParty({required Party party}){
    myParty.add(party);
  }

  void clearPartyCategories(){
    oneParty.clear();
    twoParty.clear();
    threeParty.clear();
    fourParty.clear();
    fiveParty.clear();
    sixParty.clear();
  }

  void classificationParty(){
    clearPartyCategories();
    for(Party party in allParty){
      switch(party.partyType){
        case 1:
          oneParty.add(party);
          break;
        case 2:
          twoParty.add(party);
          break;
        case 3:
          threeParty.add(party);
          break;
        case 4:
          fourParty.add(party);
          break;
        case 5:
          fiveParty.add(party);
          break;
        case 6:
          sixParty.add(party);
          break;
        default:
          break;
      }
    }
    partyCategories.clear();
    partyCategories.addAll([
      allParty,oneParty,twoParty,threeParty,fourParty,fiveParty,sixParty
    ]
    );

  }

  List<Party> getParty(){
    return allParty;
  }
}