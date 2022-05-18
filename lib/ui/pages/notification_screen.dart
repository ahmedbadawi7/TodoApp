import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/ui/widgets/CustomText.dart';

import '../../services/theme_services.dart';
import '../theme.dart';

class NotificationScreen extends StatefulWidget {
   NotificationScreen({Key? key,required this.payloade}) : super(key: key);
  String payloade = '';
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _playlode = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _playlode = widget.payloade;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Get.isDarkMode?Colors.white:darkGreyClr,) ,onPressed: (){
          Get.back();
        },),
        elevation: 0,
        title: Text(
          _playlode.toString().split('|')[0],style: TextStyle(color: Get.isDarkMode?Colors.white:darkGreyClr),),
        backgroundColor:context.theme.backgroundColor,

      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: const [
                SizedBox(height: 20,),
                CustomText(size: 16, text: 'Hello , ahmed'),
                 SizedBox(height: 10,),
                CustomText(size: 16, text: 'Zap Dingbats')
              ],
            ),
            const SizedBox(height: 10,),
            Expanded(child: Container(
              padding:const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              margin:const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: primaryClr
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children:  const [
                     Icon(Icons.text_format,size: 30,
                       color: Colors.white,),
                      SizedBox(width: 10,),
                      CustomText(size: 30, text: "title",
                        color: Colors.white,),
                SizedBox(height: 20,),
                    ],
                    ),
                    const SizedBox(height: 10,),
                    Text(_playlode.toString().split('|')[0],style: TextStyle(color:Colors.white,fontSize: 30),textAlign: TextAlign.justify,),
                    Row(children: const [
                      Icon(Icons.description,size: 30,color: Colors.white,),
                      SizedBox(width: 20,),
                      CustomText(size: 30, text: "Description",color: Colors.white,),

                    ],),
                    const SizedBox(height: 15,),
                    Text(_playlode.toString().split('|')[1],style: TextStyle(color:Colors.white,fontSize: 30),textAlign: TextAlign.justify,),
                    const SizedBox(height: 20,),
                    Row(children: const [
                      Icon(Icons.calendar_today_outlined,size: 35,color: Colors.white,),
                      SizedBox(width: 20,),
                      CustomText(size: 30, text: "Data",color: Colors.white,),
                    ],),
                    const SizedBox(height: 10,),
                    Text(_playlode.toString().split('|')[2],style: TextStyle(color:Colors.white,fontSize: 30),textAlign: TextAlign.justify,),
                    const SizedBox(height: 20,),
                    CustomText(text: _playlode.toString().split('|')[3],size: 35,),
                  ],
                ),
              ),
            )),
            const SizedBox(height: 20,),

          ],
        ),
      ),
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
      actions: const [
        CircleAvatar(backgroundImage: AssetImage('assets/images/usedr.png'),radius: 18,),
        SizedBox(width: 20,)
      ],
    );
  }
}

