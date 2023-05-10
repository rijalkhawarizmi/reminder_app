import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/data/provider/provider.dart';
import 'package:reminder_app/db/databases.dart';
import 'package:reminder_app/data/model/models.dart';
import 'package:reminder_app/external/app_color.dart';
import 'package:reminder_app/external/note_image.dart';
import 'package:reminder_app/notification_api/notification_api.dart';
import 'package:reminder_app/pages/list_note.dart';

class AddEditNote extends StatefulWidget {
  NoteModel? noteModel;
  AddEditNote({Key? key, this.noteModel}) : super(key: key);

  @override
  State<AddEditNote> createState() => _AddEditNoteState();
}

class _AddEditNoteState extends State<AddEditNote> {
  final _globalKey = GlobalKey<ScaffoldMessengerState>();
  NotificationApi? notificationApi;
  DateTime _initialDate = DateTime.now();
  DateTime? chooseDate;
  String? initialTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String? chooseTime;
  Future getDateFromUser() async {
    DateTime? _date = await showDatePicker(
        
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2023));
    if (_date != null) {
      setState(() {
        chooseDate = _date;
      });
    }
  }

  getTimeUSER() async {
    var pickTime = await showTimeUser();
    String formatTime = pickTime.format(context);
    print('wowwww $formatTime');
    setState(() {
      chooseTime = formatTime;
      print('ini start $chooseTime');
    });
  }

  showTimeUser() async {
    return showTimePicker(
       
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(initialTime!.split(":")[0]),
            minute: int.parse(initialTime!.split(":")[1].split(" ")[0])));
  }

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  late TextEditingController editTitleController;
  late TextEditingController editDescriptionController;
  late TextEditingController editDayController;
  late TextEditingController editDateController;
  late TextEditingController editMonthController;
  late TextEditingController editYearController;
  late TextEditingController editHourController;
  late TextEditingController editMinuteController;

  @override
  void initState() {
    editTitleController =
        TextEditingController(text: widget.noteModel?.title ?? '');
    editDescriptionController =
        TextEditingController(text: widget.noteModel?.description ?? '');
    editDayController = TextEditingController(text: widget.noteModel?.day);
    editDateController =
        TextEditingController(text: widget.noteModel?.date.toString());
    editMonthController = TextEditingController(text: widget.noteModel?.month);
    editYearController = TextEditingController(text: widget.noteModel?.year);
    editMinuteController =
        TextEditingController(text: widget.noteModel?.minute.toString());
    editHourController =
        TextEditingController(text: widget.noteModel?.hour.toString());
    super.initState();
    notificationApi = NotificationApi();
    initializeDateFormatting('id', null);
  }

  @override
  void dispose() {
    super.dispose();
    editTitleController.dispose();
    editDescriptionController.dispose();
    editDayController.dispose();
    editDateController.dispose();
    editMonthController.dispose();
    editYearController.dispose();
    editMinuteController.dispose();
    editHourController.dispose();
  }

  @override
  Widget build(BuildContext context) {
//     DateTime datee=DateFormat.jm().parse(_startTime.toString());
// String iniTime=DateFormat('HH:mm').format(datee);
// print('wadh ${int.parse(iniTime.split(":")[1].split(" ")[0])}');

    return Scaffold(
      key: _globalKey,
      appBar: AppBar(backgroundColor: Colors.blue),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   child: DatePicker(
                //     DateTime.now(),
                //     height: 100,
                //     width: 80,
                //     initialSelectedDate: DateTime.now(),
                //     selectionColor: Colors.blue,
                //     selectedTextColor: Colors.white,
                //     dateTextStyle:
                //         TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                //     onDateChange: (date) {
                //       _initialDate = date;
                //     },
                //   ),
                // ),
                const Text('Hari ini Tanggal :'),
                Text(
                  '${DateFormat('EEEE', 'id').format(_initialDate)} ${_initialDate.day} ${DateFormat('MMMM', 'id').format(_initialDate)} ${_initialDate.year}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(45),
                    ],
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(fontSize: 12),
                      hintText: 'Masukkan Judul Kegiatan',
                      contentPadding: const EdgeInsets.only(left: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    controller: editTitleController.text.isNotEmpty
                        ? editTitleController
                        : titleController),
                // SizedBox(
                //   height: 10,
                // ),
                // TextFormField(
                //     maxLines: 5,
                //     decoration: InputDecoration(
                //       hintStyle: TextStyle(fontSize: 12),
                //       hintText:
                //           'Masukkan Deskripsi Kegiatan \n(Boleh dikosongkan)',
                //       contentPadding: EdgeInsets.only(left: 10, top: 5),
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: const BorderSide(color: Colors.blue),
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     controller: editDescriptionController.text.isNotEmpty
                //         ? editDescriptionController
                //         : descriptionController),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          getDateFromUser();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue),
                          child: Center(
                            child: chooseDate == null
                                ? editDateController.text.isNotEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            editDayController.text,
                                            style: const TextStyle(
                                                color: kWhite,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${editDateController.text} Maret ${editYearController.text}',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: kWhite,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children:  [
                                        Image(image: AssetImage(NoteImage.icon_date),height: 30,width: 30,),
                                        const  Text(
                                        'Pilih Tanggal',
                                        style: TextStyle(
                                            color: kWhite,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1),
                                      ),

                                      ],
                                    )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      
                                      Text(
                                        DateFormat('EEEE', 'id')
                                            .format(chooseDate!),
                                        style: const TextStyle(
                                            color: kWhite,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1),
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${chooseDate?.day} Maret ${chooseDate!.year}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: kWhite,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          getTimeUSER();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                            Image(image: AssetImage(NoteImage.icon_clock),height: 30,width: 30,),
                            Text(
                            chooseTime == null
                                ? editHourController.text.isNotEmpty
                                    ? "Jam ${editHourController.text}:${editMinuteController.text}"
                                    : 'Pilih Jadwal'
                                : 'Jam ${chooseTime?.substring(0, 5)}',
                            style: const TextStyle(
                                color: kWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                          ],),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: () {
                    int uniqueID = UniqueKey().hashCode;

                    String dayName =
                        DateFormat('EEEE', 'id').format(_initialDate);
                    String yearsName =
                        DateFormat('yyyy', 'id').format(_initialDate);
                    String monthName =
                        DateFormat('MMMM', 'id').format(_initialDate);

                    if (titleController.text.isEmpty &&
                        editTitleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Judul Kegiatan Tidak Boleh Kosong'),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ));
                    } else if (chooseDate == null &&
                        editDateController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Pilih Tanggal Kegiatan Dulu yaa'),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ));
                    } else if (chooseTime == null &&
                        editHourController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Pilih Jadwal Kegiatan Dulu yaa'),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ));
                    }

                    if (editTitleController.text.isNotEmpty) {
                      NotificationApi.showScheduledNotification(
                          id: widget.noteModel?.id ?? uniqueID,
                          title: editTitleController.text,
                          body: editDescriptionController.text,
                          payload: '${editTitleController.text} ${editDateController.text}',
                          hour: int.parse(editHourController.text),
                          minutes: int.parse(editMinuteController.text),
                          date: int.parse(editDateController.text),
                          month: DateFormat("MMMM", "id")
                              .parse(editMonthController.text)
                              .month,
                          year: int.parse(editYearController.text));
                      final note = NoteModel(
                          id: widget.noteModel?.id ?? uniqueID,
                          title: editTitleController.text.trim(),
                          description: editDescriptionController.text.trim(),
                          hour: int.parse(editHourController.text),
                          minute: int.parse(editMinuteController.text),
                          date: int.parse(editDateController.text),
                          day: editDayController.text,
                          month: editMonthController.text,
                          year: editYearController.text);
                      NotesDatabase.instance.update(note);

                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (c) {
                        return const ListNote();
                      }), (route) => false);
                      AwesomeDialog(
                        autoHide: const Duration(seconds: 2),
                        context: context,
                        dialogType: DialogType.SUCCES,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Berhasil Diubah',
                      ).show();
                    } else {
                 
                      NotificationApi.showScheduledNotification(
                          id: uniqueID,
                          title: titleController.text,
                          body: descriptionController.text,
                          payload: uniqueID.toString(),
                          hour: int.parse(chooseTime!.split(":")[0]),
                          minutes: int.parse(
                              chooseTime!.split(":")[1].split(" ")[0]),
                          date: chooseDate?.day,
                          month: chooseDate?.month,
                          year: chooseDate?.year);
                      final note = NoteModel(
                          id: uniqueID,
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          hour: int.parse(chooseTime!.split(":")[0]),
                          minute: int.parse(
                              chooseTime!.split(":")[1].split(" ")[0]),
                          date: chooseDate?.day,
                          day: dayName,
                          month: monthName,
                          year: yearsName);
                      NotesDatabase.instance.create(note);
                     
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (c) {
                        return ListNote();
                      }), (route) => false);
                    }
                  },
                  child: Text(
                    widget.noteModel?.title != null ? 'Ubah' : 'Simpan',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
