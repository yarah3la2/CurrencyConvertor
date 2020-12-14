import 'package:currency_converter/model/CurrencyAmountDataModel.dart';
import 'package:currency_converter/utilities/AppConstants.dart';
import 'package:http/http.dart' as http;

class CurrencyConverterServices implements getSelectedCurrencyAmountRepository {

  @override
  Future<CurrencyAmount> getSelectedCurrencyAmount(String baseCurreny, String selectedCurrency,String amount) async {
    CurrencyAmount currencyAmount;
    String url = CURRENCY_CONVERTER_BASE_URL + "/convert" + API_KEY+"&from=$baseCurreny"+"&to=$selectedCurrency"+"&amount=$amount";
    print("url ?????? $url");
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      currencyAmount = parseCurrencyAmountData(resp.body);
      return currencyAmount;
    }
  }
}
CurrencyAmount parseCurrencyAmountData(String body) {
  return  CurrencyAmount.fromJson(body);
}