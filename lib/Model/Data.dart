// /// id : "1"
// /// title : "new"
// /// description : "test"
// /// status : "test"
// /// image : "assets/issues/3NUw39fBXXuD22Pjj3ZoikGtb6iK5V1f1647242802.jpeg"
// /// languages : "english,arabic"
// /// created_by : "1"
// /// created_at : "2022-03-14 07:26:42"
// /// history : []
//
// class Data {
//   Data({
//       String? id,
//       String? title,
//       String? description,
//       String? status,
//       String? image,
//       String? languages,
//       String? createdBy,
//       String? createdAt,
//       List<dynamic>? history,}){
//     _id = id;
//     _title = title;
//     _description = description;
//     _status = status;
//     _image = image;
//     _languages = languages;
//     _createdBy = createdBy;
//     _createdAt = createdAt;
//     _history = history;
// }
//
//   Data.fromJson(dynamic json) {
//     _id = json['id'];
//     _title = json['title'];
//     _description = json['description'];
//     _status = json['status'];
//     _image = json['image'];
//     _languages = json['languages'];
//     _createdBy = json['created_by'];
//     _createdAt = json['created_at'];
//     if (json['history'] != null) {
//       _history = [];
//       json['history'].forEach((v) {
//         _history?.add(Dynamic.fromJson(v));
//       });
//     }
//   }
//   String? _id;
//   String? _title;
//   String? _description;
//   String? _status;
//   String? _image;
//   String? _languages;
//   String? _createdBy;
//   String? _createdAt;
//   List<dynamic>? _history;
//
//   String? get id => _id;
//   String? get title => _title;
//   String? get description => _description;
//   String? get status => _status;
//   String? get image => _image;
//   String? get languages => _languages;
//   String? get createdBy => _createdBy;
//   String? get createdAt => _createdAt;
//   List<dynamic>? get history => _history;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['title'] = _title;
//     map['description'] = _description;
//     map['status'] = _status;
//     map['image'] = _image;
//     map['languages'] = _languages;
//     map['created_by'] = _createdBy;
//     map['created_at'] = _createdAt;
//     if (_history != null) {
//       map['history'] = _history?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
// // class History {
// //   String? id;
// //   String? issueId;
// //   String? status;
// //   String? userId;
// //   String? date;
// //
// //   History({this.id, this.issueId, this.status, this.userId, this.date});
// //
// //   History.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     issueId = json['issue_id'];
// //     status = json['status'];
// //     userId = json['user_id'];
// //     date = json['date'];
// //   }
//
