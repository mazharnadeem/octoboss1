import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:octbs_ui/controller/api/userDetails.dart';
import 'package:octbs_ui/screens/users/Customer/cstmr_forgot_password_screen.dart';
import 'package:octbs_ui/screens/users/Customer/customer_bottom_navigation_bar.dart';
import 'package:octbs_ui/screens/users/Customer/google/googleclass.dart';
import 'package:octbs_ui/screens/users/Customer/google/logged_in_page.dart';
import 'package:octbs_ui/screens/users/Customer/sign_up/customer_sign_up_screen.dart';

class CustomerSignInScreen extends StatefulWidget {
  const CustomerSignInScreen({Key? key}) : super(key: key);

  @override
  _CustomerSignInScreenState createState() => _CustomerSignInScreenState();
}

class _CustomerSignInScreenState extends State<CustomerSignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String emailVerification = '';
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

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
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                    ))
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) =>
                                      CustomerForgotPasswordScreen()));
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
                            //         builder: (context) => CustomerNavBar()));


                            // Navigator.pushAndRemoveUntil(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (BuildContext context) =>
                            //             BlocProvider(create: (context) => HomeScreenBloc(), child: CustomerNavBar())),
                            // (route) => false);
                            customer_login(emailController.text.toString(), passwordController.text.toString());

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xffff6e01),
                            child: FaIcon(
                              FontAwesomeIcons.facebook,
                              color: Colors.white,
                              // size: screenWidth * 0.08,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          GestureDetector(
                            onTap: () {
                              // signInWithGoogle();
                              // signin_google();


                            },
                            child: CircleAvatar(
                              backgroundColor: Color(0xffff6e01),
                              child: FaIcon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("I don't have an account:",
                        style: TextStyle(
                          color: Colors.grey[600],
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => SignUpScreen()));
                      },
                      child: Text('Create a Cutomer Account',
                          style: TextStyle(
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

  void customer_login(String email ,String password) async{
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
      if(response.statusCode==201){

        // print('Login Successfully');
        var data2=jsonDecode(response.body.toString());
        user_details=data2;
        setState(() {
        });
        // Fluttertoast.showToast(msg: '${data2['message'].toString()}',toastLength: Toast.LENGTH_LONG);
        Get.offAll(CustomerNavBar(),arguments: [user_details]);
        // Fluttertoast.showToast(msg: 'Success');
        print('Success');
      }
      else if(response.statusCode==200){

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

  // Future signin_google() async {
  //
  //   final user = await GoogleSigninApi.login();
  //
  //   if (user == null) {
  //     print('errror');
  //     // Fluttertoast.showToast(
  //     //     msg: "Signin Failed",
  //     //     toastLength: Toast.LENGTH_SHORT,
  //     //     gravity: ToastGravity.CENTER,
  //     //     backgroundColor: Colors.black,
  //     //     textColor: Colors.white,
  //     //     fontSize: 16.0);
  //   } else {
  //     Navigator.of(context)
  //         .push(MaterialPageRoute(builder: (context) => LoggedIN(user: user)));
  //   }
  // }

}
