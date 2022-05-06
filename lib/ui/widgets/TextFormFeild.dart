
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../size_config.dart';
import '../theme.dart';

class CustomTextFromFiled extends StatelessWidget {
   CustomTextFromFiled(
      {Key? key,
        this.editingController,
        this.textFieldNameColor = Colors.grey,
        this.textFieldHint = " ",
        this.inputAction = TextInputAction.next,
        this.obscure = false,
        this.validator,
        this.autofillHints,
        this.keyboardType,
        this.fillColor = Colors.white,
        this.validateMode = AutovalidateMode.always,
        this.prefixIcon,
        this.title,
        this.suffixIcon,
        this.onSaved,
        this.widget
      })
      : super(key: key);
  final String? Function(String?)? validator;
  FormFieldSetter<String>? onSaved;
  final Iterable<String>? autofillHints;
  final TextEditingController? editingController;
  final Color fillColor;
  final TextInputAction inputAction;
  final TextInputType? keyboardType;
  final bool obscure;
  final String textFieldHint;
  final Color textFieldNameColor;
  final AutovalidateMode validateMode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? title;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title!,style: titleStyle,),
            Container(
              padding: const EdgeInsets.only(top: 14),
              margin: const EdgeInsets.only(left: 8),
              width: SizeConfig.screenWidth,
              height:60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade500),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorWidth: 0,
                      autofocus: false,
                enableSuggestions: true,
                textInputAction: inputAction,
                obscureText: obscure,
               style: subtitleStyle,
                autofillHints: autofillHints,
                autovalidateMode: validateMode,
                controller: editingController,
                keyboardType: keyboardType,
                validator: validator,
                onSaved: onSaved,
                readOnly: widget != null?true:false,
                cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                decoration: InputDecoration(
                      hintText: textFieldHint,
                      hintStyle:subtitleStyle,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: context.theme.backgroundColor,
                              width: 0),
                          borderRadius: BorderRadius.circular(10)),
                      // errorBorder: UnderlineInputBorder(
                      //     borderRadius: BorderRadius.circular(10),
                      //     borderSide:  const BorderSide(color: Colors.red,width: 0)
                      // ),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:  BorderSide(color: context.theme.backgroundColor,width: 0)
                      ),
                      prefixIcon: prefixIcon,
                      suffixIcon: suffixIcon ,
                       // fillColor: Colors.white,
                      // filled: true,

                ),
              ),
                  ),
              widget??Container(width: 0,height: 0,),
                ],
              ),
            ),
          ],
        ),
      );
  }
}