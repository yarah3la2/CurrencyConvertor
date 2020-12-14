import 'file:///C:/Users/NTG/AndroidStudioProjects/currency_converter/lib/viewmodel/SelectedBaseCurrencyAmountViewModel.dart';
import 'package:currency_converter/model/CurrencyAmountDataModel.dart';
import 'package:currency_converter/services/SelectedCurrencyAmountServices.dart';
import 'package:currency_converter/utilities/AppConstants.dart';
import 'package:currency_converter/utilities/UtilitiesMethods.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SelectedBaseCurrencyScreen extends StatefulWidget {
  final String selectedCurrency;
  final String selectedCurrenyValue;
  final String baseCurrency;

  const SelectedBaseCurrencyScreen({Key key, this.selectedCurrency, this.baseCurrency, this.selectedCurrenyValue}) : super(key: key);
  @override
  _SelectedBaseCurrencyScreenState createState() => _SelectedBaseCurrencyScreenState();
}

class _SelectedBaseCurrencyScreenState extends State<SelectedBaseCurrencyScreen> with SingleTickerProviderStateMixin{
  CurrencyAmountConvertorViewModel _amountConvertorViewModel;
  TextEditingController _amountController=TextEditingController();

  @override
  void initState() {
    super.initState();
    _amountController.text="0.0";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          body: ScopedModel<CurrencyAmountConvertorViewModel>(
            model: _amountConvertorViewModel,
            child: ScopedModelDescendant<CurrencyAmountConvertorViewModel>(
              builder: (context, child, model) {
                return FutureBuilder<CurrencyAmount>(
                  future: model.amountValue,
                  // ignore: missing_return
                  builder: (_, AsyncSnapshot<CurrencyAmount> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return Center(child: const CircularProgressIndicator());
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          var currencyAmount = snapshot?.data;
                          _amountController.text=snapshot.data.result.toString();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              selectedCurrencyDropDown(),
                              baseCurrencyDropDown(),
                            ],
                          );
                        }
                        else return Container(child: Center(child:Text( "Ops ! there is a problem occured",style: NORMAL_BOLD_TEXTSTYLE,)),);
                    }
                  },
                );
              },
            )
          ),
    ));
  }

  selectedCurrencyDropDown(){
    return TextField(
      readOnly: true,
      controller: _amountController,
      decoration: getInputDecoration(context, "Selected currency value"),
    );
  }
  baseCurrencyDropDown(){
    return  TextField(
//      readOnly: widget.isReadOnly,
      decoration:getInputDecoration(context, "enter amount"),
      textInputAction: TextInputAction.done,
      onChanged: (value) => getBaseCurrentAmountText(value),
      keyboardType: TextInputType.number,
    );
  }
  getBaseCurrentAmountText(String baseAmount) {
    _amountConvertorViewModel.amount = baseAmount??0;
    loadCurrencyAmount();
  }

  loadCurrencyAmount(){
    _amountConvertorViewModel = CurrencyAmountConvertorViewModel(CurrencyConverterServices());
    _amountConvertorViewModel.setCurrencyAmount(widget.baseCurrency,widget.selectedCurrency);
  }
}
