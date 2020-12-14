import 'package:currency_converter/utilities/AppConstants.dart';
import 'package:flutter/material.dart';
//get screen size methods
double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Widget drawWidgetOrEmptyContainer(bool condition, Widget widget) {
  return condition ? widget : Container();
}

// decoration helping methods
RoundedRectangleBorder buildButtonDecoration(){
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(ROUNDED_CORNER_RADIUS),
  );
}

//App TextFields helping methods
InputDecoration getInputDecoration(BuildContext context, String hintText, [Function onClearValue]) {
  return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
      hintText: hintText,
      hintStyle: NORMAL_GREY_TEXTSTYLE,
      enabled: true,
      enabledBorder: getDecorationInputBorder(context),
      focusedBorder: getDecorationInputBorder(context),
      disabledBorder: getDecorationInputBorder(context),
      focusedErrorBorder: getDecorationInputBorder(context),
      filled: true,
      fillColor: WHITE,
      suffixIcon:Icon(Icons.arrow_drop_down),
      prefixIcon: (onClearValue != null)
          ? GestureDetector(
        child: Icon(Icons.clear),
        onTap: onClearValue,
      )
          : null);
}

OutlineInputBorder getDecorationInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: WHITE,
    ),
    borderRadius: BorderRadius.circular(ROUNDED_CORNER_RADIUS),
  );
}

int setListLength(int expectedListCount,List list){
  return (list.length>=expectedListCount)? expectedListCount : list.length;
}
bool isEmptyText(String text) {
  return (text != null && text.isNotEmpty) ? false : true;
}

String getTextOrEmptyString(String text) {
  return text ?? '';
}

bool isNotEmptyList(List list) {
  return list != null && list.isNotEmpty;
}