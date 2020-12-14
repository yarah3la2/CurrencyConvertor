import 'package:flutter/material.dart';
//fonts
const double APPBAR_TEXT_FONT_TEXT = 22.0;
const double LABEL_FONT_SIZE = 18.0;
const double NORMAL_TEXT_FONT_SIZE = 16.0;
const double SMALL_TEXT_FONT_SIZE = 14.0;


//dimens
const double ROUNDED_CORNER_RADIUS = 10.0;
const double TEXTFIELD_BORDER_RADUIS_WIDTH=2.0;
const double OPACITY=0.5;
//colors
Color BLACK=Colors.blueGrey;
Color LIGHT_GREY= Colors.blueGrey[50];
Color GREY=Colors.grey;
Color WHITE =Colors.white;



//text
const String TEXT_CONST_CURRENCY_APPBAR_TITLE =
    'Currency Converer';
const String HINT_SELECT_CURRENCY="Select Currency";

const String CURRENCY_CONVERTER_BASE_URL="http://data.fixer.io/api";
const String API_KEY="?access_key=30c59362e5466b54e1bcb63f7d1ef251";


//TEXTSTYLE
TextStyle NORMAL_BLACK_TEXTSTYLE = TextStyle(fontSize: NORMAL_TEXT_FONT_SIZE, color: BLACK);
TextStyle NORMAL_GREY_TEXTSTYLE = TextStyle(fontSize: SMALL_TEXT_FONT_SIZE, color: GREY);
TextStyle APPBAR_TEXTSTYLE = TextStyle(fontSize: APPBAR_TEXT_FONT_TEXT, color:BLACK,fontWeight: FontWeight.bold);
TextStyle BUTTON_NORMAL_WHITE_TEXTSTYLE = TextStyle(fontSize: NORMAL_TEXT_FONT_SIZE, fontWeight: FontWeight.bold, color: WHITE);
TextStyle NORMAL_BOLD_TEXTSTYLE = TextStyle(fontSize: NORMAL_TEXT_FONT_SIZE, fontWeight: FontWeight.bold, color: BLACK);
