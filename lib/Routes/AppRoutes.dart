import 'package:get/get.dart';
import 'package:todoapp/Binding/MainBinding.dart';
import 'package:todoapp/ui/pages/add_task_page.dart';
import 'package:todoapp/ui/pages/home_page.dart';

class AppRoutes{
  static const add_task_page = Routes.add_task;
  static const home_page = Routes.home_page;
  static const NotificationScreen=Routes.Notification_Screen;

  static final routes = [
  // GetPage(name: Routes.Notification_Screen, page:()=>NotificationScreen(),binding: MainBinding()),
    GetPage(name: Routes.add_task, page:()=>AddTaskPage(),binding: MainBinding()),
    GetPage(name: Routes.home_page, page:()=>HomePage(),binding: MainBinding()),

  ];

}


class Routes{
  static const add_task = '/add_task';
  static const home_page = '/home_page';
  static const Notification_Screen = '/NotificationScreen';
}