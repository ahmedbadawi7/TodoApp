import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/Routes/AppRoutes.dart';
import 'package:todoapp/db/db_helper.dart';
import 'package:todoapp/services/notification_services.dart';
import 'package:todoapp/services/theme_services.dart';
import 'package:todoapp/ui/pages/home_page.dart';
import 'package:todoapp/ui/pages/notification_screen.dart';
import 'package:todoapp/ui/theme.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
 //await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
  //NotifyHelper().initalizationNotificaion();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes,

      home:  const HomePage(),
    );
  }
}
