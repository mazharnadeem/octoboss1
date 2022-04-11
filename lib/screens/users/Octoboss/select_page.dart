import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octbs_ui/screens/users/Customer/customer_bottom_navigation_bar.dart';
import 'package:octbs_ui/screens/users/Customer/customer_signin_screen.dart';
import 'package:octbs_ui/screens/users/Customer/home/customer_home_screen.dart';
import 'package:octbs_ui/screens/users/Octoboss/created_profile_login.dart';
import 'package:octbs_ui/screens/users/Octoboss/octoboss_profile_screen_publicView.dart';
import 'package:octbs_ui/screens/users/Octoboss/octoboss_profile_scrn.dart';
import 'package:octbs_ui/screens/users/Octoboss/octoboss_signin_screen.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({Key? key}) : super(key: key);

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: Get.size.height*0.3,
                  width: Get.size.width*0.5,
                  child: Image.asset('assets/images/BigLogo.png'),
                ),
                SizedBox(
                  height: 25,
                ),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomerSignInScreen()));
                          },
                          child: Text(
                            'Customer',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xffff6e01),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OctoBossSigninScreen()));
                          },
                          child: Text(
                            'Octoboss',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xffff6e01),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

    );
  }
}
