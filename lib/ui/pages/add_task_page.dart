import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/ui/theme.dart';
import 'package:todoapp/ui/widgets/button.dart';
import '../../controllers/task_controller.dart';
import '../widgets/TextFormFeild.dart';
import '../theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final DateTime _selectedDate = DateTime.now();
   String _startTime = DateFormat('hh:mm a')
      .format(DateTime.now())
      .toString();
   String _endTime = DateFormat('hh:mm a').format(
      DateTime.now().add(const Duration(minutes: 15))).toString();
  int _SelectRemine = 5;
  List<int> remindList = [5, 10, 15, 20];
  final String _SelectRepeat = 'None';
  List<String> repedList = ['None', 'Daily', 'weekly', 'Monthly'];
  int SelectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            Text('Add Task', style: headingStyle,),
            CustomTextFromFiled(title: 'Title',
                textFieldHint: ' Enter Title here',
                editingController: _taskController.titleController),
            CustomTextFromFiled(title: 'Note',
              textFieldHint: ' Enter Note here',
              editingController: _taskController.noteController,),
            CustomTextFromFiled(title: 'Date',
              textFieldHint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(onPressed: () {
                getDateFromUser();
              },
                icon: const Icon(
                  Icons.calendar_today_outlined, color: Colors.grey,),),),
            Row(children: [
              Expanded(child: CustomTextFromFiled(
                  title: ' StartTime', textFieldHint: _startTime,
                  widget: IconButton(onPressed: () {
                    getTimeFromUser(isStartTime:true);
                  },
                      icon: const Icon(
                        Icons.access_time_rounded, color: Colors.grey,)))),
              const SizedBox(width: 12,),
              Expanded(child: CustomTextFromFiled(
                  title: ' EndTime', textFieldHint: _endTime,
                  widget: IconButton(onPressed: () {
                    getTimeFromUser(isStartTime:false);
                  },
                      icon: const Icon(
                        Icons.access_time_rounded, color: Colors.grey,))))
            ],),
            CustomTextFromFiled(
              title: 'Remind',
              textFieldHint: ' $_SelectRemine minutes early',
              widget: Row(
                children: [
                  DropdownButton(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      onChanged: (String? newValue) {
                        setState(() {
                          _SelectRemine = int.parse(newValue!);
                        });
                      },
                      items: repedList.map<DropdownMenuItem<String>>((
                           value) =>
                          DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(value,
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                      ).toList()),
                  const SizedBox(width: 6,)
                ],
              ),
            ),
            const SizedBox(height: 18,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _colorPalette(),
                MyButtom(title: 'Create Task', onPressed: () {
                  _validateDate();
                },)

              ],
            )
          ],),
        ),
      ),
    );
  }

  Column _colorPalette() {
    return Column(
      children: [
        Text('Color', style: titleStyle,),
        const SizedBox(height: 8,),
        Wrap(
            children: List<Widget>.generate(3, (index) =>
                InkWell(
                    onTap: () {
                  setState(() {
                    SelectedColor = index;
                  });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CircleAvatar(
                        child: SelectedColor == index ? const
                        Icon(Icons.done, size: 16, color: Colors.white,) : null,
                        backgroundColor: index == 0 ? primaryClr : index == 1
                            ? pinkClr
                            : orangeClr,
                        radius: 14,
                      ),
                    )
                )))
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 24, color: primaryClr,),
        onPressed: () {
          Get.back();
        },),
      elevation: 0,
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/usedr.png'), radius: 18,),
        SizedBox(width: 20,)
      ],
    );
  }

  _validateDate(){
    if(_taskController.titleController.text.isNotEmpty &&_taskController.noteController.text.isNotEmpty){
      _addTaskToDatabase();
      Get.back();
    }else{
      if(_taskController.titleController.text.isEmpty || _taskController.noteController.text.isEmpty){
        Get.snackbar("requred", 'plase enter title or note');
      }
    }
  }

  _addTaskToDatabase()async{
    try{
      int value = await _taskController.addTask(Task(
          title: _taskController.titleController.text,
          note: _taskController.noteController.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          color: SelectedColor,
          remind: _SelectRemine,
          repeat: _SelectRepeat
      ));
      print('$value');
    }catch(e){
      print(e);
    }
  }

   getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));
    if(_pickedDate != null) {
      setState(() => _selectedDate == _pickedDate);
    } else {
      print('object');
    }
  }

  void getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
        context: context,
        initialTime: isStartTime
            ? TimeOfDay.fromDateTime(DateTime.now())
            : TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 15)))
    );
    String _formattedTime = _pickedTime!.format(context);
    if (isStartTime) {
      setState(() => _startTime = _formattedTime);
    } else if (!isStartTime) {
     setState(() => _endTime = _formattedTime);
   } else {
     print('time caceld');
   }
  }
}