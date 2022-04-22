import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:octbs_ui/controller/api/userDetails.dart';
import 'package:octbs_ui/screens/users/Customer/chat_list.dart';
import 'package:octbs_ui/screens/users/Customer/emoji.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

import 'customer_issue_list_screen_api.dart';


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
  File? imageLink;
  // var record;
  bool visibility_attach=true;
  bool visibility_timer=false;


  //Audio player
  final audioPlayer=AudioPlayer();
  bool isPlaying=false;
  Duration duration=Duration.zero;
  Duration position=Duration.zero;
  String? status;
  TimeOfDay? pickedTime;
  var timeController=TextEditingController();
  var dateController=TextEditingController();
  var priceController=TextEditingController();
  var durationController=TextEditingController();


  //Audio Record
  final recorder=FlutterSoundRecorder();
  DateTime dateTime = DateTime.now();







  // var get_receiverId=Get.arguments[0];

  // sendMessage(String senderId ,String receiverId ,{String? message,var image}) async{
  //    try{
  //      Uint8List imageBytes = image.readAsBytesSync();
  //      String baseimage = base64Encode(imageBytes);
  //     var data={'sender_id':senderId,'receiver_id':receiverId,'message':message,'image':baseimage};
  //
  //
  //     var data1=json.encode(data);
  //     var response=await post(Uri.parse('https://admin.octo-boss.com/API/SendMessage.php'),
  //         body: data1
  //     );
  //     if(response.statusCode==201){
  //       print('Message Send Successfully : 201');
  //       var data2=jsonDecode(response.body.toString());
  //       // Fluttertoast.showToast(msg: '${data2['message'].toString()}');
  //       print(data);
  //       return true;
  //     }
  //     else if(response.statusCode==200){
  //       print('Register code : 200');
  //       var data2=jsonDecode(response.body.toString());
  //       // Fluttertoast.showToast(msg: '${data2['message'].toString()}');
  //       print(data);
  //       return false;
  //     }
  //     else{
  //       print('Message Send Failed  : else');
  //       var data2=jsonDecode(response.body.toString());
  //       // Fluttertoast.showToast(msg: '${data2['message'].toString()}');
  //
  //       print(data);
  //       return false;
  //     }
  //
  //   }catch(e){
  //     Fluttertoast.showToast(msg: e.toString());
  //     return false;
  //   }
  //
  // }
  sendMessage(String senderId ,String receiverId ,String message) async{
     try{

      var data={'sender_id':senderId,'receiver_id':receiverId,'message':message,'message_type':'message'};


      //It is used for raw data;
      // var data1=json.encode(data);
      var response=await post(Uri.parse('https://admin.octo-boss.com/API/SendMessage.php'),
          body: data
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
  updateOfferStatus(var offerId ,var status,var offerdetail) async{
     try{

      var data={'chat_id':offerId,'status':status};
      var data1=json.encode(data);


      var response=await post(Uri.parse('https://admin.octo-boss.com/API/UpdateChatStatus.php'),
          body: data1
      );
      if(response.statusCode==201){
        print('Offer Successfully Updated : 201');
        var data2=jsonDecode(response.body.toString());
        // Fluttertoast.showToast(msg: '${data2['message'].toString()}');
        print('Offer value: ${offerdetail} : RuntimeType : ${offerdetail.runtimeType}');

        offer_details=offerdetail;
        print('Data Value : ${offer_details} : RuntimeType : ${offer_details.runtimeType}');
        return true;
      }
      else if(response.statusCode==200){
        print('Offer Updated Failed: 200');
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
  sendIssue(String senderId ,String receiverId ,var problem,var description,var location,var language) async{
     try{

      var data={
        'sender_id':senderId,
        'receiver_id':receiverId,
        'message_type':'issue',
        'problem':problem,
        'description':description,
        'location':location,
        'language':language
      };


      //It is used for raw data;
      // var data1=json.encode(data);
      var response=await post(Uri.parse('https://admin.octo-boss.com/API/SendMessage.php'),
          body: data
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
  sendOffer(String senderId ,String receiverId ,var time,var date,var price,var duration) async{
     try{

      var data={
        'sender_id':senderId,
        'receiver_id':receiverId,
        'message_type':'offer',
        'time':time,
        'date':date,
        'price':price,
        'duration':duration,
        'approved':'pending'
      };


      //It is used for raw data;
      // var data1=json.encode(data);
      var response=await post(Uri.parse('https://admin.octo-boss.com/API/SendMessage.php'),
          body: data
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
  sendContact(String senderId ,String receiverId ,String contactName,String contactNo) async{
     try{

      var data={
        'sender_id':senderId,
        'receiver_id':receiverId,
        'message_type':'contact',
        'contact_name':contactName,
        'contact_no':contactNo
      };


      //It is used for raw data;
      // var data1=json.encode(data);
      var response=await post(Uri.parse('https://admin.octo-boss.com/API/SendMessage.php'),
          body: data
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
  sendVoice(String senderId ,String receiverId ,var voice) async{
    try{

      var data={'sender_id':senderId,
        'receiver_id':receiverId,
        'message':'voice','message_type':'audio','image':voice};


      //It is used for raw data;
      // var data1=json.encode(data);
      var response=await post(Uri.parse('https://admin.octo-boss.com/API/SendMessage.php'),
          body: data
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
  sendPhoto(String senderId ,String receiverId ,var image) async{
    try{
      // var bytes = image.readAsBytesSync();
      // var filename=image.path.split('/').last;
      // print('Filename : $filename');

      var image2=image.readAsBytesSync();

      var data={'sender_id':senderId,'receiver_id':receiverId,'message_type':'image', 'file':await image2.toString(),};

      //It is used for raw data;
      // var data1=json.encode(data);
      var response=await post(Uri.parse('https://admin.octo-boss.com/API/SendMessage.php'),
          body: data
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
  sendPicture(String senderId ,String receiverId ,var image) async{
    try{
      var uri=Uri.parse('https://admin.octo-boss.com/API/SendMessage.php');
      var request = http.MultipartRequest("POST", uri);
      //add text fields
      request.fields["sender_id"] = senderId;
      request.fields["receiver_id"] = receiverId;
      request.fields["message_type"] = 'image';

      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'file', image);

      request.files.add(multipartFile);
      var response = await request.send();
      print('response : $response');


      // var data={'sender_id':senderId,'receiver_id':receiverId,'message_type':'image', 'file':await image2.toString(),};
      //
      // //It is used for raw data;
      // // var data1=json.encode(data);
      // var response=await post(Uri.parse('https://admin.octo-boss.com/API/SendMessage.php'),
      //     body: data
      // );
      // if(response.statusCode==201){
      //   print('Message Send Successfully : 201');
      //   var data2=jsonDecode(response.body.toString());
      //   // Fluttertoast.showToast(msg: '${data2['message'].toString()}');
      //   print(data);
      //   return true;
      // }
      // else if(response.statusCode==200){
      //   print('Register code : 200');
      //   var data2=jsonDecode(response.body.toString());
      //   // Fluttertoast.showToast(msg: '${data2['message'].toString()}');
      //   print(data);
      //   return false;
      // }
      // else{
      //   print('Message Send Failed  : else');
      //   var data2=jsonDecode(response.body.toString());
      //   // Fluttertoast.showToast(msg: '${data2['message'].toString()}');
      //
      //   print(data);
      //   return false;
      // }

    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }

  }
  sendAudio(String senderId ,String receiverId ,var audio) async{
    try{
      var uri=Uri.parse('https://admin.octo-boss.com/API/SendMessage.php');
      var request = http.MultipartRequest("POST", uri);
      //add text fields
      request.fields["sender_id"] = senderId;
      request.fields["receiver_id"] = receiverId;
      request.fields["message_type"] = 'audio';

      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'file', audio);

      request.files.add(multipartFile);
      var response = await request.send();
      print('response : $response');


      // var data={'sender_id':senderId,'receiver_id':receiverId,'message_type':'image', 'file':await image2.toString(),};
      //
      // //It is used for raw data;
      // // var data1=json.encode(data);
      // var response=await post(Uri.parse('https://admin.octo-boss.com/API/SendMessage.php'),
      //     body: data
      // );
      // if(response.statusCode==201){
      //   print('Message Send Successfully : 201');
      //   var data2=jsonDecode(response.body.toString());
      //   // Fluttertoast.showToast(msg: '${data2['message'].toString()}');
      //   print(data);
      //   return true;
      // }
      // else if(response.statusCode==200){
      //   print('Register code : 200');
      //   var data2=jsonDecode(response.body.toString());
      //   // Fluttertoast.showToast(msg: '${data2['message'].toString()}');
      //   print(data);
      //   return false;
      // }
      // else{
      //   print('Message Send Failed  : else');
      //   var data2=jsonDecode(response.body.toString());
      //   // Fluttertoast.showToast(msg: '${data2['message'].toString()}');
      //
      //   print(data);
      //   return false;
      // }

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
            if((chhh[m]['receiver_id']==get_receiverId.toString() && chhh[m]['sender_id']==user_details['data']['id']) || (chhh[m]['receiver_id']==user_details['data']['id'] && chhh[m]['sender_id']==get_receiverId.toString()))

            {
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
  bool emojiShowing = false;

  _onEmojiSelected(Emoji emoji) {
    messageController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: messageController.text.length));
  }

  _onBackspacePressed() {
    messageController
      ..text = messageController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: messageController.text.length));
  }
@override
  void dispose() {
    audioPlayer.dispose();
    recorder.closeRecorder();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    initRecorder();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying=state==PlayerState.PLAYING;

      });

    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration=newDuration;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position=newPosition;
      });

    });

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
                  Text(get_octobossName.toString()),
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

                      if(messages[index]['message_type']=='image'){
                        return x==y? Row(
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

                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                messages[index]['image']),
                                            fit: BoxFit.contain)),
                                    width: Get.size.width*0.6,
                                    height: Get.size.height*0.35,


                                    // child: Column(
                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                    //   children: [
                                    //     CircleAvatar(
                                    //       radius: 50,
                                    //       backgroundColor: Colors.blue,
                                    //       backgroundImage: NetworkImage(
                                    //           messages[index]['image']
                                    //       ),
                                    //     )
                                    //
                                    //   ],
                                    // ),
                                  ),
                                )),

                            // Column(children: [],),
                          ],
                        ):
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(

                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                messages[index]['image']),
                                            fit: BoxFit.contain)),
                                    width: Get.size.width*0.6,
                                    height: Get.size.height*0.35,


                                    // child: Column(
                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                    //   children: [
                                    //     CircleAvatar(
                                    //       radius: 50,
                                    //       backgroundColor: Colors.blue,
                                    //       backgroundImage: NetworkImage(
                                    //           messages[index]['image']
                                    //       ),
                                    //     )
                                    //
                                    //   ],
                                    // ),
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
                      }
                      if(messages[index]['message_type']=='audio'){
                        return x==y?Row(
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
                                      crossAxisAlignment: CrossAxisAlignment.end,

                                      children: [
                                        Row(children: [
                                          CircleAvatar(
                                            radius: 20,
                                            child: IconButton(
                                              icon: Icon(isPlaying?Icons.pause:Icons.play_arrow),
                                              onPressed: () async {
                                                if(isPlaying){
                                                  await audioPlayer.pause();

                                                }
                                                else{
                                                  String url=messages[index]['image'].toString();
                                                  print('URl of Audio : $url');
                                                  await audioPlayer.play(url);

                                                }
                                              },
                                            ),
                                          ),
                                          Slider(
                                              min:0,
                                              max:duration.inSeconds.toDouble(),
                                              value: position.inSeconds.toDouble(),

                                              onChanged: (value) async{
                                                final position=Duration(seconds: value.toInt());
                                                await audioPlayer.seek(position);
                                                await audioPlayer.resume();
                                              }
                                          )
                                        ],),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          // crossAxisAlignment: CrossAxisAlignment,
                                          mainAxisSize: MainAxisSize.max,

                                          children: [
                                          Text('${position.inSeconds.toString()} : ${position.inMinutes.toString()}'),
                                          SizedBox(width: Get.size.width*0.25 ,),

                                          Text('${(duration-position).inSeconds} : ${position.inMinutes.toString()}'),

                                        ],)
                                      ],
                                    ),
                                    


                                    // child: Column(
                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                    //   children: [
                                    //     CircleAvatar(
                                    //       radius: 50,
                                    //       backgroundColor: Colors.blue,
                                    //       backgroundImage: NetworkImage(
                                    //           messages[index]['image']
                                    //       ),
                                    //     )
                                    //
                                    //   ],
                                    // ),
                                  ),
                                )),

                            // Column(children: [],),
                          ],
                        ):
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,

                                      children: [
                                        Row(children: [
                                          CircleAvatar(
                                            radius: 20,
                                            child: IconButton(
                                              icon: Icon(isPlaying?Icons.pause:Icons.play_arrow),
                                              onPressed: () async {
                                                if(isPlaying){
                                                  await audioPlayer.pause();

                                                }
                                                else{
                                                  String url=messages[index]['image'].toString();
                                                  print('URl of Audio : $url');
                                                  await audioPlayer.play(url);

                                                }
                                              },
                                            ),
                                          ),
                                          Slider(
                                              min:0,
                                              max:duration.inSeconds.toDouble(),
                                              value: position.inSeconds.toDouble(),

                                              onChanged: (value) async{
                                                final position=Duration(seconds: value.toInt());
                                                await audioPlayer.seek(position);
                                                await audioPlayer.resume();
                                              }
                                          )
                                        ],),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          // crossAxisAlignment: CrossAxisAlignment,
                                          mainAxisSize: MainAxisSize.max,

                                          children: [
                                            Text('${position.inSeconds.toString()} : ${position.inMinutes.toString()}'),
                                            SizedBox(width: Get.size.width*0.25 ,),

                                            Text('${(duration-position).inSeconds} : ${position.inMinutes.toString()}'),

                                          ],)
                                      ],
                                    ),



                                    // child: Column(
                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                    //   children: [
                                    //     CircleAvatar(
                                    //       radius: 50,
                                    //       backgroundColor: Colors.blue,
                                    //       backgroundImage: NetworkImage(
                                    //           messages[index]['image']
                                    //       ),
                                    //     )
                                    //
                                    //   ],
                                    // ),
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
                      }
                      if(messages[index]['message_type']=='contact'){
                        return x==y?Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/home_logo_new.jpg',
                              ),
                              radius: 30,
                              backgroundColor: Colors.white,
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(

                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Name'),
                                        Text('Contact No'),
                                      ],
                                    ),
                                    SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(messages[index]['contact_name']),
                                        Text(messages[index]['contact_no']),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ):
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(

                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Name'),
                                        Text('Contact No'),
                                      ],
                                    ),
                                    SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(messages[index]['contact_name']),
                                        Text(messages[index]['contact_no']),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/home_logo_new.jpg',
                              ),
                              radius: 30,
                              backgroundColor: Colors.white,
                            ),

                          ],
                        );
                      }
                      if(messages[index]['message_type']=='issue'){
                        return x==y?Row(
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,

                                      children: [
                                        Container(
                                          child: Text('Issue Shared',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
                                      ],
                                    ),
                                   SizedBox(height: 5,child: Container(color: Colors.black,width: Get.size.width*0.4,height: 10,)),
                                    Row(
                                      children: [

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Problem'),
                                            Text('Description'),
                                            Text('Location'),
                                            Text('Languages'),
                                          ],
                                        ),
                                        SizedBox(width: Get.size.width*0.1,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(messages[index]['problem']),
                                            Text(messages[index]['description']),
                                            Text(messages[index]['location']),
                                            Text(messages[index]['language']),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )

                          ],
                        ):
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      // mainAxisSize: MainAxisSize.max,

                                      children: [
                                        Container(
                                            child: Text('Issue Shared',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
                                      ],
                                    ),
                                    SizedBox(height: 5,child: Container(color: Colors.black,width: Get.size.width*0.4,height: 10,)),
                                    Row(
                                      children: [

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Problem'),
                                            Text('Description'),
                                            Text('Location'),
                                            Text('Languages'),
                                          ],
                                        ),
                                        SizedBox(width: Get.size.width*0.1,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(messages[index]['problem']),
                                            Text(messages[index]['description']),
                                            Text(messages[index]['location']),
                                            Text(messages[index]['language']),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/home_logo_new.jpg',
                              ),
                              radius: 30,
                              backgroundColor: Colors.white,
                            ),

                          ],
                        );

                      }
                      if(messages[index]['message_type']=='offer'){
                        if(messages[index]['approved']=='cancel'){
                          return x==y? Row(
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
                                elevation: 7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('New Offer',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.orange,fontSize: 20)),
                                        ],
                                      ),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('TIME'),
                                            Container(width: Get.size.width*0.6,
                                              child: TextFormField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  hintText: messages[index]['time'],
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
                                            ),
                                          ],
                                        )
                                      ]),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('DATE'),
                                            Container(width: Get.size.width*0.6,
                                              child: TextFormField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  hintText: messages[index]['dates'],
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
                                            ),
                                          ],
                                        )
                                      ]),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('PRICE'),
                                                Container(width: Get.size.width*0.27,
                                                  child: TextFormField(
                                                    enabled: false,
                                                    decoration: InputDecoration(
                                                      hintText: '${messages[index]['price']} \$',
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
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: Get.size.width*0.06,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('DURATION'),
                                                Container(width: Get.size.width*0.27,
                                                  child: TextFormField(
                                                    enabled: false,
                                                    decoration: InputDecoration(
                                                      hintText: '${messages[index]['duration']} hrs',
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
                                                ),
                                              ],
                                            ),
                                          ]),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(

                                        children: [
                                          Text('Cancelled')
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              )
                            ],
                          ): Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Card(
                                elevation: 7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('New Offer',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.orange,fontSize: 20)),
                                        ],
                                      ),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('TIME'),
                                            Container(width: Get.size.width*0.6,
                                              child: TextFormField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  hintText: messages[index]['time'],
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
                                            ),
                                          ],
                                        )
                                      ]),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('DATE'),
                                            Container(width: Get.size.width*0.6,
                                              child: TextFormField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  hintText: messages[index]['dates'],
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
                                            ),
                                          ],
                                        )
                                      ]),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('PRICE'),
                                                Container(width: Get.size.width*0.27,
                                                  child: TextFormField(
                                                    enabled: false,
                                                    decoration: InputDecoration(
                                                      hintText: '${messages[index]['price']} \$',
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
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: Get.size.width*0.06,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('DURATION'),
                                                Container(width: Get.size.width*0.27,
                                                  child: TextFormField(
                                                    enabled: false,
                                                    decoration: InputDecoration(
                                                      hintText: '${messages[index]['duration']} hrs',
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
                                                ),
                                              ],
                                            ),
                                          ]),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(

                                        children: [
                                          Text('Cancelled',style: TextStyle(fontSize: 15,color: Colors.orange,fontWeight: FontWeight.bold),)
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                  'assets/images/home_logo_new.jpg',
                                ),
                                radius: 30,
                                backgroundColor: Colors.white,
                              ),
                            ],
                          );
                        }
                        if(messages[index]['approved'].toString().toLowerCase()=='approved'){
                          return x==y? Row(
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
                                elevation: 7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('New Offer',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.orange,fontSize: 20)),
                                        ],
                                      ),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('TIME'),
                                            Container(width: Get.size.width*0.6,
                                              child: TextFormField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  hintText: messages[index]['time'],
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
                                            ),
                                          ],
                                        )
                                      ]),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('DATE'),
                                            Container(width: Get.size.width*0.6,
                                              child: TextFormField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  hintText: messages[index]['dates'],
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
                                            ),
                                          ],
                                        )
                                      ]),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('PRICE'),
                                                Container(width: Get.size.width*0.27,
                                                  child: TextFormField(
                                                    enabled: false,
                                                    decoration: InputDecoration(
                                                      hintText: '${messages[index]['price']} \$',
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
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: Get.size.width*0.06,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('DURATION'),
                                                Container(width: Get.size.width*0.27,
                                                  child: TextFormField(
                                                    enabled: false,
                                                    decoration: InputDecoration(
                                                      hintText: '${messages[index]['duration']} hrs',
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
                                                ),
                                              ],
                                            ),
                                          ]),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(

                                        children: [
                                          Text('Approved')
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              )
                            ],
                          ):
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Card(
                                elevation: 7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('New Offer',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.orange,fontSize: 20)),
                                        ],
                                      ),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('TIME'),
                                            Container(width: Get.size.width*0.6,
                                              child: TextFormField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  hintText: messages[index]['time'],
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
                                            ),
                                          ],
                                        )
                                      ]),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('DATE'),
                                            Container(width: Get.size.width*0.6,
                                              child: TextFormField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  hintText: messages[index]['dates'],
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
                                            ),
                                          ],
                                        )
                                      ]),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('PRICE'),
                                                Container(width: Get.size.width*0.27,
                                                  child: TextFormField(
                                                    enabled: false,
                                                    decoration: InputDecoration(
                                                      hintText: '${messages[index]['price']} \$',
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
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: Get.size.width*0.06,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('DURATION'),
                                                Container(width: Get.size.width*0.27,
                                                  child: TextFormField(
                                                    enabled: false,
                                                    decoration: InputDecoration(
                                                      hintText: '${messages[index]['duration']} hrs',
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
                                                ),
                                              ],
                                            ),
                                          ]),
                                      SizedBox(height: Get.size.height*0.02,),
                                      Row(

                                        children: [
                                          Text('Approved',style: TextStyle(fontSize: 15,color: Colors.orange,fontWeight: FontWeight.bold),)
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                  'assets/images/home_logo_new.jpg',
                                ),
                                radius: 30,
                                backgroundColor: Colors.white,
                              ),
                            ],
                          );
                        }
                        else{
                        return x==y?Row(
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
                              elevation: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('New Offer',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.orange,fontSize: 20)),
                                      ],
                                    ),
                                    SizedBox(height: Get.size.height*0.02,),
                                    Row(children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('TIME'),
                                          Container(width: Get.size.width*0.6,
                                            child: TextFormField(
                                              enabled: false,
                                              decoration: InputDecoration(
                                                hintText: messages[index]['time'],
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
                                          ),
                                        ],
                                      )
                                    ]),
                                    SizedBox(height: Get.size.height*0.02,),
                                    Row(children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('DATE'),
                                          Container(width: Get.size.width*0.6,
                                            child: TextFormField(
                                              enabled: false,
                                              decoration: InputDecoration(
                                                hintText: messages[index]['dates'],
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
                                          ),
                                        ],
                                      )
                                    ]),
                                    SizedBox(height: Get.size.height*0.02,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('PRICE'),
                                              Container(width: Get.size.width*0.27,
                                                child: TextFormField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    hintText: '${messages[index]['price']} \$',
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
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: Get.size.width*0.06,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('DURATION'),
                                              Container(width: Get.size.width*0.27,
                                                child: TextFormField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    hintText: '${messages[index]['duration']} hrs',
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
                                              ),
                                            ],
                                          ),
                                    ]),
                                    SizedBox(height: Get.size.height*0.02,),
                                    Row(

                                      children: [
                                              MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12)),
                                            color: Colors.orange,
                                            onPressed: () {
                                              updateOfferStatus(messages[index]['id'], 'approved',messages[index]);

                                            },
                                            child: Text(
                                              'Accept offer',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        SizedBox(width: Get.size.width*0.06,),
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12)),
                                          color: Colors.orange,
                                          onPressed: () {
                                            updateOfferStatus(messages[index]['id'], 'cancel',messages[index]);

                                          },
                                          child: Text(
                                            'Refuse',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    )

                                  ],
                                ),
                              ),
                            )
                          ],
                        ):
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Card(
                              elevation: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('New Offer',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.orange,fontSize: 20)),
                                      ],
                                    ),
                                    SizedBox(height: Get.size.height*0.02,),
                                    Row(children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('TIME'),
                                          Container(width: Get.size.width*0.6,
                                            child: TextFormField(
                                              enabled: false,
                                              decoration: InputDecoration(
                                                hintText: messages[index]['time'],
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
                                          ),
                                        ],
                                      )
                                    ]),
                                    SizedBox(height: Get.size.height*0.02,),
                                    Row(children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('DATE'),
                                          Container(width: Get.size.width*0.6,
                                            child: TextFormField(
                                              enabled: false,
                                              decoration: InputDecoration(
                                                hintText: messages[index]['dates'],
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
                                          ),
                                        ],
                                      )
                                    ]),
                                    SizedBox(height: Get.size.height*0.02,),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('PRICE'),
                                              Container(width: Get.size.width*0.27,
                                                child: TextFormField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    hintText: '${messages[index]['price']} \$',
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
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: Get.size.width*0.06,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('DURATION'),
                                              Container(width: Get.size.width*0.27,
                                                child: TextFormField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    hintText: '${messages[index]['duration']} hrs',
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
                                              ),
                                            ],
                                          ),
                                        ]),
                                    SizedBox(height: Get.size.height*0.02,),
                                    Row(

                                      children: [
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12)),
                                          color: Colors.orange,
                                          onPressed: () {


                                            updateOfferStatus(messages[index]['id'], 'approved',messages[index]);

                                          },
                                          child: Text(
                                            'Accept offer',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(width: Get.size.width*0.06,),
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12)),
                                          color: Colors.orange,
                                          onPressed: () {
                                            // Fluttertoast.showToast(msg: '${int.parse(messages[index]['id'])}: ${messages[index]['id'].runtimeType}');
                                            updateOfferStatus(messages[index]['id'], 'cancel',messages[index]);

                                          },
                                          child: Text(
                                            'Refuse',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    )

                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/home_logo_new.jpg',
                              ),
                              radius: 30,
                              backgroundColor: Colors.white,
                            ),
                          ],
                        );}
                      }
                      else{
                        return x==y? Row(
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
                        ):
                        Row(
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
                      }

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
                                              child: IconButton(
                                                onPressed: () {
                                                  // Offstage(
                                                  //   offstage: true,
                                                  //   child: EmojiPicker(
                                                  //     onEmojiSelected: (category, emoji) {
                                                  //       // Do something when emoji is tapped
                                                  //     },
                                                  //     onBackspacePressed: () {
                                                  //       // Backspace-Button tapped logic
                                                  //       // Remove this line to also remove the button in the UI
                                                  //     },
                                                  //     config: Config(
                                                  //         columns: 7,
                                                  //         emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                                                  //         verticalSpacing: 0,
                                                  //         horizontalSpacing: 0,
                                                  //         initCategory: Category.RECENT,
                                                  //         bgColor: Color(0xFFF2F2F2),
                                                  //         indicatorColor: Colors.blue,
                                                  //         iconColor: Colors.grey,
                                                  //         iconColorSelected: Colors.blue,
                                                  //         progressIndicatorColor: Colors.blue,
                                                  //         backspaceColor: Colors.blue,
                                                  //         skinToneDialogBgColor: Colors.white,
                                                  //         skinToneIndicatorColor: Colors.grey,
                                                  //         enableSkinTones: true,
                                                  //         showRecentsTab: true,
                                                  //         recentsLimit: 28,
                                                  //         noRecentsText: "No Recents",
                                                  //         noRecentsStyle:
                                                  //         const TextStyle(fontSize: 20, color: Colors.black26),
                                                  //         tabIndicatorAnimDuration: kTabScrollDuration,
                                                  //         categoryIcons: const CategoryIcons(),
                                                  //         buttonMode: ButtonMode.MATERIAL
                                                  //     ),
                                                  //   ),
                                                  // );
                                                  // Get.to(MessageEmoji());
                                                  setState(() {
                                                    emojiShowing = !emojiShowing;
                                                  });
                                                },
                                                icon: Icon(Icons.emoji_emotions)
                                              )),
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
                                          Visibility(
                                            visible: visibility_attach,
                                            child: Expanded(
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
                                          ),
                                          Visibility(
                                            visible: visibility_timer,
                                            child: StreamBuilder<RecordingDisposition>(
                                              stream: recorder.onProgress,
                                              builder: (context, snapshot) {
                                                final duration=snapshot.hasData?snapshot.data!.duration:Duration.zero;
                                                String twoDigits(int n) => n.toString().padLeft(2, "0");
                                                String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
                                                String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
                                                return Text('$twoDigitMinutes : $twoDigitSeconds',style: TextStyle(fontWeight: FontWeight.bold),);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 0,
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: IconButton(
                                                icon: Icon(
                                                    recorder.isRecording?Icons.stop:Icons.keyboard_voice_rounded
                                                ),
                                                onPressed: () async {
                                                  if(recorder.isRecording){
                                                    setState(() {
                                                      visibility_attach=true;
                                                      visibility_timer=false;
                                                    });
                                                    await stop();
                                                  }
                                                  else{
                                                    setState(() {
                                                      visibility_attach=false;
                                                      visibility_timer=true;
                                                    });
                                                    await record();
                                                  }
                                                  setState(() {

                                                  });
                                                },
                                              ),
                                              // child:SocialMediaRecorder(
                                              //   sendRequestFunction: (soundFile) {
                                              //     // print("the current path is ${soundFile.path}");
                                              //   },
                                              //     storeSoundRecoringPath: record,
                                              //     cancelText: 'Cancelled',
                                              //     slideToCancelText: '< Slide to Cancel',
                                              //     counterBackGroundColor: Colors.red,
                                              //
                                              //
                                              //
                                              //   encode: AudioEncoderType.AAC,
                                              //     recordIcon: Icon(Icons.keyboard_voice_rounded)
                                              // ),
                                              ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),

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
                                      sendMessage(user_details['data']['id'],get_receiverId.toString(), messageController.text.toString());
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
            ),
            Offstage(
              offstage: !emojiShowing,
              child: SizedBox(
                height: 250,
                width: Get.size.width,
                child: EmojiPicker(
                    onEmojiSelected: (Category category, Emoji emoji) {
                      _onEmojiSelected(emoji);
                    },
                    onBackspacePressed: _onBackspacePressed,
                    config: Config(
                        columns: 7,
                        // Issue: https://github.com/flutter/flutter/issues/28894
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        initCategory: Category.RECENT,
                        bgColor: const Color(0xFFF2F2F2),
                        indicatorColor: Colors.blue,
                        iconColor: Colors.grey,
                        iconColorSelected: Colors.blue,
                        progressIndicatorColor: Colors.blue,
                        backspaceColor: Colors.blue,
                        skinToneDialogBgColor: Colors.white,
                        skinToneIndicatorColor: Colors.grey,
                        enableSkinTones: true,
                        showRecentsTab: true,
                        recentsLimit: 28,
                        // noRecents: const Text(
                        //   'No Recents',
                        //   style: TextStyle(fontSize: 20, color: Colors.black26),
                        //   textAlign: TextAlign.center,
                        // ),
                        noRecentsText: 'No Recents',
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL)),
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
                      onTap: () async {
                        pickedTime =
                        await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );

                        if (pickedTime != null) {
                          print(pickedTime?.format(
                              context)); //output 10:51 PM

                          setState(() {
                            timeController.text = pickedTime!.format(
                                context); //set the value of text field.
                          });
                        } else {
                          print("Time is not selected");
                        }
                      },

                      controller: timeController,

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
                      onTap: () => _selectDate(),
                      controller: dateController,
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
                            controller: priceController,
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
                            controller: durationController,
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
                            sendOffer(user_details['data']['id'],get_receiverId.toString(), timeController.text, dateController.text, priceController.text, durationController.text);
                            timeController.clear();
                            dateController.clear();
                            priceController.clear();
                            durationController.clear();
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
      height: Get.height*0.2,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();

                    },
                    child: CircleAvatar(
                      child: Icon(Icons.file_copy),
                      radius: 30,
                    ),
                  ),
                  Text('Document')
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      getImageCamera();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.camera_alt),
                      radius: 30,
                    ),
                  ),
                  Text('Camera')
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      getImageGallery();
                        },
                    child: CircleAvatar(
                      child: Icon(Icons.image),
                      radius: 30,
                    ),
                  ),
                  Text('Gallery')
                ],
              )

            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      getAudio();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.music_note),
                      radius: 30,
                    ),
                  ),
                  Text('Audio')
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      Get.back();
                      final FullContact contact = await FlutterContactPicker.pickFullContact();
                      var name=contact.name!.nickName;
                      var number=contact.phones[1].number;
                      sendContact(user_details['data']['id'],get_receiverId.toString(), name.toString(), number.toString());

                      // print('Contact Details : ${contact.name!.nickName}\n');
                      // print('Contact Details : ${contact.phones[1].number}\n');
                      // setState(() {
                      // _contact = contact.toString();
                      // _contactPhoto = contact.photo?.asWidget();
                      // });
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                      radius: 30,
                    ),
                  ),
                  Text('Contact')
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) =>
                            Issue_Bottomsheet()),
                      );
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.error),
                      radius: 30,
                    ),
                  ),
                  Text('Share Issue')
                ],
              ),

            ],
          )
          // Text(
          //   "Choose profile photo or video",
          //   style: TextStyle(color: Colors.black, fontSize: 14),
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     FlatButton.icon(
          //         onPressed: () {
          //
          //           //  takePhoto(ImageSource.camera);
          //         },
          //         icon: Icon(Icons.video_collection),
          //         label: Text("Video ")),
          //     FlatButton.icon(
          //         onPressed: () {
          //           getImageGallery();
          //           // setState(() {
          //           //   imageLink;
          //           //
          //           // });
          //           // showDialog(
          //           //     context: context,
          //           //     builder: (BuildContext context) => new AlertDialog(
          //           //       title: new Text('Warning'),
          //           //       content: new Text('Hi this is Flutter Alert Dialog'),
          //           //       actions: <Widget>[
          //           //         new IconButton(
          //           //             icon: new Icon(Icons.close),
          //           //             onPressed: () {
          //           //               Navigator.pop(context);
          //           //             })
          //           //       ],
          //           //     ));
          //           Get.defaultDialog(
          //               title: "View Photo",
          //               // middleText: "Hello world!",
          //               // backgroundColor: Colors.green,
          //               // titleStyle: TextStyle(color: Colors.white),
          //               // middleTextStyle: TextStyle(color: Colors.white),
          //               // textConfirm: "Chat with me",
          //               // textCancel: "Favorite",
          //               // cancelTextColor: Colors.white,
          //               // confirmTextColor: Colors.white,
          //               // buttonColor: Colors.red,
          //               barrierDismissible: false,
          //
          //
          //               radius: 30,
          //               content: Column(
          //                 children: [
          //                   Container(
          //                     width: Get.size.width*0.8,
          //                     height: Get.size.height*0.6,
          //                     clipBehavior: Clip.antiAlias,
          //                     child: Image.file(File(imageLink!.path).absolute,fit: BoxFit.cover,),
          //                     decoration: BoxDecoration(
          //                       // color: Colors.orange,
          //                       border: Border.all(
          //                           width: 4,
          //                           color: Theme.of(context).scaffoldBackgroundColor),
          //                       boxShadow: [
          //                         BoxShadow(
          //                             spreadRadius: 2,
          //                             blurRadius: 10,
          //                             color: Colors.black.withOpacity(0.1),
          //                             offset: Offset(0, 10))
          //                       ],
          //                       image: DecorationImage(
          //                         fit: BoxFit.cover,
          //                         image: NetworkImage(''),
          //                       ),
          //                     ),
          //                   ),
          //                   Align(
          //                     // alignment: Alignment.centerRight,
          //                     child: IconButton(onPressed: () {
          //                       sendMessage(user_details['data']['id'],get_receiverId.toString(),image: imageLink);
          //                     },icon: Icon(Icons.send,size: 40),
          //                     ),
          //                   )
          //                 ],
          //               )
          //           );
          //           setState(() {
          //
          //           });
          //           // takePhoto(ImageSource.gallery);
          //         },
          //         icon: Icon(Icons.image),
          //         label: Text("Gallery ")),
          //   ],
          // ),
        ],
      ),
    );
  }
  Widget Issue_Bottomsheet() {
    return FutureBuilder<issueList>(
        future: getPostApi(),
        builder: (context,AsyncSnapshot snapshot) {
          if(snapshot.data!=null){
            return ListView.builder(
              itemCount: abc.length,
              itemBuilder: (context, index) {
                // status=checkValue(abc[index]['issue_type']);
                print('Status Value : $status');

                if(snapshot.hasData){
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 8),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                        sendIssue(user_details['data']['id'],get_receiverId.toString(), 'carpanter', abc[index]['description'], abc[index]['title'], abc[index]['languages']);

                      },
                      child: Card(
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                              Row(
                                mainAxisSize:MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(abc[index]['image']),
                                          radius: 35,
                                          backgroundColor: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(abc[index]['title']),
                                          Text(abc[index]['status']),
                                          Text(abc[index]['description']),
                                          Text(abc[index]['languages']),
                                          // Text(snapshot
                                          //     .data.data[index].status
                                          //     .toString()),
                                          // Text(snapshot
                                          //     .data.data[index].description
                                          //     .toString()),
                                          // Text(snapshot
                                          //     .data.data[index].languages
                                          //     .toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  );
                }
                else{
                  return CircularProgressIndicator();
                }

              },
            );
          }
          else{
            return Center(child: CircularProgressIndicator());
          }

        });
  }

  void getImageCamera() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );
    setState(() {
      imageLink = File(image!.path);
    });
    sendPicture(user_details['data']['id'],get_receiverId.toString(), imageLink!.path);
  }
  void getImageGallery() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );
    setState(() {
      imageLink = File(image!.path);
    });
    // sendPhoto(user_details['data']['id'],get_receiverId.toString(), imageLink!.path);
    sendPicture(user_details['data']['id'],get_receiverId.toString(), imageLink!.path);

  }

  Future record() async{
    await recorder.startRecorder(toFile: 'audio');
  }
  Future stop() async{
   final path= await recorder.stopRecorder();
   final audiofile=File(path!);
   // sendVoice(user_details['data']['id'],get_receiverId.toString(), audiofile.path);
   sendAudio(user_details['data']['id'],get_receiverId.toString(), audiofile.path);
   print('Recorded audio : ${audiofile}');
  }

  Future initRecorder() async{
    final status=await Permission.microphone.request();
    if(status!=PermissionStatus.granted){
      throw 'Microphone Permission not granted';
    }
    await recorder.openRecorder();
    
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));

  }

  Future<void> getAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
    var audio = result!.files.first;

    if(result != null) {
      File file = File(result.files.single.path.toString());
      sendAudio(user_details['data']['id'],get_receiverId.toString(), file.path);
    } else {
      // User canceled the picker
    }
    // var audiofile=File(result.files.single.path);

    print('result $result');

  }
  Future<issueList> getPostApi() async {

    final response = await http.get(
        Uri.parse("https://admin.noqta-market.com/new/API/IssuesList.php"));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 201) {
      issue_details=data['data'];
      var x=user_details['data']['id'];

      var len=data['data'].length-1;
      print('Length of data : $len');
      var y;
      var ind=0;
      var ls=[];
      abc.clear();
      // var abc=[];
      // data['data'].contains('');
      // var data4= data.where((data) => (data['created_by'].contains(73.toString())));

      // print('Data Value is\n ${data['data'][10]['created_by']}');
      // print('Mazhar Data\n${data['data'].length}');
      for(int i=0;len>=i;i++){
        print('I value is :$i');
        if(data['data'][i]['status']=='pending')
          // var w=jsonDecode(data['data'][0]);
            {
          if (i <= len) {
            if (x == data['data'][i]['created_by']) {
              y = data['data'][i];

              abc.add(y);
              print('abc');

              // sorted_issue=sorted_issue.addAll(y);
              print('\nData Runtype ${y.runtimeType}');
              // ls[ind]=y;
              // sorted_issue.push(y);
              // print('Mazhar sorted');
            }
            // print('New value $i : ${}');
          }
        }
        // print("List Length ${y.length}");


        // y=data['data']['$i'][i]['created_by'];
        // print('i Value is : $i');
        // if(x==y){
        //   // sorted_issue=sorted_issue.add(data['data'][i]);
        //   print('Sorted Array');
        //   print('${data['data'][i.toString()]}');
        //   // sorted_issue.add(jsonEncode(data['data'][i]));
      }
      // print('Abc Testing :  ${abc[1]['title']}');
      // print('\nPakistan : ${y}\n');
      // }
      // print('Sorted List \n $sorted_issue');
      return issueList.fromJson(data);
    } else {
      return issueList.fromJson(data);
    }
  }
  checkValue(var value) {
    if(value=='public'){
      return true;
    }
    else{
      return false;
    }
  }

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      dateController.text = DateFormat.yMd().format(dateTime);
    }
  }

}
