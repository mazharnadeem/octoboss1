import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CustomerFavoriteScreen extends StatelessWidget {
  const CustomerFavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    // alignment: Alignment.center,
                    width: screenWidth * 0.08,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      alignment: Alignment.center,
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                        size: screenHeight * 0.02,
                      ),
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: Text(
                        'favorite'.tr,
                        style: TextStyle(
                          // color: Colors.red,
                          fontSize: fontSize * 20,
                          // fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 10),
              // Expanded(
              //   child: StreamBuilder<QuerySnapshot>(
              //       stream: FirebaseFirestore.instance
              //           .collection('users')
              //           .where('isFavourite', isEqualTo: true)
              //           .snapshots(),
              //       builder: (context, snapshot) {
              //         if (snapshot.hasError) {
              //           return Text('Something went wrong ${snapshot.error}');
              //         }
              //         switch (snapshot.connectionState) {
              //           case ConnectionState.waiting:
              //             return Center(
              //               child: CircularProgressIndicator(
              //                 valueColor: AlwaysStoppedAnimation<Color>(
              //                     Color(0xffff6e01)),
              //               ),
              //             );
              //           default:
              //             return ListView(
              //               children: snapshot.data!.docs
              //                   .asMap()
              //                   .map((index, value) => MapEntry(
              //                         index,
              //                         GestureDetector(
              //                           onTap: () {
              //                             Get.to(OctoBossPublicProfile(
              //                               UID: value['UID'],
              //                               isFav: value['isFavourite'],
              //                             ));
              //                           },
              //                           child: Card(
              //                             child: ListTile(
              //                                 leading: CircleAvatar(
              //                                   backgroundImage: NetworkImage(
              //                                       value['image']),
              //                                   radius: 30,
              //                                   backgroundColor: Colors.white,
              //                                 ),
              //                                 title: Text(value['Name']),
              //                                 subtitle: Column(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     Text(
              //                                         'Home Repair from ${value['Country']}'),
              //                                   ],
              //                                 )),
              //                           ),
              //                         ),
              //                       ))
              //                   .values
              //                   .toList(),
              //             );
              //         }
              //       }),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
