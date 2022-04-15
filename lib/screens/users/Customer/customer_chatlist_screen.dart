import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:octbs_ui/controller/api/userDetails.dart';
import 'package:octbs_ui/screens/users/Customer/chat_list.dart';

class CustomerChatListScreen extends StatefulWidget {
  const CustomerChatListScreen({Key? key}) : super(key: key);

  @override
  _CustomerChatListScreenState createState() => _CustomerChatListScreenState();
}

class _CustomerChatListScreenState extends State<CustomerChatListScreen> {
  // User? user = FirebaseAuth.instance.currentUser;
  String? chatID;
  var messageController=TextEditingController();
  var messages=[];
  var unOrder=[];
  var sort_messages=[];

  // var receiver_Id=Get.arguments[0];

  sendMessage(String senderId ,String receiverId ,String message) async{
     try{
      var data={'sender_id':senderId,'receiver_id':receiverId,'message':message};

      var data1=json.encode(data);
      var response=await post(Uri.parse('https://admin.octo-boss.com/API/SendMessage.php'),
          body: data1
      );
      if(response.statusCode==201){
        print('Message Send Successfully : 201');
        var data2=jsonDecode(response.body.toString());
        // Fluttertoast.showToast(msg: '${data2['message'].toString()}');
        print(data);
        return true;
      }
      else if(response.statusCode==200){
        print('Register code : 200');
        var data2=jsonDecode(response.body.toString());
        // Fluttertoast.showToast(msg: '${data2['message'].toString()}');
        print(data);
        return false;
      }
      else{
        print('Message Send Failed  : else');
        var data2=jsonDecode(response.body.toString());
        // Fluttertoast.showToast(msg: '${data2['message'].toString()}');

        print(data);
        return false;
      }

    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }

  }

  messageList(String receiverId) async{
    try{
      var data={'receiver_id':receiverId};

      var data1=json.encode(data);
      var response=await post(Uri.parse('https://admin.octo-boss.com/API/ChatList.php'),
          body: data1
      );
      if(response.statusCode==201){
        sort_messages.clear();

        print('Message List Successfully : 201');
        var data2=jsonDecode(response.body.toString());
        unOrder=data2['data'];
        var chhh=unOrder;
        // print('Mazhar Nadeem : ${chhh[0]['receiver_id']}');
        // var len=chhh.length.toInt();
        // if(unOrder)
        var len=unOrder.length;
        // print('check length ${chhh.length}');
        for(int m=0;chhh.length>m;m++){
          if(m<chhh.length){
            if(chhh[m]['receiver_id']==receiver_Id.toString() && chhh[m]['sender_id']==user_details['data']['id']){
              print('Mazhar Nadeem : ${chhh[m]['receiver_id']}\n');
              sort_messages.add(chhh[m]);
            }


          }
        }

        messages=sort_messages.reversed.toList();
        setState(() {

        });

        // Fluttertoast.showToast(msg: '${data2['message'].toString()}');

        print(data);
        return true;
      }
      else if(response.statusCode==200){
        print('Register code : 200');
        var data2=jsonDecode(response.body.toString());
        // Fluttertoast.showToast(msg: '${data2['message'].toString()}');
        print(data);
        return false;
      }
      else{
        print('Message Send Failed  : else');
        var data2=jsonDecode(response.body.toString());
        // Fluttertoast.showToast(msg: '${data2['message'].toString()}');

        print(data);
        return false;
      }

    }catch(e){
      // Fluttertoast.showToast(msg: e.toString());
      return false;
    }

  }

  mess(){
    messageList(user_details['data']['id']);
    // messages;
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
                        Get.to(Applicants());
                      },
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
                        'Messages'.tr,
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
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/home_logo_new.jpg',
                    ),
                    radius: 30,
                    backgroundColor: Colors.white,
                  ),
                  Text('Aamil'),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Colors.orange,
                    onPressed: () {
                      _showMyDialogTraining();
                    },
                    child: Text(
                      'MAKE AN OFFER',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 13,
              child:StreamBuilder(
                stream: mess(),
                builder: (BuildContext context,AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var x=messages[index]['receiver_id'];
                      var y=user_details['data']['id'];

                      return x==y?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/home_logo_new.jpg',
                            ),
                            radius: 30,
                            backgroundColor: Colors.white,
                          ),


                          SizedBox(width: 10),
                          Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(messages[index]['message']),

                                    ],
                                  ),
                                ),
                              )),

                          // Column(children: [],),
                        ],
                      ): Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(messages[index]['message']),

                                    ],
                                  ),
                                ),
                              )),

                          SizedBox(width: 10),
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/home_logo_new.jpg',
                            ),
                            radius: 30,
                            backgroundColor: Colors.white,
                          ),
                          // Column(children: [],),
                        ],
                      );

                    },);
                },
              )
              // child: FutureBuilder(
              //   future: messageList('16'),
              //   builder: (context, snapshot) {
              //   return ;
              // },),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22)),
                                  elevation: 5,
                                  child: Container(
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                              child: Icon(Icons.emoji_emotions)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          // Text('Write a ...'),
                                          Expanded(
                                              flex: 10,
                                              child: Container(
                                                child: TextFormField(
                                                  controller: messageController,
                                                  decoration: InputDecoration(
                                                    hintText: 'Write Something...',
                                                    border: InputBorder.none
                                                  ),
                                                ),
                                              )),
                                          Spacer(),
                                          Expanded(
                                            flex: 2,
                                            child: IconButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder: ((builder) =>
                                                        Bottomsheet()),
                                                  );
                                                },
                                                icon: Icon(
                                                    Icons.attach_file_sharp)),
                                          ),
                                          SizedBox(
                                            width: 0,
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Icon(Icons.camera_enhance)),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22)),
                                elevation: 5,
                                child: IconButton(
                                    onPressed: () {
                                      sendMessage(user_details['data']['id'],receiver_Id.toString(), messageController.text.toString());
                                      // sendMessage('16', '73', messageController.text);
                                      messageController.clear();
                                    }, icon: Icon(Icons.send_rounded)),
                              )
                            ],
                          ),
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialogTraining() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.cancel,
                              size: 35,
                              color: Colors.red,
                            ))
                      ],
                    ),
                    Text('TIME'),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '03:30 PM',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('DATE'),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '12/21/2021',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('PRICE'), Text('DURATION')],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: '10\$',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: '3 hrs',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          color: Colors.orange,
                          onPressed: () {
                            Navigator.of(context).pop();
                            // _showMyDialo
                            // gTraining();
                          },
                          child: Text(
                            'Send offer',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          // actions: <Widget>[
          //   TextButton(
          //     child: const Text('Done'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }

  Widget Bottomsheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            "Chose profile photo or video",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                  onPressed: () {
                    //  takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.video_collection),
                  label: Text("Video ")),
              FlatButton.icon(
                  onPressed: () {
                    // takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text("Gallery ")),
            ],
          ),
        ],
      ),
    );
  }
}
