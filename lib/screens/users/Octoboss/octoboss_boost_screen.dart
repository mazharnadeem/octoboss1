import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octbs_ui/screens/users/Octoboss/payments/Golden_plan.dart';
import 'package:octbs_ui/screens/users/Octoboss/payments/Silver_plan.dart';
import 'package:octbs_ui/screens/users/Octoboss/payments/plantinum_plan.dart';

class OctobossBoostScreen extends StatefulWidget {
  OctobossBoostScreen({Key? key}) : super(key: key);

  @override
  State<OctobossBoostScreen> createState() => _OctobossBoostScreenState();
}

class _OctobossBoostScreenState extends State<OctobossBoostScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.04,
              left: screenHeight * 0.01,
              right: screenHeight * 0.01,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: screenWidth * 0.04),
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
                    //
                    // Spacer(),
                    SizedBox(width: screenWidth * 0.1),
                    Text(
                      'Boost'.tr,
                      style: TextStyle(
                        fontSize: fontSize * 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.3),
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: fontSize * 16,
                        //fontWeight: FontWeight.bold,
                      ),
                    )
                    // Spacer(),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 26),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '',
                        style: TextStyle(
                          fontSize: fontSize * 16,
                          //fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          screenWidth * 0.1,
                          screenWidth * 0.0,
                          screenWidth * 0.1,
                          screenWidth * 0),
                      child: Image.asset('assets/icons/logo.png'),
                    ),
                    Text(
                      'OctoBoss',
                      style: TextStyle(
                        fontSize: fontSize * 20,
                        color: Color(0xff2F302B),
                      ),
                    ),
                  ],
                ),
                //
                SizedBox(height: 35),

                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          CartPage(),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22)),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      'Boost for one week',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Text(
                                      '15CAD',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          Golden_Plan(),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22)),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      'Boost for 15 Days',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Text(
                                      '30CAD',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          Plantinum(),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22)),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      'Boost for one Month',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Text(
                                      '50CAD',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
