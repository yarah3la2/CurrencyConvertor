import 'package:currency_converter/model/CurrencyConvertedListDataModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

 class CurrencyConvertorViewModel extends Model{
   List<String> currencyList = ["EGP", "AED", "EUR", "GBP"];
   final getCurrencyConvertedListRepository api;
   String _baseCurrency;


   String get baseCurrency => _baseCurrency;
  set baseCurrency(String value) {
    _baseCurrency = value;
  }

  Future<CurrencyData> _currencyRatesList;
Future<CurrencyData> get currencyRatesList => _currencyRatesList;
  set currencyRatesList(Future<CurrencyData> value) {
  _currencyRatesList = value;
  notifyListeners();
   }

  CurrencyConvertorViewModel( {@required this.api});

  Future<bool> setCurrencyRates() async {
    currencyRatesList = api?.getCurrencyRatesList(baseCurrency??"EGP");
    return currencyRatesList != null;
  }
}