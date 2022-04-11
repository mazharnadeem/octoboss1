import 'package:flutter/material.dart';

class OctobossChatScreen extends StatefulWidget {
  const OctobossChatScreen({this.chatID, this.image, this.name, Key? key})
      : super(key: key);

  final String? image, name, chatID;

  @override
  _OctobossChatScreenState createState() => _OctobossChatScreenState();
}

class _OctobossChatScreenState extends State<OctobossChatScreen> {
  TextEditingController messageController = TextEditingController();
  // User? user = FirebaseAuth.instance.currentUser;

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
              padding: EdgeInsets.all(screenWidth * 0.04),
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
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                        size: screenHeight * 0.02,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Chat',
                    style: TextStyle(
                      fontSize: fontSize * 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage('${widget.image}'),
                  radius: 20,
                  backgroundColor: Colors.white,
                ),
                title: Text('${widget.name}'),
              ),
            ),
            // Expanded(
            //   child: StreamBuilder<QuerySnapshot>(
            //       stream: FirebaseFirestore.instance
            //           .collection('ChatRoom')
            //           .doc(widget.chatID)
            //           .collection('Messages')
            //           .orderBy('time', descending: true)
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
            //                   Color(0xffff6e01),
            //                 ),
            //               ),
            //             );
            //           default:
            //             return ListView(
            //               reverse: true,
            //               children: snapshot.data!.docs
            //                   .asMap()
            //                   .map((index, value) => MapEntry(
            //                         index,
            //                         value['sender'] == user!.uid
            //                             ? _buildReceiverText(value['message'])
            //                             : _buildSenderrText(
            //                                 value['message'],
            //                                 '${widget.image}',
            //                               ),
            //                       ))
            //                   .values
            //                   .toList(),
            //             );
            //         }
            //       }),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Type message...",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () async {
                      // if (messageController.text.isNotEmpty) {
                      //   FirebaseFirestore.instance
                      //       .collection("ChatRoom")
                      //       .doc(widget.chatID)
                      //       .collection('Messages')
                      //       .add({
                      //     'sender': user!.uid,
                      //     'message': messageController.text,
                      //     'time': DateTime.now(),
                      //   });
                      //   messageController.clear();
                      // }
                    },
                    icon: const Icon(Icons.send, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSenderrText(String text, String image) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: CircleAvatar(
              backgroundImage: NetworkImage(image),
              radius: 18,
              backgroundColor: Colors.white,
            ),
          ),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    // border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(15),
                    )),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 180,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(text),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildReceiverText(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                // border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(0),
                )),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 180,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(text),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 8)
        ],
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconCreation(Icons.insert_drive_file, 'Document'),
                      SizedBox(width: 40),
                      IconCreation(Icons.camera_alt, 'Camera'),
                      SizedBox(width: 40),
                      IconCreation(Icons.insert_photo, 'Gallery'),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconCreation(Icons.headset, 'Audio'),
                      SizedBox(width: 40),
                      IconCreation(Icons.location_pin, 'Location'),
                      SizedBox(width: 40),
                      IconCreation(Icons.person, 'Contact'),
                    ],
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Share Issue'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xffff6e01),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          // side: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  //confirmation sheet for octoboss
  Widget ConfimationSheetForOctoBoss(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('TIME'),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextField(
                            // readOnly: true,
                            decoration: InputDecoration(
                              hintText: '03:30PM',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(6),
                            ),
                          )),
                    ],
                  ),
                  //
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('DATE'),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextField(
                          // readOnly: true,
                          decoration: InputDecoration(
                            hintText: '12/21/2021',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(6),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PRICE'),
                          Container(
                            width: screenWidth * 0.35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: TextField(
                              // readOnly: true,
                              decoration: InputDecoration(
                                hintText: '10\$',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(6),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('DURATION'),
                          Container(
                            width: screenWidth * 0.35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: TextField(
                              // readOnly: true,
                              decoration: InputDecoration(
                                hintText: '3 hrs',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Container(
                  //       width: screenWidth * 0.3,
                  //       // decoration: BoxDecoration(
                  //       //   borderRadius: BorderRadius.circular(10),
                  //       //   border: Border.all(color: Colors.grey),
                  //       // ),
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           Navigator.of(context).pop();
                  //         },
                  //         child: Text('Submit'),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.check_circle,
                            size: 40,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.cancel,
                            size: 40,
                            color: Color(0xffff6e01),
                          )),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  IconCreation(IconData icon, String text) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xffff6e01),
            radius: 30,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
