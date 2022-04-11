import 'dart:convert';

import 'package:octbs_ui/controller/api/userDetails.dart';
import 'package:octbs_ui/screens/users/Customer/customer_issue_list_screen_api.dart';
import 'package:octbs_ui/screens/users/Customer/customer_signin_screen.dart';
import 'package:octbs_ui/screens/users/Customer/sign_up/customer_sign_up_screen.dart';
import 'package:octbs_ui/screens/users/Octoboss/octoboss_services_offered_screen_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

var user_id=''.obs;
class ApiServices {
  var createIssueApi = "https://admin.octo-boss.com/API/CreateIssues.php";
  var verify_code='https://admin.noqta-market.com/new/API/VerifyUser.php';
  var register='https://admin.noqta-market.com/new/API/Signup.php';
  var ddd;





  // createissue(String location, String description, String status, String language,String public_issue,var image) async {
  //   var issuedata = {
  //     'title': location,
  //     'description': description,
  //     'status': status,
  //     'languages': language,
  //     'created_by': '2',
  //     'issue_type':public_issue
  //   };
  //
  //
  //   var stream= await http.ByteStream(image!.openRead());
  //   stream.cast();
  //   var length=await image!.length();
  //   var uri=Uri.parse(createIssueApi);
  //   var request=http.MultipartRequest('POST',uri);
  //
  //   request.fields['title']='Mazhar Nadeem';
  //   var  multiport=http.MultipartFile('image',stream,length);
  //   request.files.add(multiport);
  //
  //
  //   var issue_encode = json.encode(issuedata);
  //   final response = await post(uri, body: issue_encode);
  //
  //   if (response.statusCode == 201) {
  //     var issue_response = jsonDecode(response.body.toString());
  //     // Get.snackbar('Message', '${issue_response['message'].toString()}');
  //     Fluttertoast.showToast(msg: '${issue_response['message'].toString()}');
  //
  //     var image_response=await request.send();
  //     if(image_response.statusCode==201){
  //       print('Image Upload Successfully');
  //       Fluttertoast.showToast(msg: 'Image Upload Successfully');
  //     }
  //     else{
  //       Fluttertoast.showToast(msg: 'Image Upload Failed');
  //       print('Image Upload Failed');
  //     }
  //     // print(issue_response['message']);
  //   } else {
  //     var issue_response = jsonDecode(response.body.toString());
  //     Fluttertoast.showToast(msg: '${issue_response['message'].toString()}');
  //     // Get.snackbar('Message', '${issue_response['message'].toString()}');
  //     // print(issue_response);
  //   }
  // }


  createissue(String location, String description, String status, String language,String public_issue,var image) async {

    var uri=Uri.parse(createIssueApi);
    List<int> imageBytes = image!.readAsBytesSync();
    String baseimage = base64Encode(imageBytes);
    var issuedata = {
      'title': location,
      'description': description,
      'status': status,
      'languages': language,
      'created_by': user_details['data']['id'],
      'issue_type':public_issue,
      'image': baseimage
    };

    var issue_encode = json.encode(issuedata);
    final response = await post(uri, body: issue_encode);

    if (response.statusCode == 201) {
      var issue_response = jsonDecode(response.body.toString());
      // Get.snackbar('Message', '${issue_response['message'].toString()}');
      Fluttertoast.showToast(msg: '${issue_response['message'].toString()}');
      // print(issue_response['message']);
    } else {
      var issue_response = jsonDecode(response.body.toString());
      Fluttertoast.showToast(msg: '${issue_response['message'].toString()}');
      // Get.snackbar('Message', '${issue_response['message'].toString()}');
      // print(issue_response);
    }
  }

  Future<bool> customer_register(String firstname ,String lastname ,String date_of_birth ,String address ,String appartment_no ,String email ,String password ,String phone ,String street_address ,String country ,String postal_code ,String city ,String age  ,String type) async{
    // This is for testing api email and Password.
    // "email": "eve.holt@reqres.in",
    // "password": "pistol"

    try{
      var data={'first_name':firstname,'last_name':lastname,'email':email,'password':password,'phone':phone,'address':address,'country':country,'date_of_birth':date_of_birth,'appartment_no':appartment_no,'street_address':street_address,'city':city,'age':age,'postal_code':postal_code,'type':type};

      var data1=json.encode(data);
      var response=await post(Uri.parse(register),
          // headers: <String, String>{
          //   'Content-Type': 'application/json; charset=UTF-8',
          // },
          // headers: <String, String>{
          //   'Content-Type': 'application/json',
          // },
          body: data1

      );
      if(response.statusCode==201){

        print('Register code : 201');
        var data2=jsonDecode(response.body.toString());

        user_id.value=data2['user_id'].toString();
        Fluttertoast.showToast(msg: '${data2['message'].toString()}');
        // Fluttertoast.showToast(msg: 'Success');
        print(data);
        return true;
      }
      else if(response.statusCode==200){
        print('Register code : 200');
        var data2=jsonDecode(response.body.toString());
        Fluttertoast.showToast(msg: '${data2['message'].toString()}');
        print(data);
        return false;
      }
      else{
        print('Failed');
        print('Register code : else');
        var data2=jsonDecode(response.body.toString());
        Fluttertoast.showToast(msg: '${data2['message'].toString()}');
        // Fluttertoast.showToast(msg: 'Failed');
        // Get.showSnackbar(data2);
        print(data);
        return false;
      }

    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }

  }

  Future<bool> octoboss_register(String firstname ,String lastname ,String email ,String password ,String phone,String age,String address,String country,String date_of_birth, String postal_code,String type) async{
    // This is for testing api email and Password.
    // "email": "eve.holt@reqres.in",
    // "password": "pistol"

    try{
      var data={'first_name':firstname,'last_name':lastname,'email':email,'password':password,'phone':phone,'age':age,'address':address,'country':country,'date_of_birth':date_of_birth,'postal_code':postal_code,'type':type,'age':age};

      var data1=json.encode(data);
      var response=await post(Uri.parse(register),
          // headers: <String, String>{
          //   'Content-Type': 'application/json; charset=UTF-8',
          // },
          // headers: <String, String>{
          //   'Content-Type': 'application/json',
          // },
          body: data1

      );
      if(response.statusCode==201){

        print('Register code : 201');
        var data2=jsonDecode(response.body.toString());

        user_id.value=data2['user_id'].toString();
        Fluttertoast.showToast(msg: '${data2['message'].toString()}');
        // Fluttertoast.showToast(msg: 'Success');
        print(data);
        return true;
      }
      else if(response.statusCode==200){
        print('Register code : 200');
        var data2=jsonDecode(response.body.toString());
        Fluttertoast.showToast(msg: '${data2['message'].toString()}');
        print(data);
        return false;
      }
      else{
        print('Failed');
        print('Register code : else');
        var data2=jsonDecode(response.body.toString());
        Fluttertoast.showToast(msg: '${data2['message'].toString()}');
        // Fluttertoast.showToast(msg: 'Failed');
        // Get.showSnackbar(data2);
        print(data);
        return false;
      }

    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }

  }


  verifyCode(String id,String code) async{
    // This is for testing api email and Password.
    // "email": "eve.holt@reqres.in",
    // "password": "pistol"

    try{
      var data={'user_id': id,'verification_code':code};
      var data1=json.encode(data);
      var response=await post(Uri.parse(verify_code),
          // headers: <String, String>{
          //   'Content-Type': 'application/json; charset=UTF-8',
          // },
          // headers: <String, String>{
          //   'Content-Type': 'application/json',
          // },
          body: data1

      );
      if(response.statusCode==201){

        print('Verify Code : 201');
        var data2=jsonDecode(response.body.toString());
        Fluttertoast.showToast(msg: 'Verified');
        Get.offAll(CustomerSignInScreen());
        // Fluttertoast.showToast(msg: 'Success');
        print(data);
        return true;
      }
      else{
        print('Failed');
        print('Verify Code : else');
        var data2=jsonDecode(response.body.toString());
        Fluttertoast.showToast(msg: '${data2['message'].toString()}');
        // Fluttertoast.showToast(msg: 'Failed');
        // Get.showSnackbar(data2);
        print(data);
        return false;
      }

    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }

  }

  var customerprofile =
      "https://admin.octo-boss.com/API/AddCustomerProfile.php";

  custmrprofile(
      String name,
      String email,
      String phonenumber,
      String streetAddress,
      String country,
      String postalCode,
      ) async {
    var issuedata = {
      'name': name,
      'email': email,
      'phone_number': phonenumber,
      'street_address': streetAddress,
      'country': country,
      'postal_code': postalCode
    };
    var issue_encode = json.encode(issuedata);
    final response = await post(Uri.parse(customerprofile), body: issue_encode);

    if (response.statusCode == 200) {
      var issue_response = jsonDecode(response.body.toString());
      Get.snackbar('Message', '${issue_response['message'].toString()}');
      // Fluttertoast.showToast(msg: '${issue_response['message'].toString()}');
      print(issue_response['message']);
    } else {
      var issue_response = jsonDecode(response.body.toString());
      Get.snackbar('Message', '${issue_response['message'].toString()}');
      print(issue_response);
    }
  }

  //apioctobossprofile
  var octobossprofile =
      "https://admin.octo-boss.com/API/AddOctobossProfile.php";

  octbossprofile(
      String fname,
      String lname,
      String dob,
      String fullAddress,
      String email,
      String streetnumber,
      String streetname,
      String streetAddress,
      String unitNumber,
      String city,
      String phoneNumber,
      String jobInfo,
      String tagsServices,
      String jobTitle,
      String detailedDescription,
      String country,
      String postalCode,
      ) async {
    var issuedata = {
      'first_name': fname,
      'last_name': lname,
      'date_of_birth': dob,
      'full_address': fullAddress,
      'email': email,
      'street_no': streetnumber,
      'street_name': streetname,
      'street_address': streetAddress,
      'unit_number': unitNumber,
      'city': city,
      'phone_number': phoneNumber,
      'job_info': jobInfo,
      'tag_of_services': tagsServices,
      'job_title': jobTitle,
      'detail_description': detailedDescription,
      'country': country,
      'email': email,
      'postal_code': postalCode
    };
    var issue_encode = json.encode(issuedata);
    final response = await post(Uri.parse(octobossprofile), body: issue_encode);

    if (response.statusCode == 200) {
      var issue_response = jsonDecode(response.body.toString());
      Get.snackbar('Message', '${issue_response['message'].toString()}');
      // Fluttertoast.showToast(msg: '${issue_response['message'].toString()}');
      print(issue_response['message']);
    } else {
      var issue_response = jsonDecode(response.body.toString());
      Get.snackbar('Message', '${issue_response['message'].toString()}');
      print(issue_response);
    }
  }

  Future<void> uploadImage(var image) async{

    var stream= await http.ByteStream(image!.openRead());
    stream.cast();


    var length=await image!.length();
    var uri=Uri.parse(createIssueApi);
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



}
