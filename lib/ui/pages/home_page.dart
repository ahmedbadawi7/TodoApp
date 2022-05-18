import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/task_controller.dart';
import 'package:todoapp/services/theme_services.dart';
import 'package:todoapp/ui/theme.dart';
import 'package:todoapp/services/notification_services.dart';
import '../../models/task.dart';
import '../size_config.dart';
import '../widgets/TextFormFeild.dart';
import '../widgets/button.dart';
import '../widgets/task_tile.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
late NotifyHelper notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification();
  _taskController.getTask();
  }
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Column(
        children: [
        _addTaskBar(),
          _addDataBar(),
          const SizedBox(height: 6,),
         _showTasks()

              ],
            )
    );
  }

  AppBar _appBar() {
    return AppBar(
        leading: IconButton(icon: Icon(
          Get.isDarkMode ?
          Icons.wb_sunny_outlined : Icons.nightlight_round_outlined,
          size: 24,
          color: Get.isDarkMode ? Colors.white : darkGreyClr,
        ),
          onPressed: () {
            ThemeServices().switchTheme();
            },),
        elevation: 0,
        backgroundColor:context.theme.backgroundColor,
      actions:  [
      IconButton(icon: Icon(
        Icons.cleaning_services_outlined,
        size: 20,
        color: Get.isDarkMode ? Colors.white : darkGreyClr,
      ),
        onPressed: () {
        notifyHelper.cancelAllNotification();
              _taskController.deleteAllTasks();
            }),
       const CircleAvatar(backgroundImage: AssetImage('assets/images/person.jpeg'),radius: 18,),
       const SizedBox(width: 20,)
      ],
    );
  }

  Widget _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 18,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text(DateFormat.yMMMd().format(DateTime.now()),style: subheadingStyle,),
              Text('Today',style: subheadingStyle,)
          ]
    ),
    MyButtom(title: '+ Add Task',
        onPressed: () async {
    await Get.to(const AddTaskPage());
    _taskController.getTask();

    }),
      ]
          ),
    );

  }

  Widget _addDataBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 18,top: 10),
      child:DatePicker(
        DateTime.now(),
        width: 70,
        height: 100,
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        initialSelectedDate: DateTime.now(),
        dateTextStyle:GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey
            )
        ),
        dayTextStyle: GoogleFonts.lato(
            textStyle:const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey
            )
        ),
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey
            )
        ),
        onDateChange: (newDate){
          setState(() {
            _selectedDate = newDate;
          });

        },
      ) ,
    );
  }
   Future<void> _onRefresh()async {
      _taskController.getTask();
   }

   _showTasks(){
    return Expanded(
      child: Obx(() {
        if (_taskController.tasklist.isEmpty) {
          return _noTaskMsg();
        } else {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              scrollDirection: SizeConfig.orientation ==
                  Orientation.landscape ? Axis.horizontal : Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                var task = _taskController.tasklist[index];
              if(task.repeat == 'Daily'||
                  task.date ==  DateFormat.yMd().format(_selectedDate)||
                  (task.repeat == 'weekly' && _selectedDate.difference(DateFormat.yMd().parse(task.date!)).inDays %7==0 )||
                  (task.repeat == 'Monthly'&& DateFormat.yMd().parse(task.date!).day == _selectedDate.day)
              )  {
                // var hour = task.startTime.toString().split(':')[0];
                // var minutes = task.startTime.toString().split(':')[1];
                // debugPrint('my time is $hour');
                // debugPrint('my minute is $minutes');
                var date = DateFormat.jm().parse(task.startTime!);
                var myTime = DateFormat('HH:mm').format(date);
                notifyHelper.scheduledNotification
                  (int.parse(myTime.toString().split(':')[0]),
                    int.parse(myTime.toString().split(':')[1]),
                    task
                );
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 1222),
                  child: SlideAnimation(
                    horizontalOffset: 3000,
                    child: FadeInAnimation(
                      child: InkWell(
                        onTap: () {
                          showBottomSheet(context, task);
                        },
                        child: TaskTile(task: task),
                      ),
                    ),
                  ),
                );

              }else
                return Container();
              },
              itemCount: _taskController.tasklist.length,
            ),
          );
        }
      }
        ),
    );
    

  // return Expanded(
  //     child: Obx((){
  //   if(_taskController.tasklist.isEmpty){
  //     return _noTaskMsg();
  //   }else{
  //      return Container(height: 0,);
  //   }
  // }));
  }

   _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: SizeConfig.orientation == Orientation.landscape?
                Axis.horizontal:Axis.vertical,
                children: [
                  SizeConfig.orientation == Orientation.landscape?
                  const SizedBox(height: 6,):const SizedBox(height: 220,),
                 SvgPicture.asset('assets/images/task.svg',height: 90,semanticsLabel: 'Task',color: primaryClr.withOpacity(0.5),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    child: Text('jjgjjgg',style: subtitleStyle,textAlign: TextAlign.center,),
                  ),
                  SizeConfig.orientation == Orientation.landscape?
                  const SizedBox(height: 120,):const SizedBox(height: 180,),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  showBottomSheet(BuildContext context, Task task){
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          width:  SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)?
          (
          task.isCompleted == 1 ? SizeConfig.screenWidth * 0.6:
          SizeConfig.screenHeight*0.8)
              :(task.isCompleted==1?SizeConfig.screenHeight*0.30:
          SizeConfig.screenHeight*0.39),
          color: Get.isDarkMode?darkHeaderClr:Colors.white,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              task.isCompleted == 1 ?
               Container():
              _buildBotoomSheet(label:'Task Completed',onTap: (){
                notifyHelper.cancelNotification(task);
                 _taskController.makeTaskCompleted(task.id!);
                 Get.back();
              },
                  clr: primaryClr),
              _buildBotoomSheet(label:'Delete Task',onTap: (){
                notifyHelper.cancelNotification(task);
                _taskController.deleteTask(task);
                Get.back();
              },clr: Colors.red[300]!),
              Divider(color:Get.isDarkMode? Colors.grey:darkGreyClr ,),
              _buildBotoomSheet(label:'Cancel Completed',onTap: (){
                Get.back();
              },clr: primaryClr),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      )
    );
  }

  _buildBotoomSheet({
  required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false})
  {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin:  const  EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose?Get.isDarkMode?Colors.grey[600]!
                :Colors.grey[300]!:clr
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr
        ),
        child: Center(
          child: Text(label,style: isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),), // copywith تستخدم للتعديل في شي محدد في اي داله
        ),
      ),
    );
  }
}