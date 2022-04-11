import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:octbs_ui/screens/users/services_bottom_sheet.dart';

class ServicesOfferedScreen extends StatefulWidget {
  const ServicesOfferedScreen({Key? key}) : super(key: key);

  @override
  _ServicesOfferedScreenState createState() => _ServicesOfferedScreenState();
}

class _ServicesOfferedScreenState extends State<ServicesOfferedScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                    size: screenHeight * 0.02,
                  ),
                ),
              ),
              Card(
                child: SizedBox(
                    height: screenHeight * 0.08,
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      'service'.tr,
                      style: TextStyle(
                        fontSize: fontSize * 20,
                      ),
                    ))),
              ),
              SizedBox(height: 20),
              // Expanded(
              //   child: StreamBuilder<QuerySnapshot>(
              //       stream: FirebaseFirestore.instance
              //           .collection('My Services')
              //           //.where('UID', isEqualTo: user!.uid)
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
              //                           onTap: () {},
              //                           child: ServiceWidget(
              //                             txt: value['service'],
              //                           ),
              //                         ),
              //                       ))
              //                   .values
              //                   .toList(),
              //             );
              //         }
              //       }),
              // ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      context: context,
                      builder: ((context) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: NameBottomSheet(),
                            ),
                          )));
                },
                child: Card(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                      Spacer(),
                      Text(
                        'Add New Service',
                        style: TextStyle(
                          fontSize: fontSize * 20,
                        ),
                      ),
                      Spacer(),
                      // IconButton(onPressed: () {}, icon: Icon(Icons.add))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceWidget extends StatelessWidget {
  ServiceWidget({Key? key, required this.txt}) : super(key: key);

  String txt;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        alignment: Alignment.center,
        height: screenHeight * 0.18,
        width: screenHeight * 0.18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          // borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: FittedBox(
            child: Text(
          txt,
          style: TextStyle(),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
