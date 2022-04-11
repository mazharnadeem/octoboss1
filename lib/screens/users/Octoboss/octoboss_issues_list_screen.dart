import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class OctobossIssuesListScreen extends StatelessWidget {
  const OctobossIssuesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // User? user = FirebaseAuth.instance.currentUser;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Row(
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                          size: screenHeight * 0.02,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      'job'.tr,
                      style: TextStyle(
                        fontSize: fontSize * 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Expanded(
              //   child: StreamBuilder<QuerySnapshot>(
              //       stream: FirebaseFirestore.instance
              //           .collection('users')
              //           .doc(user!.uid)
              //           .collection('Jobs')
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
              //           case ConnectionState.none:
              //             return Center(child: Text('There is Nothing'));
              //           default:
              //             return ListView(
              //               children: snapshot.data!.docs
              //                   .asMap()
              //                   .map((index, value) => MapEntry(
              //                         index,
              //                         GestureDetector(
              //                           onTap: () {
              //                             showDialog(
              //                                 context: context,
              //                                 builder: (BuildContext context) {
              //                                   return ProfileReview(
              //                                     () {},
              //                                     true,
              //                                     '${value['Location']}',
              //                                     '${value['Language']}',
              //                                     '${value['Problem']}',
              //                                     '${value['Description']}',
              //                                   );
              //                                 });
              //                           },
              //                           child: Card(
              //                             child: ListTile(
              //                               leading: CircleAvatar(
              //                                 radius: 30,
              //                                 backgroundColor:
              //                                     Colors.transparent,
              //                                 child: Image.asset(
              //                                   'assets/images/qailah_profile.png',
              //                                   fit: BoxFit.cover,
              //                                 ),
              //                               ),
              //                               title: Text(
              //                                 value['Problem'],
              //                                 style: GoogleFonts.montserrat(
              //                                   fontSize: fontSize * 18,
              //                                   color: Color(0xffff6e01),
              //                                 ),
              //                               ),
              //                               subtitle: Text(
              //                                 value['Description'],
              //                                 style: GoogleFonts.montserrat(
              //                                   fontSize: fontSize * 15,
              //                                 ),
              //                                 overflow: TextOverflow.ellipsis,
              //                               ),
              //                               trailing: Text(
              //                                 value['Language'],
              //                                 style: GoogleFonts.montserrat(
              //                                   fontSize: fontSize * 15,
              //                                 ),
              //                               ),
              //                             ),
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
