import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:octbs_ui/controller/api/userDetails.dart';
import 'package:octbs_ui/screens/users/Customer/customer_bottom_navigation_bar.dart';
import 'package:octbs_ui/screens/users/Octoboss/created_profile_login.dart';
import 'package:octbs_ui/screens/users/Octoboss/octoboss_bottom_navigation_bar.dart';
import 'package:octbs_ui/screens/users/Octoboss/octoboss_signup_screen.dart';

class OctoBossSigninScreen extends StatefulWidget {
  const OctoBossSigninScreen({Key? key}) : super(key: key);

  @override
  _OctoBossSigninScreenState createState() => _OctoBossSigninScreenState();
}

class _OctoBossSigninScreenState extends State<OctoBossSigninScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // WebServices webServices = WebServices.instance();
  String emailVerification = '';
  bool _passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
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
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: Text(
                        'Sign in',
                        // style: GoogleFonts.baloo(
                        //   color: Colors.red,
                        //   fontSize: 25,
                        //   fontWeight: FontWeight.w200,
                        // ),
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: fontSize * 25,
                          // fontWeight: FontWeight.w200,
                        ),
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
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
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
              Text(
                emailVerification,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.03),
              Column(
                children: [
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.09),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontSize: fontSize * 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.06),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            // border: Border.all(color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: InputBorder.none,
                              // contentPadding: EdgeInsets.symmetric(
                              //     horizontal: screenWidth * 0.03),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.09),
                            child: Text(
                              'Password',
                              style: TextStyle(
                                fontSize: fontSize * 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.06),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            // border: Border.all(color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: !_passwordVisibility,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisibility =
                                          !_passwordVisibility;
                                    });
                                  },
                                  icon: Icon(
                                    _passwordVisibility
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  )),
                              // contentPadding: EdgeInsets.symmetric(
                              //     horizontal: screenWidth * 0.03),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Spacer(),
                        Flexible(
                          fit: FlexFit.loose,
                          child: TextButton(
                            onPressed: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (ctx) =>
                              //         OctoBossForgotPassWordScrn()));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: fontSize * 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: screenWidth * 0.5,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ProfileORLogin()));
                            octoboss_login(emailController.text.toString(), passwordController.text.toString());
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: fontSize * 17,
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
                                      side: BorderSide(color: Colors.red)))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "I don't have an account:",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OctoBossSignUpScreen()));
                      },
                      child: Text('Create a Octoboss Account',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
  void octoboss_login(String email ,String password) async{
    try{
      var data={'email':email,'password':password};

      var data1=json.encode(data);
      var response=await post(Uri.parse('https://admin.noqta-market.com/new/API/Login.php'),

          // headers: <String, String>{
          //   'Content-Type': 'application/json; charset=UTF-8',
          // },
          // headers: <String, String>{
          //   'Content-Type': 'application/json',
          // },
          body: data1
      );
      print('Status Code:');
      if(response.statusCode==201){

        print('Status Code: 201');
        // print('Login Successfully');
        var data2=jsonDecode(response.body.toString());
        user_details=data2;
        setState(() {
        });
        // Fluttertoast.showToast(msg: '${data2['message'].toString()}',toastLength: Toast.LENGTH_LONG);
        Get.offAll(ProfileORLogin(),arguments: [user_details]);
        // Fluttertoast.showToast(msg: 'Success');
        print('Success');
      }
      else if(response.statusCode==200){
        print('Status Code: 200');

        // print('Login Successfully');
        var data2=jsonDecode(response.body.toString());
        Fluttertoast.showToast(msg: '${data2['message'].toString()}',toastLength: Toast.LENGTH_LONG);
        // Fluttertoast.showToast(msg: 'Success');
        // print(data);
        user_details=data2;
        setState(() {
        });
      }
      else{
        print('Failed');
        print('Status Code: Else');
        var data2=jsonDecode(response.body.toString());
        // Fluttertoast.showToast(msg: '${data2['message'].toString()}',toastLength: Toast.LENGTH_LONG);
        // Fluttertoast.showToast(msg: 'Failed');
        // Get.showSnackbar(data2);
        print(data2);
        user_details=data2;
        setState(() {

        });
      }

    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }

  }
}
