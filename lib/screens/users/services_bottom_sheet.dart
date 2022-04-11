import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NameBottomSheet extends StatefulWidget {
  @override
  _NameBottomSheetState createState() => _NameBottomSheetState();
}

class _NameBottomSheetState extends State<NameBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? serviceName;
  // User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: TextFormField(
              autofocus: true,
              keyboardType: TextInputType.name,
              cursorColor: Color(0xffff6e01),
              onSaved: (input) => serviceName = input,
              decoration: InputDecoration(
                icon: FaIcon(
                  FontAwesomeIcons.wrench,
                  color: Color(0xffff6e01),
                ),
                labelText: 'Service Name',
                labelStyle: TextStyle(color: Color(0xffff6e01)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffff6e01)),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Color(0xffff6e01)),
                ),
              ),
              TextButton(
                onPressed: AddService,
                child: Text(
                  "Add Service",
                  style: TextStyle(color: Color(0xffff6e01)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> AddService() async {
    final formState = _formKey.currentState;

    if (formState!.validate()) {
      formState.save();
      try {
        // FirebaseFirestore.instance.collection("My Services").doc().set({
        //   'UID': user!.uid,
        //   'service': serviceName,
        // });

        Navigator.pop(context);
      } catch (e) {}
    }
  }
}
