import 'package:currency_converter/model/CurrencyConvertedListDataModel.dart';
import 'package:currency_converter/packages/dropdownfield.dart';
import 'package:currency_converter/services/CurrencyConverterServices.dart';
import 'package:currency_converter/utilities/AppConstants.dart';
import 'package:currency_converter/utilities/UtilitiesMethods.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../viewmodel/currencyConverterViewModel.dart';
import 'SelectedBaseCurrencyScreen.dart';

class CurrencyConvertorScreen extends StatefulWidget {
  @override
  _CurrencyConvertorScreenState createState() =>
      _CurrencyConvertorScreenState();
}

class _CurrencyConvertorScreenState extends State<CurrencyConvertorScreen>
    with SingleTickerProviderStateMixin {
  CurrencyConvertorViewModel _currencyRatesListViewModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
loadCurrencyRatesList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          body: ScopedModel<CurrencyConvertorViewModel>(
            model: _currencyRatesListViewModel,
            child: Column(
              children: <Widget>[
                currencySelectorWidget(_currencyRatesListViewModel.currencyList),
                convertedCurrencyRateList()
              ],
            ),
          )),
    );
  }

  Expanded currencySelectorWidget(List<String> baseCurrenyList) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: getScreenHeight(context) * 0.3,
        decoration: BoxDecoration(
          color: BLACK, /////////////////////
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
          child: DropDownField(
            context: context,
            value: "EGP",
            hintText: HINT_SELECT_CURRENCY,
            items: baseCurrenyList,
//        enabled: areSavedTemplateLoaded,
            onValueChanged: (String baseCurrency) => getBaseCurrentText(baseCurrency),
          ),
        ),
      ),
    );
  }

  Expanded convertedCurrencyRateList() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: ScopedModelDescendant<CurrencyConvertorViewModel>(
              builder: (context, child, model) {
                return FutureBuilder<CurrencyData>(
                  future: model.currencyRatesList,
                  // ignore: missing_return
                  builder: (_, AsyncSnapshot<CurrencyData> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return Center(child: const CircularProgressIndicator());
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          var currenyRates = snapshot?.data;
                         return buildCurrencyRatesWidgetList(currenyRates);
                        }
                        else return Container(child: Center(child:Text( "Ops ! there is a problem occured",style: NORMAL_BOLD_TEXTSTYLE,)),);
                    }
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }


Widget buildCurrencyRatesWidgetList(dynamic currenyRates){
  return ListView.separated(
    itemCount: isNotEmptyList(currenyRates?.rates.keys.toList()) ? currenyRates.rates.length:0,
    separatorBuilder:
        (BuildContext context, int index) => Divider(
      indent: 75,
      endIndent: 20,
      height: 2,
    ),
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
          title: Text(currenyRates.rates.keys.toList()[index]),
          trailing:Text("${currenyRates.rates.values.toList()[index]}"),
          onTap: ()=> onCurrencyRateListItemTapped(currenyRates.rates.keys.toList()[index],_currencyRatesListViewModel.baseCurrency,currenyRates.rates.values.toList()[index].toString()),
      );
    },
    padding: EdgeInsets.only(top: 10),
  );
}

  getBaseCurrentText(String baseCurrencyText) {
    _currencyRatesListViewModel.baseCurrency = baseCurrencyText;
    loadCurrencyRatesList();
  }

  loadCurrencyRatesList() {
    _currencyRatesListViewModel = CurrencyConvertorViewModel(
        api: CurrencyConverterServices());
    _currencyRatesListViewModel.setCurrencyRates();
  }

  onCurrencyRateListItemTapped(String selectedCurrency,String baseCurrency,String selectedCurrenyValue){
    Navigator.push(
        context,
        PageRouteBuilder( pageBuilder: (_,__,___) =>
        SelectedBaseCurrencyScreen(
          selectedCurrency: selectedCurrency,
          baseCurrency: baseCurrency??"EGP",
          selectedCurrenyValue:selectedCurrenyValue ,
        ) ));
  }
}
