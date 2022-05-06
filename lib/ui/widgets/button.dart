import 'package:flutter/material.dart';
import 'package:todoapp/ui/theme.dart';
import 'package:todoapp/ui/widgets/CustomText.dart';

class MyButtom extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;

  const MyButtom({Key? key, required this.title,required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryClr
        ),
        width: 100,
        height: 45,
        child:Text(title!,style: const TextStyle(color: Colors.white),textAlign: TextAlign.center,),
      ),
    );
  }
}