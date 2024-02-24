import 'package:flutter/material.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  /// Material route to this screen.
  static Route get route =>
      MaterialPageRoute(builder: (_) => const NewPostScreen());

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: const Text(
          '새 피드',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            //fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          // <Widget>[
          //   TextButton(
          //     onPressed: () {},
          //     child: const Text('완료'),
          //   ),
          // ],
        ],
      ),
    );
  }
}

// appBar: AppBar(
//               backgroundColor: mobileBackgroundColor,
//               leading: IconButton(
//                 icon: const Icon(Icons.arrow_back),
//                 onPressed: clearImage,
//               ),
//               title: const Text(
//                 'Post to',
//               ),
//               centerTitle: false,
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () => postImage(
//                     userProvider.getUser.uid,
//                     userProvider.getUser.username,
//                     userProvider.getUser.photoUrl,
//                   ),
//                   child: const Text(
//                     "Post",
//                     style: TextStyle(
//                         color: Colors.blueAccent,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.0),
//                   ),
//                 )
//               ],
//             ),