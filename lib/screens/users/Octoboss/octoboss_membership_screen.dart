import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:octbs_ui/screens/users/Octoboss/payments/Golden_plan.dart';
import 'package:octbs_ui/screens/users/Octoboss/payments/Silver_plan.dart';
import 'package:octbs_ui/screens/users/Octoboss/payments/plantinum_plan.dart';

class OctoBossMembershipScreen extends StatefulWidget {
  const OctoBossMembershipScreen({Key? key}) : super(key: key);

  @override
  _OctoBossMembershipScreenState createState() =>
      _OctoBossMembershipScreenState();
}

class _OctoBossMembershipScreenState extends State<OctoBossMembershipScreen> {
  Future<membershipModel> getMembership() async {
    final response = await http
        .get(Uri.parse('https://admin.octo-boss.com/API/MemberShipPlans.php'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 201) {
      // store_services = data['data'];

      print('Membership Value is:  $data');
      return membershipModel.fromJson(data);
    } else {
      return membershipModel.fromJson(data);
    }
  }
  // User? user = FirebaseAuth.instance.currentUser;

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
                      'membership'.tr,
                      style: TextStyle(
                        fontSize: fontSize * 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.3),
                    Text(
                      'Active',
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
                        'Date',
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
                    Text(
                      '1 Month - Free Trial',
                      style: TextStyle(
                        fontSize: fontSize * 20,
                      ),
                    ),
                    Card(
                      child: Container(
                        alignment: Alignment.center,
                        height: screenHeight * 0.1,
                        child: Text(
                          'Your currently using free trial will end today, and will be disabled features of application',
                          style: TextStyle(
                            fontSize: fontSize * 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),

                FutureBuilder<membershipModel>(
                    future: getMembership(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return ListView.builder(
                            shrinkWrap: true,
                            // scrollDirection: ax,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(CartPage());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, bottom: 12),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Text(
                                            snapshot.data!.data![index].price
                                                    .toString() +
                                                "/Month",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 35,
                                          ),
                                          Text(
                                            snapshot
                                                .data!.data![index].description
                                                .toString(),
                                          ),
                                          SizedBox(
                                            height: 35,
                                          ),
                                          Text(
                                            snapshot.data!.data![index]
                                                .membershipName
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Text(
                                            "Duration: " +
                                                snapshot
                                                    .data!.data![index].duration
                                                    .toString(),
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),

                // Column(
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         Get.to(
                //           CartPage(),
                //         );
                //       },
                //       child: Card(
                //         elevation: 5,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(22)),
                //         child: Padding(
                //           padding: const EdgeInsets.all(12),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               SizedBox(
                //                 height: 25,
                //               ),
                //               Text(
                //                 '24.99CAD/Month',
                //                 style: TextStyle(
                //                     fontSize: 18, fontWeight: FontWeight.bold),
                //               ),
                //               SizedBox(
                //                 height: 35,
                //               ),
                //               Text(
                //                   'The Silver Plan: month to month plan no automatic renewal- PRICE: 24.99CAD /month + TAX'),
                //               SizedBox(
                //                 height: 35,
                //               ),
                //               Text(
                //                 'Silver Plan',
                //                 style: TextStyle(
                //                     fontSize: 18, fontWeight: FontWeight.bold),
                //               ),
                //               SizedBox(
                //                 height: 25,
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 20,
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         Get.to(
                //           Golden_Plan(),
                //         );
                //       },
                //       child: Card(
                //         elevation: 5,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(22)),
                //         child: Padding(
                //           padding: const EdgeInsets.all(12),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               SizedBox(
                //                 height: 25,
                //               ),
                //               Text(
                //                 '15.99CAD /Month',
                //                 style: TextStyle(
                //                     fontSize: 18, fontWeight: FontWeight.bold),
                //               ),
                //               SizedBox(
                //                 height: 35,
                //               ),
                //               Text(
                //                   'The Golden Plan: 6 months plan- automatic renewal can be cancelled anytime payment'
                //                   'to be withdrawn monthly beginning of every month, PRICE: 15.99CAD /month + TAX -'
                //                   'pay full amount upfront get 10% off'),
                //               SizedBox(
                //                 height: 35,
                //               ),
                //               Text(
                //                 ' Golden Plan',
                //                 style: TextStyle(
                //                     fontSize: 18, fontWeight: FontWeight.bold),
                //               ),
                //               SizedBox(
                //                 height: 25,
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 20,
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         Get.to(
                //           Plantinum(),
                //         );
                //       },
                //       child: Card(
                //         elevation: 5,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(22)),
                //         child: Padding(
                //           padding: const EdgeInsets.all(12),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               SizedBox(
                //                 height: 25,
                //               ),
                //               Text(
                //                 '12.99CAD/Month',
                //                 style: TextStyle(
                //                     fontSize: 18, fontWeight: FontWeight.bold),
                //               ),
                //               SizedBox(
                //                 height: 35,
                //               ),
                //               Text(
                //                   'The Platinum Plan: 12 months - automatic renewal, can be cancelled anytime, payment'
                //                   'to be withdrawn monthly beginning of every month, PRICE: 12.99CAD /month + TAX- pay'
                //                   'full amount get 10% off and one month free.'),
                //               SizedBox(
                //                 height: 35,
                //               ),
                //               Text(
                //                 'Platinum Plan',
                //                 style: TextStyle(
                //                     fontSize: 18, fontWeight: FontWeight.bold),
                //               ),
                //               SizedBox(
                //                 height: 25,
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // )
              ],
            )),
      ),
    );
  }

  ChoosePlan(String phoneNumber, name, amount, time, plan, email) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final fontSize = MediaQuery.of(context).textScaleFactor;
    return Card(
      child: Container(
        height: screenHeight * 0.2,
        width: screenWidth * 0.4,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            plan,
            style: TextStyle(
              fontSize: fontSize * 13,
              color: Color(0xffFF5A01),
            ),
          ),
          Divider(),
          SizedBox(height: 4),
          Text(
            '${amount}CAD /Month',
            style: TextStyle(
              fontSize: fontSize * 13,
              color: Color(0xffFF5A01),
            ),
          ),
          SizedBox(height: 4),
          Text(
            time,
            style: TextStyle(
              fontSize: fontSize * 13,
              color: Color(0xffFF5A01),
            ),
          ),
          SizedBox(height: 14),
          InkWell(
            onTap: () {
              Get.to(PayNowScreen(
                description: plan,
                email: email,
                amount: amount,
                name: name,
                phone: phoneNumber,
              ));
            },
            child: Container(
              // alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              padding: EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffFF5A01),
              ),
              child: Center(
                child: Text(
                  'Proceed',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize * 10,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class PayNowScreen extends StatefulWidget {
  const PayNowScreen({
    required this.description,
    required this.email,
    required this.amount,
    required this.name,
    required this.phone,
    Key? key,
  }) : super(key: key);

  final String name, email, phone, description, amount;

  @override
  _PayNowScreenState createState() => _PayNowScreenState();
}

class _PayNowScreenState extends State<PayNowScreen> {
  // Razorpay? razorpay;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // razorpay = new Razorpay();

    // razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    // razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    // razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);

    openCheckout();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    // razorpay!.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_RjTwt97hkzezfb",
      "amount": num.parse(widget.amount) * 100,
      "name": widget.name,
      "description": widget.description,
      "prefill": {"contact": widget.phone, "email": widget.email},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      // razorpay!.open(options);
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  void handlerPaymentSuccess() {
    // Fluttertoast.showToast(msg: 'Transfer Successful');
  }

  void handlerErrorFailure() {
    // Fluttertoast.showToast(msg: 'Something went wrong');
  }

  void handlerExternalWallet() {
    // Fluttertoast.showToast(msg: 'External Wallet');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Color(0xffFF5A01)),
          onPressed: () {
            Get.back();
          },
          child: Text('Back'),
        ),
      ),
    );
  }
}

class membershipModel {
  int? response;
  int? code;
  List<Data>? data;

  membershipModel({this.response, this.code, this.data});

  membershipModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? membershipName;
  String? price;
  String? description;
  String? status;
  String? duration;

  Data(
      {this.id,
      this.membershipName,
      this.price,
      this.description,
      this.status,
      this.duration});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    membershipName = json['membership_name'];
    price = json['price'];
    description = json['description'];
    status = json['status'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['membership_name'] = this.membershipName;
    data['price'] = this.price;
    data['description'] = this.description;
    data['status'] = this.status;
    data['duration'] = this.duration;
    return data;
  }
}
