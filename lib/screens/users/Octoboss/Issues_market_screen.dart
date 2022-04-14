import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:octbs_ui/controller/api/userDetails.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;



class issueList {
  int? response;
  int? code;
  List<Data>? data;

  issueList({this.response, this.code, this.data});

  issueList.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? description;
  String? status;
  String? image;
  String? languages;
  String? createdBy;
  String? createdAt;
  List<History>? history;

  Data(
      {this.id,
        this.title,
        this.description,
        this.status,
        this.image,
        this.languages,
        this.createdBy,
        this.createdAt,
        this.history});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    image = json['image'];
    languages = json['languages'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(new History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['image'] = this.image;
    data['languages'] = this.languages;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  String? id;
  String? issueId;
  String? status;
  String? userId;
  String? date;

  History({this.id, this.issueId, this.status, this.userId, this.date});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    issueId = json['issue_id'];
    status = json['status'];
    userId = json['user_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['issue_id'] = this.issueId;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['date'] = this.date;
    return data;
  }
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;
  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class IssuesMarket extends StatefulWidget {
  const IssuesMarket({Key? key}) : super(key: key);

  @override
  _IssuesMarketState createState() => _IssuesMarketState();
}

class _IssuesMarketState extends State<IssuesMarket> {

  final _debouncer = Debouncer();
  var searching=0;
  var dummy=[];

  Future<issueList> getIssuesApi() async {

    final response = await http.get(
        Uri.parse("https://admin.noqta-market.com/new/API/IssuesList.php"));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 201) {

      issue_details=data['data'];
      var x=user_details['data']['id'];


      var len=data['data'].length-1;
      // print('Length of data : $len');
      var y;
      var ind=0;
      var ls=[];

      abc.clear();
      // sorted_list.clear();
      // sorted_list=
      // var als;
      // var abc=[];
      // data['data'].contains('');
      // var data4= data.where((data) => (data['created_by'].contains(73.toString())));

      // print('Data Value is\n ${data['data'][10]['created_by']}');
      // print('Mazhar Data\n${data['data'].length}');
      for(int i=0;len>=i;i++){
        // language=data['data'][i]['issue_type'];
        // print('Mazhar');
        // als=data['data'][i]['languages'];
        // print('\nL value is $i : $als\n');
        // print('Nadeem');
        // language.addAll(x);
        // print('Arshad');
        // language.addAll(data['data'][i]['languages']);
        // print('I value is :$i');
        if(data['data'][i]['issue_type'].toString().toLowerCase()=='public')
          // var w=jsonDecode(data['data'][0]);
            {
          if (i <= len) {
              y = data['data'][i];
              abc.add(y);
              // sorted_issue=sorted_issue.addAll(y);
              // print('\nData Runtype ${y.runtimeType}');
              // ls[ind]=y;
              // sorted_issue.push(y);
              // print('Mazhar sorted');

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
      // abc=abc.cast<Map<String, dynamic>>();
      // abc=abc.map((json) => (json)).toList();

      if(searching==0){
        sorted_list=abc;
      //   print('mazhar');
      }
      if(searching==1){
        sorted_list=dummy;
      }
      //   sorted_list=sorted_list;

      print('nadeem');

      // print('Sorted List :\n $sorted_list');
      // print('Language Length: ${language.length}\nLanguage Value: ${language}');
      // print('Abc Testing :  ${abc[1]['title']}');
      // print('\nPakistan : ${y}\n');
      // }
      // print('Sorted List \n $sorted_issue');
      return issueList.fromJson(data);
    } else {
      return issueList.fromJson(data);
    }
  }

  String? query;

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          Navigator.pop(context);
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
                      'issues_market',
                      style: TextStyle(
                        fontSize: fontSize * 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  cursorColor: Color(0xffff6e01),
                  onChanged: (val) {
                    // setState(() {
                    //   query = val.toLowerCase();
                    // });

                    // _debouncer.run(() {
                      sorted_list =abc.where(
                            (u) => (u['languages'].toString().toLowerCase().contains(
                          val.toLowerCase(),
                        )),
                      ).toList();
                      dummy=sorted_list;
                      setState(() {
                        searching=1;
                      });
                    // });

                  },




                  // onEditingComplete: (){
                  //   setState(() {
                  //     sorted_list;
                  //   });
                  // },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xffff6e01),
                    ),
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: 'Search by Language',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffff6e01)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                  future: getIssuesApi(),
                    builder:(context, AsyncSnapshot snapshot) {

                    if(snapshot.data!=null){
                          return ListView.builder(
                          itemCount: sorted_list.length,
                          itemBuilder: (context, index) {
                            if(snapshot.hasData){
                              return Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: AssetImage(
                                                  'assets/images/home_logo_new.jpg',
                                                ),
                                                radius: 30,
                                                backgroundColor: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Problem',
                                                  style: TextStyle(
                                                    fontSize: fontSize * 18,
                                                    color: Color(0xffff6e01),
                                                  ),
                                                ),
                                                Text(
                                                  sorted_list[index]['description'],
                                                  style: TextStyle(
                                                    fontSize: fontSize * 15,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  sorted_list[index]['languages'],
                                                  style: TextStyle(
                                                    fontSize: fontSize * 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                            else{
                            return CircularProgressIndicator();
                            }
                          });
                    }
                      else{
                      return Center(child: CircularProgressIndicator());
                      }

                    },
                ),
              ),

              // Expanded(
              //   child: StreamBuilder<QuerySnapshot>(
              //       stream: (query != '' && query != null)
              //           ? FirebaseFirestore.instance
              //               .collection('Issues')
              //               .where("searchIndex", arrayContains: query)
              //               .snapshots()
              //           : FirebaseFirestore.instance
              //               .collection('Issues')
              //               .snapshots(),
              //       // stream: (query == null || query!.trim() == '')
              //       //     ? FirebaseFirestore.instance
              //       //         .collection('Issues')
              //       //         .orderBy('time', descending: true)
              //       //         .snapshots()
              //       //     : FirebaseFirestore.instance
              //       //         .collection('Issues')
              //       //         .orderBy('time', descending: true)
              //       //         .where('searchIndex', arrayContains: query)
              //       //         .snapshots(),
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
              //             return ListView.builder(
              //               itemCount: snapshot.data!.docs.length,
              //               itemBuilder: (context, index) {
              //                 // DocumentSnapshot data =
              //                     snapshot.data!.docs[index];
              //                 return GestureDetector(
              //                   onTap: () {

              //                   },
              //                   child: Card(
              //                       child: Column(
              //                     children: [
              //                       Row(
              //                         children: [
              //                           Padding(
              //                             padding: const EdgeInsets.all(8.0),
              //                             child: Column(
              //                               children: [
              //                                 CircleAvatar(
              //                                   backgroundImage:
              //                                       NetworkImage(data['Image']),
              //                                   radius: 30,
              //                                   backgroundColor: Colors.white,
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                           Flexible(
              //                             child: Padding(
              //                               padding: const EdgeInsets.all(8.0),
              //                               child: Column(
              //                                 crossAxisAlignment:
              //                                     CrossAxisAlignment.start,
              //                                 children: [
              //                                   Text(
              //                                     data['Problem'],
              //                                     style: TextStyle(
              //                                       fontSize: fontSize * 18,
              //                                       color: Color(0xffff6e01),
              //                                     ),
              //                                   ),
              //                                   Text(
              //                                     data['Description'],
              //                                     style: TextStyle(
              //                                       fontSize: fontSize * 15,
              //                                     ),
              //                                     overflow:
              //                                         TextOverflow.ellipsis,
              //                                   ),
              //                                   Text(
              //                                     data['Language'].toString(),
              //                                     style: TextStyle(
              //                                       fontSize: fontSize * 15,
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                     ],
              //                   )

              //                       ),
              //                 );
              //               },

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

// class LanguageDropDown extends StatefulWidget {
//   const LanguageDropDown({Key? key}) : super(key: key);
//
//   @override
//   _LanguageDropDownState createState() => _LanguageDropDownState();
// }
//
// class _LanguageDropDownState extends State<LanguageDropDown> {
//   List<String> _locations = [
//     'English',
//     'Arabic',
//     'Italian',
//     'Turkish',
//     'Urdo',
//     'more',
//   ]; // Option 2
//   String? _selectedLocation; // Option 2
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: DropdownButton(
//         hint: Text('Filter by Language'), // Not necessary for Option 1
//         value: _selectedLocation,
//         onChanged: (newValue) {
//           setState(() {
//             _selectedLocation = newValue as String?;
//           });
//         },
//         items: _locations.map((location) {
//           return DropdownMenuItem(
//             child: new Text(location),
//             value: location,
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// class LocationDropDown extends StatefulWidget {
//   const LocationDropDown({Key? key}) : super(key: key);
//
//   @override
//   _LocationDropDownState createState() => _LocationDropDownState();
// }
//
// class _LocationDropDownState extends State<LocationDropDown> {
//   List<String> _locations = [
//     'United States',
//     'Italy',
//     'Saudi Arabia',
//     'Iran',
//     'UAE',
//     'Pakistan',
//     'Turkey',
//     'Canada',
//   ]; // Option 2
//   String? _selectedLocation; // Option 2
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: DropdownButton(
//         hint: Text('Filter by Location'), // Not necessary for Option 1
//         value: _selectedLocation,
//         onChanged: (newValue) {
//           setState(() {
//             _selectedLocation = newValue as String?;
//           });
//         },
//         items: _locations.map((location) {
//           return DropdownMenuItem(
//             child: new Text(location),
//             value: location,
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
