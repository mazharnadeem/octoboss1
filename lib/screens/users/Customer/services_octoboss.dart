
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';






class ServicesOctoboss extends StatelessWidget {
  const ServicesOctoboss({Key? key}) : super(key: key);




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
                      //Do something with the user input.
                    },
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
                      onPressed: () {},
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
                  'Result offering Benifits',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.attach_file_rounded,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Card(
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
                              'https://image.shutterstock.com/image-photo/businessman-pressing-button-on-touch-260nw-350999087.jpg'),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Qailah jahan',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                        Text('Home Repair', style: TextStyle()),
                        Text('10 years experience over call',
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
          )
        ],
      )),
    );
  }
}
