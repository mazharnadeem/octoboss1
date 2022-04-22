import 'dart:convert';
import 'dart:io';
import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:octbs_ui/controller/ServicesResponse.dart';
import 'package:octbs_ui/controller/api/apiservices.dart';
import 'package:octbs_ui/controller/api/userDetails.dart';
import 'package:octbs_ui/screens/users/Customer/sign_up/customer_sign_up_screen.dart';
import 'package:octbs_ui/screens/users/Octoboss/octoboss_bottom_navigation_bar.dart';
import 'package:octbs_ui/screens/users/Octoboss/octoboss_membership_screen.dart';
import 'package:octbs_ui/screens/users/services_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  List selectedServices = [];
  DateTime dateTime = DateTime.now();
  TextEditingController AgeController = TextEditingController();
  _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      AgeController.text = DateFormat.yMd().format(dateTime);
    }
  }

  var country_code = '';
  var country_name = '';
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController countryController = TextEditingController();
  // CountryCode countryCode = CountryCode.fromDialCode('+1');
  String? selectedSpinnerItem;

  List date = [];
  Future? myFuture;
  final String uri = 'https://admin.octo-boss.com/API/Services.php';
  Future<ServicesResponse> getPostServiceApi() async {
    final response = await http.get(Uri.parse(uri));
    var data = jsonDecode(response.body.toString());

    setState(() {
      date = data['data'];
      var xx = {'product_name': 'Others'};
      date.add(xx);
    });

    if (response.statusCode == 201) {
      return ServicesResponse.fromJson(date);
    } else {
      return ServicesResponse.fromJson(date);
    }
  }

  @override
  void initState() {
    // _events = getPostServiceApi();
    myFuture = getPostServiceApi();
    super.initState();
  }

  final ImagePicker _Pickerr = ImagePicker();
  List<XFile>? _imageFileList = [];
  List<Asset> images = <Asset>[];
  List<Asset> image1 = <Asset>[];
  String _error = 'No Error Dectected';
  bool change = false;

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 5,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Container(
          child: Stack(overflow: Overflow.visible, children: [
            Positioned(
              child: AssetThumb(
                asset: asset,
                width: 150,
                height: 150,
              ),
            ),
            Positioned(
                top: 0,
                right: 2,
                left: 80,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        images.removeAt(index);
                      });
                      // clearimage();
                    },
                    icon: Icon(Icons.delete, color: Colors.grey.shade300))),
          ]),
        );
      }),
    );
  }

  Widget buildGridView1() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 5,
      children: List.generate(image1.length, (index) {
        Asset asset = image1[index];
        return Container(
          child: Stack(overflow: Overflow.visible, children: [
            Positioned(
              child: AssetThumb(
                asset: asset,
                width: 150,
                height: 150,
              ),
            ),
            Positioned(
                top: 0,
                right: 2,
                left: 80,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        image1.removeAt(index);
                      });
                    },
                    icon: Icon(Icons.delete, color: Colors.grey.shade300))),
          ]),
        );
      }),
    );
  }

  Future<void> loadAssets1() async {
    List<Asset> resultList1 = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList1 = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: image1,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      image1 = resultList1;
      _error = error;
    });
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  PickedFile? _imagefile;
  PickedFile? _imagefile1, imagefile2;
  final ImagePicker _picker = ImagePicker();

  String? problem;
  bool showPassword = false;

  final ImagePicker picker = ImagePicker();
  bool isEdit = false;
  late File? imageLink;
  String imageUrl = '';
  String name = '';
  String lname = '';
  String phone = '';
  String streetAddress = '';
  String postalCode = '';
  String country = '';
  String street_number = '';
  String street_name = '';
  String unit_number = '';
  String city = '';
  String job_info = '';
  String language = '';
  String tags_services = '';
  String job_title = '';
  String detailed_description_of_services = '';
  String add_certificate = '';
  String add_work_pic = '';
  String dob = '';
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController datebirth = TextEditingController();
  TextEditingController fullAddress = TextEditingController();
  TextEditingController emaill = TextEditingController();
  TextEditingController streetno = TextEditingController();
  TextEditingController streetname = TextEditingController();
  TextEditingController streetaddress = TextEditingController();
  TextEditingController unitno = TextEditingController();
  TextEditingController cityy = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  TextEditingController jobInfo = TextEditingController();
  TextEditingController tagservices = TextEditingController();
  TextEditingController jobtitle = TextEditingController();
  TextEditingController detaileddescription = TextEditingController();
  TextEditingController countryy = TextEditingController();
  TextEditingController postalCodee = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool selected = false;
    if (showPassword) {}

    // var json = JsonDecoder().convert(date.toString());
    // date = (json).map<ServicesResponse>((data) {
    //   ServicesResponse.fromJson(data);
    // }).toList();
    // selectedSpinnerItem = date[2].ProductName;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
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
                        print('Date ===$date');
                        Navigator.of(context).pop();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => OctoBossChatListScreen()));
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
              Center(
                child: GestureDetector(
                  onTap: isEdit == false
                      ? null
                      : () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => Bottomsheet()),
                          );
                        },
                  child: Container(
                      // color: Colors.black,
                      height: 130,
                      width: 150,
                      child: _imagefile == null
                          ? Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade300),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.grey,
                                    size: 50,
                                  )),
                            )
                          : CircleAvatar(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(102),
                                clipBehavior: Clip.hardEdge,
                                child: Image.file(
                                  File(_imagefile!.path),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                      decoration: BoxDecoration(
                          // shape: BoxShape.circle,

                          shape: BoxShape.circle)),
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
                        setState(() {
                          isEdit = !isEdit;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                // initialValue: ds['FirstName'],
                enabled: false,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                initialValue: user_details['data']['first_name'],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'First Name'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                // initialValue: ds['FirstName'],
                enabled: false,
                onChanged: (value) {
                  setState(() {
                    lname = value;
                  });
                },
                initialValue: user_details['data']['last_name'],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Last Name'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextField(
                focusNode: AlwaysDisabledFocusNode(),
                controller: AgeController,
                decoration: InputDecoration(hintText: 'Date of Birth'),
                onTap: () => _selectDate(),
              ),
              // TextFormField(
              //   // initialValue: ds['FirstName'],
              //   enabled: isEdit,
              //   onChanged: (value) {
              //     setState(() {
              //       dob = value;
              //     });
              //   },
              //   initialValue: user_details['data']['date_of_birth'],
              //   decoration: InputDecoration(
              //     contentPadding: EdgeInsets.only(bottom: 3),
              //     labelText: 'Date of Birth'.tr,
              //     floatingLabelBehavior: FloatingLabelBehavior.always,
              //   ),
              // ),
              SizedBox(height: 35),
              TextFormField(
                // initialValue: ds['FirstName'],
                enabled: isEdit,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                initialValue: user_details['data']['address'],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Full Address'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextFormField(
                // initialValue: ds['Email'],
                enabled: false,
                // enabled: isEdit,
                // onChanged: (value) {
                //   setState(() {
                //     name = value;
                //   });
                // },
                initialValue: user_details['data']['email'],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Email'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                // initialValue: ds['FirstName'],
                enabled: isEdit,
                onChanged: (value) {
                  setState(() {
                    street_number = value;
                  });
                },
                initialValue: user_details['data']['setreet_address'],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Street Number'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                // initialValue: ds['FirstName'],
                enabled: isEdit,
                onChanged: (value) {
                  setState(() {
                    street_name = value;
                  });
                },
                initialValue: 'jknew',
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Street Name'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                // initialValue: ds['Street Address'],
                enabled: isEdit,
                onChanged: (value) {
                  setState(() {
                    streetAddress = value;
                  });
                },
                initialValue: 'oiefsp',
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Street Address'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                // initialValue: ds['FirstName'],
                enabled: isEdit,
                onChanged: (value) {
                  setState(() {
                    unit_number = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Unit Number'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                // initialValue: ds['FirstName'],
                enabled: isEdit,
                onChanged: (value) {
                  setState(() {
                    city = value;
                  });
                },
                initialValue: user_details['data']['city'],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'City'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                controller: countryController,
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  prefixIcon: CountryListPick(
                    theme: CountryTheme(
                        labelColor: Colors.black,
                        alphabetTextColor: Colors.black,
                        alphabetSelectedTextColor: Colors.black,
                        alphabetSelectedBackgroundColor: Colors.black,
                        isShowFlag: true, //show flag on dropdown
                        isShowTitle: false, //show title on dropdown
                        isShowCode: true, //show code on dropdown
                        isDownIcon: true),
                    onChanged: (c) {
                      setState(() {
                        country_code = c.toString();
                      });
                    },

                    //show down icon on dropdown
                    // initialSelection:
                    //     '+92', //inital selection, +672 for Antarctica
                  ),
                  hintText: 'Phone Number',

                  // border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
              ),

              // TextFormField(
              //   // initialValue: ds['Phone Number'],
              //   enabled: isEdit,
              //   onChanged: (value) {
              //     setState(() {
              //       phone = value;
              //     });
              //   },
              //   initialValue: user_details['data']['phone'],
              //   decoration: InputDecoration(
              //     contentPadding: EdgeInsets.only(bottom: 3),
              //     labelText: 'Phone_number'.tr,
              //     floatingLabelBehavior: FloatingLabelBehavior.always,
              //   ),
              // ),
              SizedBox(height: 35),
              TextFormField(
                // initialValue: ds['FirstName'],
                enabled: isEdit,
                onChanged: (value) {
                  setState(() {
                    job_info = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Job Info'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                // initialValue: ds['FirstName'],
                enabled: isEdit,
                onChanged: (value) {
                  setState(() {
                    tags_services = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Tags of Services'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                // initialValue: ds['FirstName'],
                enabled: isEdit,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Job Title'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
                // initialValue: ds['FirstName'],
                enabled: isEdit,
                onChanged: (value) {
                  setState(() {
                    detailed_description_of_services = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Detailed Description'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              Container(
                alignment: Alignment.topLeft,
                child: CountryListPick(
                  theme: CountryTheme(
                      isShowFlag: true, //show flag on dropdown
                      isShowTitle: true, //show title on dropdown
                      isShowCode: false, //show code on dropdown
                      isDownIcon: true),
                  onChanged: (con) {
                    setState(() {
                      country_name = con.toString();
                    });
                  },
                  //show down icon on dropdown
                  // initialSelection:
                  //     '+672', //inital selection, +672 for Antarctica
                ),
              ),
              Divider(
                thickness: 2,
              ),

              // TextFormField(
              //   // initialValue: ds['Country'],
              //   enabled: isEdit,
              //   onChanged: (value) {
              //     setState(() {
              //       country = value;
              //     });
              //   },
              //   initialValue: 'Pakistan',
              //   decoration: InputDecoration(
              //     contentPadding: EdgeInsets.only(bottom: 3),
              //     labelText: 'Country'.tr,
              //     floatingLabelBehavior: FloatingLabelBehavior.always,
              //   ),
              // ),
              SizedBox(height: 35),
              TextFormField(
                // initialValue: ds['Postal Code'],
                enabled: isEdit,
                onChanged: (value) {
                  setState(() {
                    postalCode = value;
                  });
                },
                initialValue: user_details['data']['postal_code'],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Postal Code'.tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Add Certificates',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        loadAssets1();
                      },
                      icon: Icon(
                        Icons.file_upload_outlined,
                        color: Colors.grey,
                        size: 30,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  // color: Colors.black,
                  height: 130,
                  width: double.infinity,
                  child: SizedBox(height: 200, child: buildGridView1()),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade100,
                  )),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Add Work Pictures',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        loadAssets();
                      },
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.grey,
                        size: 30,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  // color: Colors.black,
                  height: 130,
                  width: double.infinity,
                  child: SizedBox(height: 200, child: buildGridView()),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade100,
                  )),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // use this button to open the multi-select dialog
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: TextButton(
                        child: const Text(
                          'Please choose a language',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        onPressed: _showMultiSelect,
                      ),
                    ),

                    // display selected items
                    Wrap(
                      children: _selectedItems
                          .map((e) => Chip(
                                label: Text(e),
                              ))
                          .toList(),
                    )
                  ],
                ),
              ),
              SizedBox(height: 35),
              Row(
                children: [
                  Text(
                    'Please Select Services',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(height: 15),
              Center(
                  child: FutureBuilder(
                      future: getPostServiceApi(),
                      builder: (context, snapshot) {
                        // if (!snapshot.hasData)
                        //   return Center(child: CircularProgressIndicator());

                        return Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              DropdownButton(
                                items: date.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item['product_name']),
                                    value: item['product_name'],
                                  );
                                }).toList(),
                                hint: Text(
                                  "Choose Services".tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                onChanged: (newVal) {
                                  setState(() {
                                    setState(() {
                                      selectedSpinnerItem = newVal.toString();
                                      selectedServices.add(selectedSpinnerItem);
                                    });

                                    if (selectedSpinnerItem == 'Others') {
                                      showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          context: context,
                                          builder: ((context) =>
                                              SingleChildScrollView(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom),
                                                  child: NameBottomSheet(),
                                                ),
                                              )));
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>))
                                    }
                                  });
                                },
                                value: selectedSpinnerItem,
                              ),
                              Wrap(
                                children: selectedServices
                                    .map((e) => Chip(
                                          label: Text(e),
                                        ))
                                    .toList(),
                              )
                            ]));
                      })),

              SizedBox(
                height: 35,
              ),
              Visibility(
                visible: isEdit,
                child: Center(
                  child: RaisedButton(
                    onPressed: () async {
                      // ApiServices().CreateSelectedServices(selectedServices);
                      ApiServices().octbossprofile(
                          firstname.text.toString(),
                          lastname.text.toString(),
                          datebirth.text.toString(),
                          fullAddress.text.toString(),
                          emaill.text.toString(),
                          streetname.text.toString(),
                          streetname.text.toString(),
                          streetaddress.text.toString(),
                          unitno.text.toString(),
                          cityy.text.toString(),
                          phoneno.text.toString(),
                          jobInfo.text.toString(),
                          tagservices.text.toString(),
                          jobtitle.text.toString(),
                          detaileddescription.text.toString(),
                          countryy.text.toString(),
                          postalCodee.text.toString(),
                          // selectedServices.toString()
                      );

                      Get.to(OctoBossMembershipScreen());
                    },
                    color: Color(0xffff6e01),
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Submit".tr,
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  List<String> _selectedItems = [];

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> _items = [
      "Afrikaans",
      "Afrikaans (South Africa)",
      "Arabic",
      "Arabic (U.A.E.)",
      "Arabic (Bahrain)",
      "Arabic (Algeria)",
      "Arabic (Egypt)",
      "Arabic (Iraq)",
      "Arabic (Jordan)",
      "Arabic (Kuwait)",
      "Arabic (Lebanon)",
      "Arabic (Libya)",
      "Arabic (Morocco)",
      "Arabic (Oman)",
      "Arabic (Qatar)",
      "Arabic (Saudi Arabia)",
      "Arabic (Syria)",
      "Arabic (Tunisia)",
      "Arabic (Yemen)",
      "Azeri (Latin)",
      "Azeri (Latin) (Azerbaijan)",
      "Azeri (Cyrillic) (Azerbaijan)",
      "Belarusian",
      "Belarusian (Belarus)",
      "Bulgarian",
      "Bulgarian (Bulgaria)",
      "Bosnian (Bosnia and Herzegovina)",
      "Catalan",
      "Catalan (Spain)",
      "Czech",
      "Czech (Czech Republic)",
      "Welsh",
      "Welsh (United Kingdom)",
      "Danish",
      "Danish (Denmark)",
      "German",
      "German (Austria)",
      "German (Switzerland)",
      "German (Germany)",
      "German (Liechtenstein)",
      "German (Luxembourg)",
      "Divehi",
      "Divehi (Maldives)",
      "Greek",
      "Greek (Greece)",
      "English",
      "English (Australia)",
      "English (Belize)",
      "English (Canada)",
      "English (Caribbean)",
      "English (United Kingdom)",
      "English (Ireland)",
      "English (Jamaica)",
      "English (New Zealand)",
      "English (Philippines)",
      "English (Trinidad and Tobago)",
      "English (United States)",
      "English (South Africa)",
      "English (Zimbabwe)",
      "Esperanto",
      "Spanish",
      "Spanish (Argentina)",
      "Spanish (Bolivia)",
      "Spanish (Chile)",
      "Spanish (Colombia)",
      "Spanish (Costa Rica)",
      "Spanish (Dominican Republic)",
      "Spanish (Ecuador)",
      "Spanish (Castilian)",
      "Spanish (Spain)",
      "Spanish (Guatemala)",
      "Spanish (Honduras)",
      "Spanish (Mexico)",
      "Spanish (Nicaragua)",
      "Spanish (Panama)",
      "Spanish (Peru)",
      "Spanish (Puerto Rico)",
      "Spanish (Paraguay)",
      "Spanish (El Salvador)",
      "Spanish (Uruguay)",
      "Spanish (Venezuela)",
      "Estonian",
      "Estonian (Estonia)",
      "Basque",
      "Basque (Spain)",
      "Farsi",
      "Farsi (Iran)",
      "Finnish",
      "Finnish (Finland)",
      "Faroese",
      "Faroese (Faroe Islands)",
      "French",
      "French (Belgium)",
      "French (Canada)",
      "French (Switzerland)",
      "French (France)",
      "French (Luxembourg)",
      "French (Principality of Monaco)",
      "Galician",
      "Galician (Spain)",
      "Gujarati",
      "Gujarati (India)",
      "Hebrew",
      "Hebrew (Israel)",
      "Hindi",
      "Hindi (India)",
      "Croatian",
      "Croatian ()",
      "Croatian (Croatia)",
      "Hungarian",
      "Hungarian (Hungary)",
      "Armenian",
      "Armenian (Armenia)",
      "Indonesian",
      "Indonesian (Indonesia)",
      "Icelandic",
      "Icelandic (Iceland)",
      "Italian",
      "Italian (Switzerland)",
      "Italian (Italy)",
      "Japanese",
      "Japanese (Japan)",
      "Georgian",
      "Georgian (Georgia)",
      "Kazakh",
      "Kazakh (Kazakhstan)",
      "Kannada",
      "Kannada (India)",
      "Korean",
      "Korean (Korea)",
      "Konkani",
      "Konkani (India)",
      "Kyrgyz",
      "Kyrgyz (Kyrgyzstan)",
      "Lithuanian",
      "Lithuanian (Lithuania)",
      "Latvian",
      "Latvian (Latvia)",
      "Maori",
      "Maori (New Zealand)",
      "FYRO Macedonian",
      "FYRO Macedonian (Macedonia)",
      "Mongolian",
      "Mongolian (Mongolia)",
      "Marathi",
      "Marathi (India)",
      "Malay",
      "Malay (Brunei Darussalam)",
      "Malay (Malaysia)",
      "Maltese",
      "Maltese (Malta)",
      "Norwegian (Bokm?l)",
      "Norwegian (Bokm?l) (Norway)",
      "Dutch",
      "Dutch (Belgium)",
      "Dutch (Netherlands)",
      "Norwegian (Nynorsk) (Norway)",
      "Northern Sotho",
      "Northern Sotho (South Africa)",
      "Punjabi",
      "Punjabi (India)",
      "Polish",
      "Polish (Poland)",
      "Pashto",
      "Pashto (Afghanistan)",
      "Portuguese",
      "Portuguese (Brazil)",
      "Portuguese (Portugal)",
      "Quechua",
      "Quechua (Bolivia)",
      "Quechua (Ecuador)",
      "Quechua (Peru)",
      "Romanian",
      "Romanian (Romania)",
      "Russian",
      "Russian (Russia)",
      "Sanskrit",
      "Sanskrit (India)",
      "Sami (Northern)",
      "Sami (Northern) (Finland)",
      "Sami (Skolt) (Finland)",
      "Sami (Inari) (Finland)",
      "Sami (Northern) (Norway)",
      "Sami (Lule) (Norway)",
      "Sami (Southern) (Norway)",
      "Sami (Northern) (Sweden)",
      "Sami (Lule) (Sweden)",
      "Sami (Southern) (Sweden)",
      "Slovak",
      "Slovak (Slovakia)",
      "Slovenian",
      "Slovenian (Slovenia)",
      "Albanian",
      "Albanian (Albania)",
      "Serbian (Latin) ()",
      "Serbian (Cyrillic) ()",
      "Serbian (Latin) ()",
      "Serbian (Cyrillic) ()",
      "Swedish",
      "Swedish (Finland)",
      "Swedish (Sweden)",
      "Swahili",
      "Swahili (Kenya)",
      "Syriac",
      "Syriac (Syria)",
      "Tamil",
      "Tamil (India)",
      "Telugu",
      "Telugu (India)",
      "Thai",
      "Thai (Thailand)",
      "Tagalog",
      "Tagalog (Philippines)",
      "Tswana",
      "Tswana (South Africa)",
      "Turkish",
      "Turkish (Turkey)",
      "Tatar",
      "Tatar (Russia)",
      "Tsonga",
      "Ukrainian",
      "Ukrainian (Ukraine)",
      "Urdu",
      "Urdu (Islamic Republic of Pakistan)",
      "Uzbek (Latin)",
      "Uzbek (Latin) (Uzbekistan)",
      "Uzbek (Cyrillic) (Uzbekistan)",
      "Vietnamese",
      "Vietnamese (Viet Nam)",
      "Xhosa",
      "Xhosa (South Africa)",
      "Chinese",
      "Chinese (S)",
      "Chinese (Hong Kong)",
      "Chinese (Macau)",
      "Chinese (Singapore)",
      "Chinese (T)",
      "Zulu",
      "Zulu (South Africa)"
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: _items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

  void takePhoto() async {
    final List<XFile>? imgpickfilelist = await _picker.pickMultiImage(
      imageQuality: 50, maxHeight: 60, maxWidth: 60,

      // source: source,
    );
    setState(() {
      _imagefile = imgpickfilelist as PickedFile?;
    });
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await _Pickerr.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      _imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + _imageFileList!.length.toString());
    setState(() {});
  }

  Widget Bottomsheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            "Chose profile photo",
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
                    takePhoto();
                  },
                  icon: Icon(Icons.camera),
                  label: Text("Camera ")),
              FlatButton.icon(
                  onPressed: () {
                    takePhoto();
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

class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Language'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: _cancel,
        ),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: _submit,
        ),
      ],
    );
  }
}
