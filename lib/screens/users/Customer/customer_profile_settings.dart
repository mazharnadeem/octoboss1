import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:octbs_ui/controller/api/userDetails.dart';
import 'package:octbs_ui/screens/users/Customer/customer_profile_screen.dart';
import 'package:octbs_ui/screens/users/Customer/customer_signin_screen.dart';
import 'package:octbs_ui/screens/users/Octoboss/settings_screen.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'customer_issues_list_screen.dart';
import 'package:http/http.dart' as http;

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            'Settings'.tr,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ListTile(
            title: Text('Profile'.tr),
            leading: Icon(Icons.person),
            onTap: () {
              pushNewScreen(
                context,
                screen: CustomerProfileScreen(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
          ExpansionTile(
            title: Text('Language'.tr),
            leading: Icon(Icons.language),
            children: <Widget>[
              ListTile(
                title: Text('English'),
                leading: Icon(Icons.translate),
                onTap: () {
                  var locale = const Locale('en', 'US');
                  Get.updateLocale(locale);
                },
              ),
              ListTile(
                title: Text('French'),
                leading: Icon(Icons.translate),
                onTap: () {
                  var locale = const Locale('es', 'FR');
                  Get.updateLocale(locale);
                },
              ),
              ListTile(
                title: Text('Arabic'),
                leading: Icon(Icons.translate),
                onTap: () {
                  var locale = const Locale('en', 'AR');
                  Get.updateLocale(locale);
                },
              ),
            ],
          ),
          ListTile(
            title: Text('Terms And Condition'.tr),
            leading: Icon(Icons.policy),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerTermAndConditions()));
            },
          ),
          ListTile(
            title: Text('About us'.tr),
            leading: Icon(Icons.info),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerTermAndConditions()));
            },
          ),
          ListTile(
            title: Text('Logout'.tr),
            leading: Icon(Icons.logout),
            onTap: () {
              Fluttertoast.showToast(msg: user_details['data']['full_name'].toString());

            },
          ),
          // FutureBuilder(
          //   future: ,
          //   builder: (context, snapshot) {
          //
          // },)

        ],
      ),
    );
  }
}

class CustomerTermAndConditions extends StatefulWidget {
  const CustomerTermAndConditions({Key? key}) : super(key: key);

  @override
  State<CustomerTermAndConditions> createState() =>
      _CustomerTermAndConditionsState();
}

class _CustomerTermAndConditionsState extends State<CustomerTermAndConditions> {
  Future<SettingsModel> getPostApi() async {
    final response = await http
        .get(Uri.parse("https://admin.noqta-market.com/new/API/Settings.php"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 201) {
      return SettingsModel.fromJson(data);
    } else {
      return SettingsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SafeArea(
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
            ],
          ),
          Expanded(
            child: FutureBuilder<SettingsModel>(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 8),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snapshot.data!.data!.aboutUser.toString(),
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ));
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      )),
    );
  }
}
