import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/data/provider/provider.dart';
import 'package:reminder_app/db/databases.dart';
import 'package:reminder_app/data/model/models.dart';
import 'package:reminder_app/external/app_color.dart';
import 'package:reminder_app/external/note_image.dart';
import 'package:reminder_app/notification_api/notification_api.dart';
import 'package:reminder_app/pages/add_edit_page.dart';
import 'package:reminder_app/pages/second_page.dart';

class ListNote extends StatelessWidget {
  const ListNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    serviceProvider.fetchNote();
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
            title: Row(
          children: [
            Image(
              image: AssetImage(NoteImage.app_icon),
              height: 30,
              width: 30,
            ),
           const SizedBox(
              width: 5,
            ),
            const Text(
              'Reminder',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (c) {
              return AddEditNote();
            }));
          },
          child: const Icon(Icons.add),
        ),
        body: serviceProvider.listNote.isEmpty
            ? const Center(
                child: Text(
                  'Belum Ada Catatan',
                ),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: serviceProvider.listNote.length,
                itemBuilder: (c, index) {
                  final item = serviceProvider.listNote[index];
                  return Container(
                    padding: const EdgeInsets.only(
                        top: 70, left: 100, right: 100, bottom: 55),
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(NoteImage.image_note))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Pukul ${item.hour}:${item.minute}',
                                  style: const TextStyle(letterSpacing: 1),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 2),
                              child: Row(
                                children: [
                                  Text("${item.day},"),
                                  const SizedBox(width: 3),
                                  Text('${item.date}'),
                                  const SizedBox(width: 3),
                                  Text('${item.month}'),
                                  const SizedBox(width: 3),
                                  Text('${item.year}'),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                '${item.title}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (c) {
                                  return AddEditNote(noteModel: item);
                                }));
                              },
                              child: Image(
                                height: 30,
                                image: AssetImage(NoteImage.icon_edit),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                // showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return AlertDialog(
                                //         title: const Text(
                                //           'Apakah Anda Yakin ingin Menghapus Catatan ini',
                                //           textAlign: TextAlign.center,
                                //           style: TextStyle(fontSize: 15),
                                //         ),
                                //         content: Column(
                                //           mainAxisSize: MainAxisSize.min,
                                //           children: <Widget>[
                                //             Row(
                                //                 mainAxisAlignment:
                                //                     MainAxisAlignment
                                //                         .spaceBetween,
                                //                 children: <Widget>[
                                //                   ElevatedButton(
                                //                       style: ElevatedButton
                                //                           .styleFrom(
                                //                         shape:
                                //                             RoundedRectangleBorder(
                                //                           borderRadius:
                                //                               BorderRadius
                                //                                   .circular(10),
                                //                         ),
                                //                       ),
                                //                       child:
                                //                           const Text('Tidak'),
                                //                       onPressed: () {
                                //                         Navigator.pop(context);
                                //                       }),
                                //                   ElevatedButton(
                                //                       style: ElevatedButton
                                //                           .styleFrom(
                                //                         primary: Colors.red,
                                //                         shape:
                                //                             RoundedRectangleBorder(
                                //                           borderRadius:
                                //                               BorderRadius
                                //                                   .circular(10),
                                //                         ),
                                //                       ),
                                //                       child: const Text(
                                //                         'Ya',
                                //                         style: TextStyle(
                                //                             fontSize: 13),
                                //                       ),
                                //                       onPressed: () {
                                //                         NotesDatabase.instance
                                //                             .delete(item.id!);
                                //                             Navigator.pop(context);
                                //                       })
                                //                 ])
                                //           ],
                                //         ),
                                //       );
                                //     });
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.WARNING,
                                  animType: AnimType.BOTTOMSLIDE,
                                  btnOkText: 'Ya',
                                  btnCancelText: 'Tidak',
                                  btnCancelColor: Colors.greenAccent,
                                  btnOkColor: Colors.red,
                                  title:
                                      'Apakah Anda Yakin Ingin Menghapus Catatan ini',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () async {
                                    await NotificationApi.cancelNotification(
                                        item.id!);
                                    NotesDatabase.instance.delete(item.id!);
                                    // cancel the notification with id value of zero
                                    AwesomeDialog(
                                      autoHide: const Duration(seconds: 2),
                                      context: context,
                                      dialogType: DialogType.SUCCES,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Berhasil Dihapus',
                                    ).show();
                                  },
                                ).show();
                              },
                              child: Image(
                                height: 30,
                                image: AssetImage(NoteImage.icon_delete),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              )
        // : StaggeredGridView.countBuilder(
        //     staggeredTileBuilder: (index) {
        //       return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
        //     },
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 2,
        //     mainAxisSpacing: 2,
        //     itemCount: serviceProvider.listNote.length,
        //     itemBuilder: (context, index) {
        //       final item = serviceProvider.listNote[index];
        //       return Container(
        //           margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        //           decoration: const BoxDecoration(
        //               color: Colors.red,
        //               borderRadius: BorderRadius.all(Radius.circular(15))),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Column(
        //                 children: [
        //                   Text(
        //                     '${item.title}',
        //                     maxLines: 2,
        //                     style: const TextStyle(
        //                         fontSize: 20,
        //                         fontWeight: FontWeight.bold,
        //                         overflow: TextOverflow.ellipsis),
        //                   ),
        //                   Text(
        //                     '${item.description}',
        //                     maxLines: 3,
        //                   ),
        //                 ],
        //               ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   IconButton(
        //                       onPressed: () {
        //                         Navigator.push(context,
        //                             MaterialPageRoute(builder: (c) {
        //                           return AddEditNote(noteModel: item);
        //                         }));
        //                       },
        //                       icon: const Icon(Icons.edit)),
        //                   IconButton(
        //                       onPressed: () {
        //                         serviceProvider.deleteNote(item.id!);
        //                       },
        //                       icon: const Icon(Icons.delete)),
        //                 ],
        //               )
        //             ],
        //           ));
        //     },
        //   ),
        );
  }
}
