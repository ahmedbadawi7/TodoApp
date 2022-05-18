import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/ui/size_config.dart';
import 'package:todoapp/ui/theme.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth
        (SizeConfig.orientation==Orientation.landscape?4:20)),
      width: SizeConfig.orientation==Orientation.landscape?SizeConfig.screenWidth/2:SizeConfig.screenWidth,
      margin: EdgeInsets.only(bottom:getProportionateScreenHeight(12) ),
      child: Container(
        padding:const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(16),
          color: _getBGClr(task.color)
        ),
        child: Row(
          children: [
            Expanded(child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(task.title!,style:TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),),
                const SizedBox(height: 12,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Icon(Icons.access_time_rounded,color: Colors.grey[200],size: 18,),
                  const SizedBox(width: 12,),
                  Text('${task.startTime} - ${task.endTime}',style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[100]
                  ),)

                ],),
                const SizedBox(height: 12,),
                Text(task.note!,style:TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),)
              ],),
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 0.5,
              height: 60,
              color: Colors.grey[200]!.withOpacity(0.7),


            ),
            RotatedBox(quarterTurns: 3,child: Text(task.isCompleted==0?'TODO':'Completed',style: GoogleFonts.lato(
                textStyle:const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                )
            ),),)
          ],
        ),
      ),
    );
  }

  _getBGClr(int? color) {
    switch(color){
      case 0 :
        return bluishClr;
      case 1 :
        return pinkClr;
      case 2 :
        return orangeClr;
      default:
        return bluishClr;

    }
  }
}
