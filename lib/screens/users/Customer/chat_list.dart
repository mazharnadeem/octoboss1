import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:octbs_ui/Model/octobossmodel.dart';
import 'package:octbs_ui/controller/api/userDetails.dart';
import 'package:octbs_ui/screens/users/Customer/customer_chatlist_screen.dart';
import 'package:http/http.dart' as http;

class Applicants extends StatefulWidget {
  const Applicants({ Key? key }) : super(key: key);

  @override
  _ApplicantsState createState() => _ApplicantsState();
}

class _ApplicantsState extends State<Applicants> {
  var users_octoboss=[];

  Future<void> get_all_Octoboss() async{
    final response = await http.get(Uri.parse("https://admin.octo-boss.com/API/Octoboss.php"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 201) {
      users_octoboss=data['data']['all_octoboss'];
      // print('All Octoboos : $users_octoboss  and Length : ${users_octoboss.length} ' );
      // return Octobossmodel.fromJson(data);
    }
    else {
      // return Octobossmodel.fromJson(data);
    }

  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
                       SizedBox(height: 40,),
                       Container(
                         child: Row(
                           children: [
                             Container(height: 35,width: 35,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(80), color: Colors.deepOrange),
                                child: Row(
                                  children: [
                                    SizedBox(width: 4,),
                                      Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 23,),

                                  ],
                                ),
                             ),
                           ],
                         ),
                       ),
                    SizedBox(height: 15,),

                    SizedBox(
                   height: 60,
                   child: Card(
                     elevation: 5,
                      semanticContainer: true,
                     clipBehavior: Clip.antiAliasWithSaveLayer,

                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         // mainAxisSize: MainAxisSize.max,
                         children: [

                        Expanded(
                          flex: 2,
                            child: Icon(Icons.search)),
                         Expanded(
                             flex: 30,
                             child: Align(
                                 alignment: Alignment.center,
                                 child: Text("Messages", style: TextStyle(color: Colors.black),))),

                       ],),
                     ),
                   ),
                 ),
                    SizedBox(height: 15,),
                    FutureBuilder(
                      future: get_all_Octoboss(),
                      builder: (context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                      }
                      else{
                        try{
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: users_octoboss.length,
                          itemBuilder: (context, index) {

                            return  Card(
                              child:  ListTile(
                                onTap: () {
                                  receiver_Id=int.parse(users_octoboss[index]['id']);
                                  Get.to(CustomerChatListScreen());
                                },
                                  leading:  CircleAvatar(
                                    radius: 28.0,
                                    backgroundImage:
                                    NetworkImage('https://admin.octo-boss.com/images/avatar/3.jpg'),
                                    //  backgroundColor: Colors.indigo,
                                  ),
                                  title: Text(users_octoboss[index]['full_name'], style: TextStyle(color: Colors.deepOrange),),
                                  subtitle:  Text("Here is some dummy Text", style: TextStyle(color: Colors.grey),),
                                  trailing: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(80), color: Colors.deepOrange),
                                    child: Center(
                                      child: Icon(Icons.check, color: Colors.white, size: 23,),
                                    ),
                                  )
                              ),
                            );
                          },);

                        }catch(e){
                          print('softsnip : $e');
                          return Text('$e');

                          // return Fluttertoast.showToast(msg: e.toString());
                        }
                      }



                    },),


                  //
                  // ListView.builder(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   itemCount: 3,
                  //   itemBuilder: (context, index) {
                  //     return Card(
                  //       child:  ListTile(
                  //         onTap: () => Get.to(CustomerChatListScreen()),
                  //           leading:  CircleAvatar(
                  //             radius: 28.0,
                  //             backgroundImage:
                  //             NetworkImage('https://admin.octo-boss.com/images/avatar/3.jpg'),
                  //             //  backgroundColor: Colors.indigo,
                  //           ),
                  //           title: Text("Aamil", style: TextStyle(color: Colors.deepOrange),),
                  //           subtitle:  Text("Here is some dummy Text", style: TextStyle(color: Colors.grey),),
                  //           trailing: Container(
                  //             height: 30,
                  //             width: 30,
                  //
                  //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(80), color: Colors.deepOrange),
                  //             child: Center(
                  //               child: Icon(Icons.check, color: Colors.white, size: 23,),
                  //             ),
                  //           )
                  //       ),
                  //     );
                  //   },)



          ],),
        ),
      ),
    );
      
    
  }
}