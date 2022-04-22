import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:octbs_ui/controller/ServicesResponse.dart';
import 'package:octbs_ui/screens/users/Customer/services_octoboss.dart';
import 'package:octbs_ui/screens/users/Octoboss/octoboss_services_offered_screen_api.dart';

class banner {
  int? response;
  int? code;
  List<Data>? data;

  banner({this.response, this.code, this.data});

  banner.fromJson(Map<String, dynamic> json) {
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
  String? image;
  String? title;
  String? description;
  String? path;
  String? meta;

  Data(
      {this.id,
      this.image,
      this.title,
      this.description,
      this.path,
      this.meta});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
    path = json['path'];
    meta = json['meta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['description'] = this.description;
    data['path'] = this.path;
    data['meta'] = this.meta;
    return data;
  }
}

class CustomerHomeScreen extends StatefulWidget {
  CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  Future<banner> getPostApi() async {
    final response = await http
        .get(Uri.parse("https://admin.octo-boss.com/API/Banners.php"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 201) {
      return banner.fromJson(data);
    } else {
      return banner.fromJson(data);
    }
  }

  Future<ServicesResponse> getPostServiceApi() async {
    final response = await http
        .get(Uri.parse("https://admin.octo-boss.com/API/Services.php"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 201) {
      return ServicesResponse.fromJson(data);
    } else {
      return ServicesResponse.fromJson(data);
    }
  }

  String? announcment;
  int count = 0;
  Future<ServicesResponse>? serviceApi;
  Future<banner>? futurebanner;
  @override
  void initState() {
    super.initState();
    settingsApi();
    futurebanner = getPostApi();
  }

  Future settingsApi() async {
    // final response = await WebServices.instance().termsAndCondition();
    setState(() {
      // announcment = response.data!.userNotification;
    });
    if (announcment != null && count == 0) {
      count++;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Announcement',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      announcment!,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'close',
                          style: TextStyle(
                            color: Color(0xffff6e01),
                          ),
                        ))
                  ],
                ),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    // User? user = FirebaseAuth.instance.currentUser;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Image.asset('assets/images/home_logo_new.jpg'),
          ),
          Expanded(
              // flex: 1,
              child: FutureBuilder<banner>(
                  future: futurebanner,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data != null) {
                      return ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.data!.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data.data[index].image!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: MediaQuery.of(context).size.width,
                                height: screenHeight * 0.27,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Image.network(
                                      "http://via.placeholder.com/350x150"),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })),
          Expanded(
              child: FutureBuilder<ServicesResponse>(
                  future: getPostServiceApi(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data != null) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 2.0,
                          mainAxisSpacing: 2.0,
                        ),
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 30, right: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Card(
                                        child: Container(
                                          height: 65,
                                          width: 65,
                                          decoration: BoxDecoration(),
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(ServicesOctoboss(),arguments: [snapshot.data!.data![index].productName]);
                                                },
                                                child: CachedNetworkImage(
                                                  imageUrl: snapshot.data!
                                                      .data![index].productImage
                                                      .toString(),
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(
                                                    height: 60,
                                                    width: 70,
                                                    child: Image.network(
                                                        "http://via.placeholder.com/350x150"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        child: Row(
                                          children: [
                                            Text(snapshot
                                                .data!.data![index].productName
                                                .toString()),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }))
        ]),
      ),
    );
  }
}
