import 'package:currency_converter/model/CurrencyAmountDataModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

 class CurrencyAmountConvertorViewModel extends Model{
  final getSelectedCurrencyAmountRepository api;
  String _amount;

  CurrencyAmountConvertorViewModel(this.api);


  String get amount => _amount;

  set amount(String value) {
    _amount = value;
  }
  Future<CurrencyAmount> currencyAmountValue;
  Future<CurrencyAmount> get amountValue => currencyAmountValue;
  set amountValue(Future<CurrencyAmount> value) {
    currencyAmountValue = value;
    notifyListeners();
  }


  Future<bool> setCurrencyAmount(String baseCurrency,String selectedCurrency) async {
    amountValue = api?.getSelectedCurrencyAmount(baseCurrency,selectedCurrency,amount??0);
    return amountValue != null;
  }


}