// // To parse this JSON data, do
// //
// //     final dataModel = dataModelFromJson(jsonString);

// import 'dart:convert';

// Note dataModelFromJson(String str) =>
//     Note.fromJson(json.decode(str));

// String dataModelToJson(Note data) => json.encode(data.toJson());

// final tableData = 'tableNote';

// class ResultField {
//   static final List<String> values = [
//     id,
//     title,
//     description,
//     number,
//     isImportant,
//     dateTime
//   ];
//   static final String id = '_id';
//   static final String title = 'title';
//   static final String description = 'description';
//   static final String number = 'number';
//   static final String isImportant = 'isImportant';
//   static final String dateTime = 'dateTime';
// }

// class Note {
//   final int id;
//   final String title;
//   final String description;
//   final int number;
//   final bool isImportant;
//   final DateTime dateTime;

//   Note(
//       { required this.id,
//        required this.title,
//        required this.description,
//        required this.number,
//        required this.dateTime,
//        required this.isImportant});
//   Note copy({
//      int? id,
//      String? title,
//      String? description,
//      int? number,
//      bool? isImportant,
//      DateTime? dateTime,
//   }) =>
//       Note(
//           id: id ?? this.id,
//           title: title ?? this.title,
//           description: description ?? this.description,
//           number: number ?? this.number,
//           isImportant: isImportant ?? this.isImportant,
//           dateTime: dateTime ?? this.dateTime);

//   static Note fromJson(Map<String, Object?> json) => Note(
//         id: json[ResultField.id] as int,
//         title: json[ResultField.title] as String,
//         description: json[ResultField.description] as String,
//         isImportant: json[ResultField.isImportant] == 1,
//         number: json[ResultField.number] as int,
//         dateTime: DateTime.parse(json[ResultField.dateTime] as DateTime,)
//       );
//   Map<String, Object?> toJson() => {
//         ResultField.id: id,
//        ResultField.title:title,
//        ResultField.description:description,
//        ResultField.number:number,
//        ResultField.isImportant:isImportant?1:0,
//        ResultField.dateTime:dateTime,
//       };
// }

final tableData = 'data';

class ResultField {
  static final List<String> values = [
    id,
    title,
    description,
    hour,
    minute,
    day,
    date,
    month,
    year
  ];
  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String hour = 'hour';
  static final String minute = 'minute';
  static final String date = 'date';
  static final String day = 'day';
  static final String month = 'month';
  static final String year = 'year';
}

class NoteModel {
  int? id;
  String? title;
  String? description;
  int? hour;
  int? minute;
  int? date;
  String? day;
  String? month;
  String? year;

  NoteModel(
      {this.id,
      this.title,
      this.description,
      this.hour,
      this.minute,
      this.date,
      this.day,
      this.month,
      this.year});

  NoteModel copy({
    int? id,
    String? title,
    String? description,
    int? hour,
    int? minute,
    int? date,
    String? day,
    String? month,
    String? year,
  }) =>
      NoteModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        date: date ?? this.date,
        day: day ?? this.day,
        month: month ?? this.month,
        year: year ?? this.year,
      );

  static NoteModel fromJson(Map<String, Object?> json) => NoteModel(
        id: json[ResultField.id] as int,
        title: json[ResultField.title] as String,
        description: json[ResultField.description] as String,
        hour: json[ResultField.hour] as int,
        minute: json[ResultField.minute] as int,
        date: json[ResultField.date] as int,
        day: json[ResultField.day] as String,
        month: json[ResultField.month] as String,
        year: json[ResultField.year] as String,
        // dateTime: DateTime.parse(json[ResultField.dateTime] as String),
      );
  Map<String, Object?> toJson() => {
        ResultField.id: id,
        ResultField.title: title,
        ResultField.description: description,
        ResultField.hour: hour,
        ResultField.minute: minute,
        ResultField.date: date,
        ResultField.day: day,
        ResultField.month: month,
        ResultField.year: year,
        // ResultField.dateTime:dateTime!.toIso8601String(),
      };
}
