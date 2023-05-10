import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/data/provider/provider.dart';
import 'package:reminder_app/notification_api/notification_api.dart';
import 'package:reminder_app/pages/add_edit_page.dart';
import 'package:reminder_app/pages/list_note.dart';
import 'package:timezone/data/latest_all.dart' as tz;

void main() async {
 //ini main
  tz.initializeTimeZones();
  runApp( MyApp());
  NotificationApi().init();
  
}

class MyApp extends StatelessWidget {
  
  
MyApp({Key? key}) : super(key: key);
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ServiceProvider())
      ],
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
        home: const ListNote(),
      ),
    );
  }
}
