import 'package:flutter/material.dart';
import 'package:reminder_app/data/model/models.dart';
import 'package:reminder_app/db/databases.dart';

class ServiceProvider with ChangeNotifier {
  String? _title;
  String? _description;
  int? _hour;
  int? _minute;
  String? _day;
  String? _month;
  String? _year;
  List<NoteModel> _listNoteModel = [];
  NoteModel? _noteModel ;

  changeTitle({required String value}) {
    _title = value;
    notifyListeners();
  }

  changeDescription({required String value}) {
    _description = value;
    notifyListeners();
  }

  changeHour({required int value}) {
    _hour = value;
    notifyListeners();
  }

  changeMinute({required int value}) {
    _minute = value;
    notifyListeners();
  }

  changeDay({required String value}) {
    _day = value;
    notifyListeners();
  }

  changeMonth({required String value}) {
    _month = value;
    notifyListeners();
  }

  changeYear({required String value}) {
    _year = value;
    notifyListeners();
  }

  fetchNote() async {
    _listNoteModel = await NotesDatabase.instance.readAllNotes();
    notifyListeners();
  }

   fetchNoteByID(int id) async {
    _noteModel = await NotesDatabase.instance.readNote(id);
    notifyListeners();
  }

  deleteNote(int id) async {
    notifyListeners();
    await NotesDatabase.instance.delete(id);
  }

  updateNote(NoteModel note) async {
    notifyListeners();
    await NotesDatabase.instance.update(note);
  }

  String? get getTitle => _title;
  String? get getDescription => _description;
  int? get getHour => _hour;
  int? get getMinute => _minute;
  String? get getDay => _day;
  String? get getMonth => _month;
  String? get getYear => _year;
  List<NoteModel> get listNote => _listNoteModel;
  NoteModel? get noteModel => _noteModel;


}
