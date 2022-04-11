import 'package:flutter/material.dart';
import 'package:octbs_ui/screens/users/Octoboss/octoboss_bottom_navigation_bar.dart';
import 'package:octbs_ui/screens/users/Octoboss/octoboss_profile_scrn.dart';

class ProfileORLogin extends StatefulWidget {
  ProfileORLogin({Key? key}) : super(key: key);

  @override
  State<ProfileORLogin> createState() => _ProfileORLoginState();
}

class _ProfileORLoginState extends State<ProfileORLogin> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, top: 80),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.c,
            children: [
              Container(
                height: 150,
                width: 150,
                child: Image.asset('assets/images/BigLogo.png'),
              ),
              SizedBox(
                height: 50,
              ),
              Text('Complete Your Profile',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 80,
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
                                  builder: (context) => EditProfilePage()));
                        },
                        child: Text(
                          'Complete Now',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xffff6e01),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)),
                          ),
                        ),
                      ),
                    ),

                    //  MaterialButton(
                    //   color: Colors.orange,
                    //   onPressed: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => OctoBossSigninScreen()));
                    //   },
                    //   child: Text(
                    //     'OctoBoss',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
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
                                      OctoBossBottomNavBar()));
                        },
                        child: Text(
                          'Do it Later',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xffff6e01),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
