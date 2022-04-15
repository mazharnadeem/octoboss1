// // To parse this JSON data, do
// //
// //     final octobossmodel = octobossmodelFromJson(jsonString);
//
// import 'dart:convert';
//
// Octobossmodel octobossmodelFromJson(String str) => Octobossmodel.fromJson(json.decode(str));
//
// String octobossmodelToJson(Octobossmodel data) => json.encode(data.toJson());
//
// class Octobossmodel {
//   Octobossmodel({
//     required this.response,
//     required this.data,
//   });
//
//   int response;
//   Data data;
//
//   factory Octobossmodel.fromJson(Map<String, dynamic> json) => Octobossmodel(
//     response: json["response"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "response": response,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     required this.allOctoboss,
//     required this.activeOctoboss,
//     required this.inactiveOctoboss,
//     required this.blockedOctoboss,
//   });
//
//   List<Octoboss> allOctoboss;
//   List<Octoboss> activeOctoboss;
//   List<dynamic> inactiveOctoboss;
//   List<dynamic> blockedOctoboss;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     allOctoboss: List<Octoboss>.from(json["all_octoboss"].map((x) => Octoboss.fromJson(x))),
//     activeOctoboss: List<Octoboss>.from(json["active_octoboss"].map((x) => Octoboss.fromJson(x))),
//     inactiveOctoboss: List<dynamic>.from(json["inactive_octoboss"].map((x) => x)),
//     blockedOctoboss: List<dynamic>.from(json["blocked_octoboss"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "all_octoboss": List<dynamic>.from(allOctoboss.map((x) => x.toJson())),
//     "active_octoboss": List<dynamic>.from(activeOctoboss.map((x) => x.toJson())),
//     "inactive_octoboss": List<dynamic>.from(inactiveOctoboss.map((x) => x)),
//     "blocked_octoboss": List<dynamic>.from(blockedOctoboss.map((x) => x)),
//   };
// }
//
// class Octoboss {
//   Octoboss({
//     required this.id,
//     required this.fullName,
//     required this.isFav,
//     required this.email,
//     required this.phone,
//     required this.address,
//     required this.country,
//     required this.postalCode,
//   });
//
//   String id;
//   String fullName;
//   String isFav;
//   String email;
//   String phone;
//   String address;
//   String country;
//   String postalCode;
//
//   factory Octoboss.fromJson(Map<String, dynamic> json) => Octoboss(
//     id: json["id"],
//     fullName: json["full_name"],
//     isFav: json["is_fav"],
//     email: json["email"],
//     phone: json["phone"],
//     address: json["address"],
//     country: json["country"] == null ? null : json["country"],
//     postalCode: json["postal_code"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "full_name": fullName,
//     "is_fav": isFav,
//     "email": email,
//     "phone": phone,
//     "address": address,
//     "country": country == null ? null : country,
//     "postal_code": postalCode,
//   };
// }
