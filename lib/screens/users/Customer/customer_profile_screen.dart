import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:octbs_ui/controller/api/apiservices.dart';
import 'package:octbs_ui/controller/api/userDetails.dart';

class CustomerProfileScreen extends StatefulWidget {
  @override
  _CustomerProfileScreenState createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  bool showPassword = false;
  // User? user = FirebaseAuth.instance.currentUser;
  final ImagePicker picker = ImagePicker();
  bool isEdit = false;
  File? imageLink;
  String imageUrl = '';
  String name = '';
  String phone = '';
  String streetAddress = '';
  String postalCode = '';
  String country = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController CountryController = TextEditingController();
  TextEditingController PostalCodeController = TextEditingController();


  Future<void> uploadImage() async{

    var stream= await http.ByteStream(imageLink!.openRead());
    stream.cast();
    var length=await imageLink!.length();
    var uri=Uri.parse('https://admin.octo-boss.com/API/AddCustomerProfile.php');
    var request=http.MultipartRequest('POST',uri);
    request.fields['title']='Mazhar Nadeem';
    var  multiport=http.MultipartFile('picture',stream,length);
    request.files.add(multiport);
    var response=await request.send();
    if(response.statusCode==201){
      print('Image Upload Successfully');
      Fluttertoast.showToast(msg: 'Image Upload Successfully');
    }
    else{
      Fluttertoast.showToast(msg: 'Image Upload Failed');
      print('Image Upload Failed');
    }

  }



  Future<void> uploadImage2() async {
    //show your own loading or progressing code here

    String uploadurl = "https://admin.octo-boss.com/API/AddCustomerProfile.php";
    var uri=Uri.parse(uploadurl);
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    try{
      List<int> imageBytes = imageLink!.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      //convert file image to Base64 encoding
      var response = await http.post(
          uri,
          body: {
            'picture': baseimage,
          }
      );
      if(response.statusCode == 200){
        var jsondata = json.decode(response.body); //decode json data
        if(jsondata["error"]){ //check error sent from server
          print(jsondata["msg"]);
          //if error return from server, show message from server
        }else{
          print("Upload successful");
        }
      }else{
        print("Error during connection to server");
        //there is error during connecting to server,
        //status code might be 404 = url not found
      }
    }catch(e){
      print("Error during converting to Base64");
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: ListView(
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
                ],
              ),
              SizedBox(height: 15),
              Center(
                child: GestureDetector(
                  onTap: isEdit == false
                      ? null
                      : () {
                          showImagePicker(context);
                        },
                  child: imageLink==null?Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(''),
                      ),
                    ),
                  ):Container(
                    width: 130,
                    height: 130,
                    clipBehavior: Clip.antiAlias,
                    child: Image.file(File(imageLink!.path).absolute,fit: BoxFit.cover,),
                    decoration: BoxDecoration(
                      // color: Colors.orange,
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(''),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35),
              Visibility(
                visible: isEdit ? false : true,
                child: Row(
                  children: [
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Fluttertoast.showToast(msg: '${user!.uid}');
                        setState(() {
                          isEdit = !isEdit;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Center(
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                enabled: isEdit,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                initialValue: user_details['data']['full_name'],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Name'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                enabled: false,
                initialValue: user_details['data']['email'],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Email'.tr,

                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                enabled: isEdit,
                onChanged: (value) {
                  setState(() {
                    phone = value;
                  });
                },
                initialValue: user_details['data']['phone'],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Phone Number'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                enabled: isEdit,
                initialValue: user_details['data']['address'],
                onChanged: (value) {
                  setState(() {
                    streetAddress = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Street Address'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                enabled: isEdit,
                initialValue: user_details['data']['country'],
                onChanged: (value) {
                  setState(() {
                    country = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Country'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                enabled: isEdit,
                initialValue: user_details['data']['postal_code'],
                onChanged: (value) {
                  setState(() {
                    postalCode = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Postal Code'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              Visibility(
                visible: isEdit,
                child: Center(
                  child: RaisedButton(
                    onPressed: () async {
                      uploadImage();
                      // ApiServices().custmrprofile(
                      //     nameController.text.toString(),
                      //     emailController.text.toString(),
                      //     phoneController.text.toString(),
                      //     streetAddressController.text.toString(),
                      //     CountryController.text.toString(),
                      //     PostalCodeController.text.toString());
                    },
                    color: Color(0xffff6e01),
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Save".tr,
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void showImagePicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: Text(
                      'Photo library',
                      // 'Гэрэл зургийн номын сан'
                    ),
                    onTap: () {
                      getImageGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: Text(
                    'Camera',
                    // 'Камер'
                  ),
                  onTap: () {
                    getImageCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  void getImageGallery() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      imageLink = File(image!.path);
    });
  }

  void getImageCamera() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    setState(() {
      imageLink = File(image!.path);
    });
  }
}
