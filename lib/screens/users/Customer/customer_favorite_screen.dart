import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:octbs_ui/Model/filteroctoboss.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' ;
import 'package:octbs_ui/controller/api/userDetails.dart';

class CustomerFavoriteScreen extends StatefulWidget {


  @override
  State<CustomerFavoriteScreen> createState() => _CustomerFavoriteScreenState();
}

var favorite_data=[];
class _CustomerFavoriteScreenState extends State<CustomerFavoriteScreen> {
  Future<Filteroctoboss> getProducts() async{
    final response=await http.get(Uri.parse('https://admin.octo-boss.com/API/FilterOctoboss.php'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==201){
      favorite_data.clear();
      var len=data['data'].length;

        for(int i=0;len>i;i++) {
          // if(data['data'][i]['id'])

              var val=fav_list.contains(data['data'][i]['id']);
              if(val){
                print('object');
                favorite_data.add(data['data'][i]);
              }

          }
        // print(data2);

      return Filteroctoboss.fromJson(data);
    }
    else{
      return Filteroctoboss.fromJson(data);
    }
  }

  var fav_list=[];

  steamget(){
    getProducts();
  }

favorite_list() async{

  var data={'user_id':user_details['data']['id']};

  var data1=json.encode(data);
  var response=await post(Uri.parse('https://admin.octo-boss.com/API/FavouriteOctobossList.php'),
      body: data1
  );
  if(response.statusCode==201){

    fav_list.clear();

    var data2=jsonDecode(response.body.toString());
    var fav=data2['data'];
    var len=fav.length;
    for(int i=0;i<len;i++){
      fav_list.add(fav[i]['octoboss_id']);
    }
    print('List $fav_list');
  }
  else{

    var data2=jsonDecode(response.body.toString());

  }

}


  makeFavorite(String id) async {
    var favorite_data = {
      'user_id': user_details['data']['id'],
      'octoboss_id': id,
    };
    var encoded_data = json.encode(favorite_data);
    final response = await post(Uri.parse('https://admin.octo-boss.com/API/FavouriteOctoboss.php'),
        body: encoded_data);

    if (response.statusCode == 201) {
      var favorite_res = jsonDecode(response.body.toString());
      // Fluttertoast.showToast(msg: '${favorite_res['message'].toString()}');
      print(favorite_res);
    } else {
      var issue_response = jsonDecode(response.body.toString());
      print(issue_response);
    }
  }

@override
  void initState() {
  favorite_list();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            children: [
              Row(
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
                  Spacer(),
                  Center(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: Text(
                        'Favorite'.tr,
                        style: TextStyle(
                          // color: Colors.red,
                          fontSize: fontSize * 20,
                          // fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 10),

              Expanded(

                child: FutureBuilder<Filteroctoboss>(
                  future: getProducts(),
                  builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: favorite_data.length,
                    itemBuilder: (context, index) {
                      return Card(

                        elevation: 5,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.blue,
                                      backgroundImage: NetworkImage(
                                          favorite_data[index]['image'].toString()
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(favorite_data[index]['name'].toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            )),
                                      ],
                                    ),
                                    Text(favorite_data[index]['service'].toString(), style: TextStyle()),
                                    Text(favorite_data[index]['experience'].toString(),
                                        style: TextStyle()),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.thumb_up,
                                          color: Colors.orange.shade800,
                                        ),
                                        Text('98%', style: TextStyle(fontSize: 15)),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          Icons.message,
                                          color: Colors.orange.shade800,
                                        ),
                                        Text('110', style: TextStyle(fontSize: 15)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('5km', style: TextStyle(fontSize: 15)),
                                        SizedBox(
                                          width: 100,
                                        ),
                                        Text('5:35 Pm', style: TextStyle(fontSize: 15)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 25,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(22),
                                              border: Border.all(color: Colors.orange)),
                                          child: Text('Location'),
                                        ),
                                        SizedBox(
                                          width: 60,
                                        ),
                                        Icon(
                                          Icons.message,
                                          color: Colors.orange.shade800,
                                        ),
                                        Text('Chats', style: TextStyle(fontSize: 15)),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        // favorite_list();
                                        makeFavorite(favorite_data[index]['id']);
                                        setState(() {
                                        });
                                      },
                                      child: Container(
                                        // decoration: BoxDecoration(
                                        //     borderRadius: BorderRadius.circular(22),
                                        //     border: Border.all(color: Colors.grey)),
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.orange.shade800,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 80,
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );

                  }
                    );
                },),
              ),
              // Expanded(
              //   child: StreamBuilder(
              //     stream: steamget(),
              //     builder: (context, snapshot) {
              //       return ListView.builder(
              //           itemCount: favorite_data.length,
              //           itemBuilder: (context, index) {
              //             return Card(
              //
              //               elevation: 5,
              //               child: Column(
              //                 children: [
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                     children: [
              //                       Column(
              //                         children: [
              //                           CircleAvatar(
              //                             radius: 50,
              //                             backgroundColor: Colors.blue,
              //                             backgroundImage: NetworkImage(
              //                                 favorite_data[index]['image'].toString()
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                       Column(
              //                         crossAxisAlignment: CrossAxisAlignment.start,
              //                         children: [
              //                           Row(
              //                             children: [
              //                               Text(favorite_data[index]['name'].toString(),
              //                                   style: TextStyle(
              //                                     fontSize: 18,
              //                                     color: Colors.black,
              //                                   )),
              //                             ],
              //                           ),
              //                           Text(favorite_data[index]['service'].toString(), style: TextStyle()),
              //                           Text(favorite_data[index]['experience'].toString(),
              //                               style: TextStyle()),
              //                           Row(
              //                             children: [
              //                               Icon(
              //                                 Icons.thumb_up,
              //                                 color: Colors.orange.shade800,
              //                               ),
              //                               Text('98%', style: TextStyle(fontSize: 15)),
              //                               SizedBox(
              //                                 width: 20,
              //                               ),
              //                               Icon(
              //                                 Icons.message,
              //                                 color: Colors.orange.shade800,
              //                               ),
              //                               Text('110', style: TextStyle(fontSize: 15)),
              //                             ],
              //                           ),
              //                           Row(
              //                             children: [
              //                               Text('5km', style: TextStyle(fontSize: 15)),
              //                               SizedBox(
              //                                 width: 100,
              //                               ),
              //                               Text('5:35 Pm', style: TextStyle(fontSize: 15)),
              //                             ],
              //                           ),
              //                           Row(
              //                             children: [
              //                               Container(
              //                                 alignment: Alignment.center,
              //                                 height: 25,
              //                                 width: 70,
              //                                 decoration: BoxDecoration(
              //                                     borderRadius: BorderRadius.circular(22),
              //                                     border: Border.all(color: Colors.orange)),
              //                                 child: Text('Location'),
              //                               ),
              //                               SizedBox(
              //                                 width: 60,
              //                               ),
              //                               Icon(
              //                                 Icons.message,
              //                                 color: Colors.orange.shade800,
              //                               ),
              //                               Text('Chats', style: TextStyle(fontSize: 15)),
              //                             ],
              //                           )
              //                         ],
              //                       ),
              //                       Column(
              //                         children: [
              //                           InkWell(
              //                             onTap:(){
              //                               // favorite_list();
              //                               makeFavorite(favorite_data[index]['id']);
              //                               setState(() {
              //
              //                               });
              //                             },
              //                             child: Container(
              //                               // decoration: BoxDecoration(
              //                               //     borderRadius: BorderRadius.circular(22),
              //                               //     border: Border.all(color: Colors.grey)),
              //                               child: Icon(
              //                                 Icons.favorite,
              //                                 color: Colors.orange.shade800,
              //                                 size: 30,
              //                               ),
              //                             ),
              //                           ),
              //                           SizedBox(
              //                             height: 80,
              //                           )
              //                         ],
              //                       )
              //                     ],
              //                   ),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                 ],
              //               ),
              //             );
              //
              //           }
              //       );
              //   },),
              // )


              // Expanded(
              //   child: StreamBuilder<QuerySnapshot>(
              //       stream: FirebaseFirestore.instance
              //           .collection('users')
              //           .where('isFavourite', isEqualTo: true)
              //           .snapshots(),
              //       builder: (context, snapshot) {
              //         if (snapshot.hasError) {
              //           return Text('Something went wrong ${snapshot.error}');
              //         }
              //         switch (snapshot.connectionState) {
              //           case ConnectionState.waiting:
              //             return Center(
              //               child: CircularProgressIndicator(
              //                 valueColor: AlwaysStoppedAnimation<Color>(
              //                     Color(0xffff6e01)),
              //               ),
              //             );
              //           default:
              //             return ListView(
              //               children: snapshot.data!.docs
              //                   .asMap()
              //                   .map((index, value) => MapEntry(
              //                         index,
              //                         GestureDetector(
              //                           onTap: () {
              //                             Get.to(OctoBossPublicProfile(
              //                               UID: value['UID'],
              //                               isFav: value['isFavourite'],
              //                             ));
              //                           },
              //                           child: Card(
              //                             child: ListTile(
              //                                 leading: CircleAvatar(
              //                                   backgroundImage: NetworkImage(
              //                                       value['image']),
              //                                   radius: 30,
              //                                   backgroundColor: Colors.white,
              //                                 ),
              //                                 title: Text(value['Name']),
              //                                 subtitle: Column(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     Text(
              //                                         'Home Repair from ${value['Country']}'),
              //                                   ],
              //                                 )),
              //                           ),
              //                         ),
              //                       ))
              //                   .values
              //                   .toList(),
              //             );
              //         }
              //       }),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
