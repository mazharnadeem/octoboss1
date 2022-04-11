import 'package:flutter/material.dart';
import 'package:octbs_ui/screens/users/Customer/cutomer_otp_screen.dart';

class CustomerForgotPasswordScreen extends StatelessWidget {
  const CustomerForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                        size: screenHeight * 0.02,
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Forgot your password',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: fontSize * 25,
                            // fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              // flex: 2,
              fit: FlexFit.loose,
              child: Container(
                  // alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  clipBehavior: Clip.antiAlias,
                  // width: screenWidth * 0.8,
                  // height: screenHeight * 0.26,
                  decoration: BoxDecoration(
                    // shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all(color: Colors.black),
                  ),
                  child: Image.asset(
                    'assets/images/Logo_NameSlogan_Map.png',
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(height: screenHeight * 0.03),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: TextFormField(
                decoration: InputDecoration(hintText: 'Email or Phone'),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Center(
              child: Container(
                width: screenWidth * 0.3,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => CustomerOTPScreen()));
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(
                      fontSize: fontSize * 17,
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xffff6e01),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)))),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
