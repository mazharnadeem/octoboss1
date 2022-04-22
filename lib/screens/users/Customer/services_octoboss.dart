
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:octbs_ui/Model/filteroctoboss.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:octbs_ui/controller/api/userDetails.dart';
import 'package:octbs_ui/screens/users/Customer/customer_chatlist_screen.dart';




class ServicesOctoboss extends StatefulWidget {
  const ServicesOctoboss({Key? key}) : super(key: key);

  @override
  State<ServicesOctoboss> createState() => _ServicesOctobossState();
}

class _ServicesOctobossState extends State<ServicesOctoboss> {


  var ttt=Get.arguments[0];
  var searching=0;
  var list_of_octoboss=[];
  var sorted_octoboss=[];
  var dummy_octoboss=[];
  var searchController=TextEditingController();
   bool active=false;
   var act;

   bool checkbool(var value){
     if(value=='Yes'){
       return true;
     }
     else {
       return false;
     }
     
   }

   
   var xxx='';
  Future<Filteroctoboss> getProducts() async{
    print('TTTT Value : $ttt');
    final response=await http.get(Uri.parse('https://admin.octo-boss.com/API/FilterOctoboss.php'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==201){

      list_of_octoboss=data['data'];
      // active=list_of_octoboss['is_active'];
      // print('active status : $active');
      print('Mazhar Data is : $list_of_octoboss');
      var len=data['data'].length;
      if(searching==0){
        // sorted_octoboss=list_of_octoboss.where(
        //       (u) => (u['service'].toString().toLowerCase().contains(
        //     ttt.toString().toLowerCase(),
        //   )),
        // ).toList();

        // print('New sort : ${sorted_octoboss}');
        for(int i=0;len>i;i++){
          act=list_of_octoboss[i]['is_active'];
          xxx=list_of_octoboss[i]['is_active'];
         print('active status $i : $act : ${checkbool(act)}');

          print('lahore: ${list_of_octoboss[i]['service']}');

          // if(list_of_octoboss[i]['service']==ttt.toString().trim()){
            print('gujrat found');
            var temp=list_of_octoboss[i];
            sorted_octoboss.add(temp);
            // sorted_list.a
          // }
        }
        //   print('mazhar');
        // sorted_octoboss=list_of_octoboss;
        searchController.text=ttt.toString().trim();
      }
      if(searching==1){
        sorted_octoboss=dummy_octoboss;
      }
      return Filteroctoboss.fromJson(data);
    }
    else{
      return Filteroctoboss.fromJson(data);
    }
  }
  @override
  void initState() {
    Filteroctoboss();
    // TODO: implement initState
    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Container(
                  // alignment: Alignment.center,
                  width: 33,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: IconButton(
                    alignment: Alignment.center,
                    onPressed: () {
                      // getProducts();
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    onChanged: (value) {

                      sorted_octoboss =list_of_octoboss.where(
                            (u) => (u['service'].toString().toLowerCase().contains(
                          value.toLowerCase(),
                        )),
                      ).toList();
                      dummy_octoboss=sorted_octoboss;
                      setState(() {
                        searching=1;
                      });



                      //Do something with the user input.
                    },
                    controller: searchController,
                    autocorrect: true,

                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: 'Search any Services...',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: IconButton(
                      onPressed: () {
                        print('Active==$active');
                      },
                      icon: Icon(
                        Icons.menu,
                        size: 35,
                        color: Colors.orange,
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.center,
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.orange)),
                child: Text('Now or Later'),
              ),
              Container(
                alignment: Alignment.center,
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.orange)),
                child: Text('Labours'),
              ),
              Container(
                alignment: Alignment.center,
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.orange)),
                child: Text('Sort/Filters'),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.orange.shade900,
            height: 50,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Result offering Benefits',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                // IconButton(
                //     onPressed: () {},
                //     icon: Icon(
                //       Icons.attach_file_rounded,
                //       color: Colors.white,
                //     ))
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),

          Expanded(
            child: FutureBuilder<Filteroctoboss>(
              future: getProducts(),
              builder: (context,AsyncSnapshot snapshot) {
                // if(snapshot.data!=null){
                return ListView.builder(
                  itemCount: sorted_octoboss.length,
                  itemBuilder: (context, index) {

                    return InkWell(
                      onTap: () {
                        Get.defaultDialog(
                            title: "Octoboss Profile",
                            // middleText: "Hello world!",
                            // backgroundColor: Colors.green,
                            // titleStyle: TextStyle(color: Colors.white),
                            // middleTextStyle: TextStyle(color: Colors.white),
                            // textConfirm: "Chat with me",
                            // textCancel: "Favorite",
                            // cancelTextColor: Colors.white,
                            // confirmTextColor: Colors.white,
                            // buttonColor: Colors.red,
                            barrierDismissible: false,

                            radius: 50,
                            content: Column(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.blue,
                                  backgroundImage: NetworkImage(
                                
                                      sorted_octoboss[index]['image']
                                  ),
                                  
                                ),
                                 
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                  Text('Name'),
                                  Text(list_of_octoboss[index]['name']),
                                ],),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Service Offered'),
                                    Text(sorted_octoboss[index]['service']),
                                  ],),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [

                                    ElevatedButton(
                                      onPressed: () {
                                        makeFavorite(sorted_octoboss[index]['id']);

                                      },
                                      child: const Text('Favorite'),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                          // fixedSize: const Size(100, 50),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(50))),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        get_receiverId=int.parse(sorted_octoboss[index]['id']);
                                        Get.to(CustomerChatListScreen());
                                      },
                                      child: const Text('Chat with me'),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                          // fixedSize: const Size(100, 50),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(50))),
                                    ),
                                  ],),



                              ],
                            )
                        );
                      },
                      child: Card(

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
                                    Stack( overflow: Overflow.visible, 
                                    //     fit: StackFit.loose,
                                    //  alignment: AlignmentDirectional.topCenter,
                                      children:[ CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.blue,
                                          backgroundImage: NetworkImage(
                                              sorted_octoboss[index]['image']
                                          ),
                                        ),
                                         checkbool(sorted_octoboss[index]['is_active'])?
                                        Positioned(
                                         top: 10,left: 80,
                                         child: CircleAvatar(backgroundColor: Colors.green,radius: 10,)):
                                           Positioned(
                                         top: 10,left: 80,
                                         child: CircleAvatar(backgroundColor: Colors.grey,radius: 10,)),

                                      ]),
                                     
                                                   
                               
        
                                      
                                    
                                     
                                     
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(list_of_octoboss[index]['name'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            )),
                                      ],
                                    ),
                                    Text(sorted_octoboss[index]['service'], style: TextStyle()),
                                    Text(sorted_octoboss[index]['experience'],
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
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(22),
                                          border: Border.all(color: Colors.grey)),
                                      child: Icon(
                                        Icons.done,
                                        size: 20,
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
                      ),
                    );
                  },);
                // }
                // else{
                // return Text('Loading');
                // }
              },
            ),
          )
        ],
      )),
    );
  }
}
