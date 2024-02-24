import 'package:daram/controller/party.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../provider/party.dart';

class ImageUploadScreen extends StatefulWidget {

  @override
  State<ImageUploadScreen> createState() => ImageUploadScreenState();
}

final picker = ImagePicker();
XFile? image; // 카메라로 촬영한 이미지를 저장할 변수
List<XFile?> multiImage = []; // 갤러리에서 여러장의 사진을 선택해서 저장할 변수
List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수

class ImageUploadScreenState extends State<ImageUploadScreen> {
  final PartyController _partyController = Get.find<PartyController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    //카메라로 촬영하기
                    Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.lightBlueAccent, borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 0.5, blurRadius: 5)
                          ],
                        ),
                        child: IconButton(
                            onPressed: () async {
                              image = await picker.pickImage(source: ImageSource.camera);

                              if (image != null) {
                                setState(() {
                                  images.add(image);
                                });
                              }
                            },
                            icon: Icon(Icons.add_a_photo, size: 30, color: Colors.white,)
                        )
                    ),
                    //갤러리에서 가져오기
                    Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.lightBlueAccent, borderRadius: BorderRadius.circular(5),
                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 0.5, blurRadius: 5)],
                        ),
                        child: IconButton(
                            onPressed: () async {multiImage = await picker.pickMultiImage();
                            setState(() {

                              images.addAll(multiImage);
                            });
                            },
                            icon: Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 30,
                              color: Colors.white,
                            )
                        )
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.lightBlueAccent, borderRadius: BorderRadius.circular(5),
                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 0.5, blurRadius: 5)],
                        ),
                        child: IconButton(
                            onPressed: () async {
                            setState(() {
                              if(images.first != null){
                                _partyController.addImage(imageFile: images.first);
                              }
                            });
                            if(images.first != null){
                              //addParty(imageFilePath: images.first!.path);
    }
                            },
                            icon: Icon(
                              Icons.add_to_photos_rounded,
                              size: 30,
                              color: Colors.white,
                            )
                        )
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: GridView.builder(padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: images.length, //보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //1 개의 행에 보여줄 사진 개수
                      childAspectRatio:
                      1 / 1, //사진 의 가로 세로의 비율
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {

                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image:
                                DecorationImage(
                                    fit: BoxFit.cover,  //사진을 크기를 상자 크기에 맞게 조절
                                    image: FileImage(File(images[index]!.path   // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                                    ))
                                )
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                BorderRadius.circular(5),
                              ),
                              //삭제 버튼
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                icon: Icon(Icons.close,
                                    color: Colors.white,
                                    size: 15),
                                onPressed: () {
                                  //버튼을 누르면 해당 이미지가 삭제됨
                                  setState(() {
                                    images.remove(images[index]);
                                  });
                                },
                              )
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            )
        )
    );
  }
}