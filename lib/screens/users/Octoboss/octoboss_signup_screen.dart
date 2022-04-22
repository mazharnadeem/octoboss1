import 'dart:convert';

import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_list_pick/country_list_pick.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:octbs_ui/controller/api/apiservices.dart';
import 'package:octbs_ui/controller/validations.dart';
import 'package:octbs_ui/screens/users/Customer/sign_up/customer_sign_up_screen.dart';

import 'package:octbs_ui/screens/users/Octoboss/octoboss_signin_screen.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OctoBossSignUpScreen extends StatefulWidget {
  const OctoBossSignUpScreen({Key? key}) : super(key: key);

  @override
  _OctoBossSignUpScreenState createState() => _OctoBossSignUpScreenState();
}

class _OctoBossSignUpScreenState extends State<OctoBossSignUpScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController AgeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  // CountryCode countryCode = CountryCode.fromDialCode('+1');
  bool otpSent = false;
  bool checkBoxValue = false;
  String emailVerification = '';
  String? _verificationId;
  String _code = "";
  var country_name = '';
  var country_code = '';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                            'Create your',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: fontSize * 25,
                              // fontWeight: FontWeight.w200,
                            ),
                          ),
                          Text(
                            'account',
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05, right: screenWidth * 0.02),
                      // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        // border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        validator: (firstname) =>
                            firstname_Validation(firstname!),
                        controller: firstnameController,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          border: InputBorder.none,
                          // contentPadding: EdgeInsets.symmetric(
                          //     horizontal: screenWidth * 0.03),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05, right: screenWidth * 0.02),
                      // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        // border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        validator: (lastname) => lastname_Validation(lastname!),
                        controller: lastnameController,
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          border: InputBorder.none,
                          // contentPadding: EdgeInsets.symmetric(
                          //     horizontal: screenWidth * 0.03),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05, right: screenWidth * 0.02),
                      // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        // border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        validator: (email) => email_Validation(email!),
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                          border: InputBorder.none,
                          // contentPadding: EdgeInsets.symmetric(
                          //     horizontal: screenWidth * 0.03),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05, right: screenWidth * 0.02),
                      // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        // border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        validator: (password) => password_Validation(password!),
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none,
                          // contentPadding: EdgeInsets.symmetric(
                          //     horizontal: screenWidth * 0.03),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05, right: screenWidth * 0.02),
                      // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        // border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: CountryListPick(
                            theme: CountryTheme(
                                labelColor: Colors.black,
                                alphabetTextColor: Colors.black,
                                alphabetSelectedTextColor: Colors.black,
                                alphabetSelectedBackgroundColor: Colors.black,
                                isShowFlag: true, //show flag on dropdown
                                isShowTitle: false, //show title on dropdown
                                isShowCode: true, //show code on dropdown
                                isDownIcon: true),
                            onChanged: (c) {
                              setState(() {
                                country_code = c.toString();
                              });
                            },

                            //show down icon on dropdown
                            // initialSelection:
                            //     '+92', //inital selection, +672 for Antarctica
                          ),
                          hintText: 'Phone Number',

                          // border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05, right: screenWidth * 0.02),
                      // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        // border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        focusNode: AlwaysDisabledFocusNode(),
                        controller: AgeController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Date of Birth'),
                        onTap: () => _selectDate(),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05, right: screenWidth * 0.02),
                      // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        // border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: streetAddressController,
                        decoration: InputDecoration(
                          hintText: 'Street Address',
                          border: InputBorder.none,
                          // contentPadding: EdgeInsets.symmetric(
                          //     horizontal: screenWidth * 0.03),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            // padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                right: screenWidth * 0.02),
                            // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              // border: Border.all(color: Colors.grey),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: CountryListPick(
                              theme: CountryTheme(
                                  isShowFlag: true, //show flag on dropdown
                                  isShowTitle: true, //show title on dropdown
                                  isShowCode: false, //show code on dropdown
                                  isDownIcon: true),
                              onChanged: (con) {
                                setState(() {
                                  country_name = con.toString();
                                });
                              },
                              //show down icon on dropdown
                              // initialSelection:
                              //     '+672', //inital selection,countyry +672 for Antarctica
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Container(
                    //   // padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    //   padding: EdgeInsets.only(
                    //       left: screenWidth * 0.05, right: screenWidth * 0.02),
                    //   // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(25),
                    //     // border: Border.all(color: Colors.grey),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.withOpacity(0.5),
                    //         spreadRadius: 2,
                    //         blurRadius: 5,
                    //         offset: Offset(0, 3), // changes position of shadow
                    //       ),
                    //     ],
                    //   ),
                    //   child: TextFormField(
                    //     controller: AgeController,
                    //     decoration: InputDecoration(
                    //       hintText: 'DOB 18+',
                    //       border: InputBorder.none,
                    //       // contentPadding: EdgeInsets.symmetric(
                    //       //     horizontal: screenWidth * 0.03),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: screenHeight * 0.02),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05, right: screenWidth * 0.02),
                      // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        // border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        validator: (postalcode) =>
                            phone_Validation(postalcode!),
                        controller: postalCodeController,
                        decoration: InputDecoration(
                          hintText: 'Postal Code',
                          border: InputBorder.none,
                          // contentPadding: EdgeInsets.symmetric(
                          //     horizontal: screenWidth * 0.03),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          activeColor: Color(0xffff6e01),
                          value: checkBoxValue,
                          onChanged: (bool? value) {
                            setState(() {
                              checkBoxValue = value!;
                            });
                          },
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Agree with',
                          style: TextStyle(
                            fontSize: fontSize * 15,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Terms & Condition',
                            style: TextStyle(
                              color: Color(0xffff6e01),
                              fontSize: fontSize * 15,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              //
              Center(
                child: Container(
                  // alignment: Alignment.center,
                  width: screenWidth * 0.5,
                  child: ElevatedButton(
                    onPressed: () async {
                      var phonewithcountry = '$country_code' +
                          '${phoneController.text.toString()}';
                      ApiServices()
                          .octoboss_register(
                              firstnameController.text.toString(),
                              lastnameController.text.toString(),
                              emailController.text.toString(),
                              passwordController.text.toString(),
                              phonewithcountry,
                              AgeController.text.toString(),
                              streetAddressController.text.toString(),
                              countryController.text.toString(),
                              postalCodeController.text.toString(),
                              "octoboss",
                              AgeController.text.toString())
                          .then((value) {
                        if (value) {
                          showBottomSheet(context);
                        }
                      });
                    },
                    child: Text(
                      'Create',
                      style: TextStyle(
                        fontSize: fontSize * 17,
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
                                    side: BorderSide(color: Colors.red)))),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have account?',
                    style: TextStyle(
                      fontSize: fontSize * 20,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => OctoBossSigninScreen()));
                    },
                    child: Text(
                      'sign In',
                      style: TextStyle(
                        color: Color(0xffff6e01),
                        fontSize: fontSize * 20,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Get.height * 0.08),
        ),
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: EdgeInsets.all(Get.height * 0.02),
                height: Get.height * 0.55,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Get.height * 0.08),
                  color: Color(0xffff6e01),
                ),
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.01),
                    SizedBox(
                      height: Get.height * 0.25,
                      child: Image.asset('assets/images/otp_popup.png'),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Enter_OTP'.tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Get.height * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Text(
                            'OTP Code  is sent to your Mobile Number via SMS.'
                                .tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Get.height * 0.014,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: Get.height * 0.003,
                          ),
                          Text(
                            'Please Enter the sent code below.'.tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Get.height * 0.014,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 25),
                      child: PinFieldAutoFill(
                        // autoFocus: true,
                        //   cursor: Cursor(
                        //   width: 2,
                        //   height: 35,
                        //   color: Colors.white,
                        //   radius: Radius.circular(1),
                        //   enabled: true,
                        // ),
                        decoration: const UnderlineDecoration(
                            textStyle: TextStyle(color: Colors.white),
                            colorBuilder: FixedColorBuilder(Colors.white)),
                        currentCode: _code,
                        controller: pinCodeController,
                        onCodeChanged: (value) async {
                          if (value!.length == 6) {
                            ApiServices().verifyCode(user_id.value,
                                pinCodeController.text.toString());
                            //  Customdialog.showDialog();
                            //  await verifySignupOtp(
                            //    context,
                            //    pinCodeController.text,
                            //    _verificationId!,
                            //  );
                          }
                        },
                        codeLength: 6,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(height: Get.height * 0.02),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  DateTime dateTime = DateTime.now();

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      AgeController.text = DateFormat.yMd().format(dateTime);
    }
  }
}
