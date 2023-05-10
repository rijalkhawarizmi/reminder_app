import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/data/provider/provider.dart';
import 'package:reminder_app/db/databases.dart';
import 'package:reminder_app/external/app_color.dart';
import 'package:reminder_app/external/note_image.dart';
import 'package:reminder_app/notification_api/notification_api.dart';

class SecondPage extends StatefulWidget {
  final String? payload;
  const SecondPage({Key? key, this.payload}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late ServiceProvider _serviceProvider;
  @override
  Widget build(BuildContext context) {
    _serviceProvider = Provider.of<ServiceProvider>(context);
    _serviceProvider.fetchNoteByID(int.parse(widget.payload!));
    return Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: Container(
          padding:
              const EdgeInsets.only(top: 70, left: 100, right: 100, bottom: 55),
          height: 300,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(NoteImage.image_note))),
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
                        'Pukul ${_serviceProvider.noteModel?.hour}:${_serviceProvider.noteModel?.minute}',
                        style: const TextStyle(letterSpacing: 1),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 2),
                    child: Row(
                      children: [
                        Text("${_serviceProvider.noteModel?.day},"),
                        const SizedBox(width: 3),
                        Text('${_serviceProvider.noteModel?.date}'),
                        const SizedBox(width: 3),
                        Text('${_serviceProvider.noteModel?.month}'),
                        const SizedBox(width: 3),
                        Text('${_serviceProvider.noteModel?.year}'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      '${_serviceProvider.noteModel?.title}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
