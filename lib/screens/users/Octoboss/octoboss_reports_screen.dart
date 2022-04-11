import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class OctobossReportsScreen extends StatelessWidget {
  const OctobossReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Future<List<DocumentSnapshot>> getData() async {
    //   var firestore = FirebaseFirestore.instance;
    //   QuerySnapshot qn = await firestore
    //       .collection("Reports")
    //       .where("Rating", isEqualTo: "4.5")
    //       .get();
    //   return qn.docs;
    // }

    // User? user = FirebaseAuth.instance.currentUser;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              //
              Card(
                child: SizedBox(
                    height: screenHeight * 0.08,
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      'Here is how you are doing',
                      style: TextStyle(
                        fontSize: fontSize * 20,
                      ),
                    ))),
              ),
              SizedBox(height: 20),
              // Expanded(
              //   child: FutureBuilder<QuerySnapshot>(
              //     future:
              //         FirebaseFirestore.instance.collection('Reports').get(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         final List<DocumentSnapshot> documents =
              //             snapshot.data!.docs;
              //         return ListView(
              //             children: documents
              //                 .map((doc) => Card(
              //                         child: Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Column(
              //                         children: [
              //                           SizedBox(
              //                             height: 10,
              //                           ),
              //                           Row(
              //                             children: [
              //                               Text(
              //                                 'Rating: ',
              //                                 style: TextStyle(
              //                                     fontWeight: FontWeight.bold),
              //                               ),
              //                               Text(doc['Rating']),
              //                             ],
              //                           ),
              //                           SizedBox(
              //                             height: 10,
              //                           ),
              //                           Row(
              //                             children: [
              //                               Text(
              //                                 'Scheduled Jobs: ',
              //                                 style: TextStyle(
              //                                     fontWeight: FontWeight.bold),
              //                               ),
              //                               Text(doc['Scheduled Jobs']),
              //                             ],
              //                           ),
              //                           SizedBox(
              //                             height: 10,
              //                           ),
              //                           Row(
              //                             children: [
              //                               Text(
              //                                 'Total Amount: ',
              //                                 style: TextStyle(
              //                                     fontWeight: FontWeight.bold),
              //                               ),
              //                               Text(doc['Total Amount']),
              //                             ],
              //                           ),
              //                           SizedBox(
              //                             height: 10,
              //                           ),
              //                           Row(
              //                             children: [
              //                               Text(
              //                                 'Total Jobs: ',
              //                                 style: TextStyle(
              //                                     fontWeight: FontWeight.bold),
              //                               ),
              //                               Text(doc['Total Jobs']),
              //                             ],
              //                           ),
              //                           SizedBox(
              //                             height: 10,
              //                           ),
              //                         ],
              //                       ),
              //                     )

              //                         ))
              //                 .toList());
              //       } else if (snapshot.hasError) {
              //         return Text('It\'s Error!');
              //       }
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     },
              //   ),

              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  InfoWidget({Key? key, required this.title, required this.details})
      : super(key: key);

  String title, details;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final fontSize = MediaQuery.of(context).textScaleFactor;
    return Card(
      child: SizedBox(
          height: screenHeight * 0.1,
          width: double.infinity,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize * 20,
                  ),
                ),
              ),
              Text(
                details,
                style: TextStyle(
                  fontSize: fontSize * 20,
                ),
              ),
            ],
          ))),
    );
  }
}

//dropdwon widget
class MonthsDropDown extends StatefulWidget {
  const MonthsDropDown({Key? key}) : super(key: key);

  @override
  _MonthsDropDownState createState() => _MonthsDropDownState();
}

class _MonthsDropDownState extends State<MonthsDropDown> {
  List<String> _locations = [
    'January',
    'Feburary',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ]; // Option 2
  String? _selectedLocation; // Option 2
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton(
        hint: Text('Filter by month'), // Not necessary for Option 1
        value: _selectedLocation,
        onChanged: (newValue) {
          setState(() {
            _selectedLocation = newValue as String?;
          });
        },
        items: _locations.map((location) {
          return DropdownMenuItem(
            child: new Text(location),
            value: location,
          );
        }).toList(),
      ),
    );
  }
}
