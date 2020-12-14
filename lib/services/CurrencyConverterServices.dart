import 'dart:convert';

import 'package:currency_converter/model/CurrencyConvertedListDataModel.dart';
import 'package:currency_converter/utilities/AppConstants.dart';
import 'package:http/http.dart' as http;

class CurrencyConverterServices implements getCurrencyConvertedListRepository {
  @override
  Future<CurrencyData> getCurrencyRatesList(String baseCurrency) async {
    CurrencyData currencyData ;
    String url = CURRENCY_CONVERTER_BASE_URL + "/latest" + API_KEY;
//    String url = CURRENCY_CONVERTER_BASE_URL + "/latest" + API_KEY+"&base=$baseCurrency";
    print("url ===== $url");
    print(url);
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      currencyData = parseCurrencyConvertedListData(resp.body);
      currencyData.rates.keys.toList().sort();
      return currencyData;
    }
    return currencyData;
  }
}
  CurrencyData parseCurrencyConvertedListData(String body) {
    return  CurrencyData.fromJson(body);
  }