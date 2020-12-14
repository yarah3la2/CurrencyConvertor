// To parse this JSON data, do
//
//     final currencyAmount = currencyAmountFromMap(jsonString);

import 'dart:convert';

class CurrencyAmount {
  CurrencyAmount({
    this.success,
    this.query,
    this.info,
    this.date,
    this.result,
  });

  bool success;
  Query query;
  Info info;
  DateTime date;
  double result;

  factory CurrencyAmount.fromJson(String str) => CurrencyAmount.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CurrencyAmount.fromMap(Map<String, dynamic> json) => CurrencyAmount(
    success: json["success"],
    query: Query.fromMap(json["query"]),
    info: Info.fromMap(json["info"]),
    date: DateTime.parse(json["date"]),
    result: json["result"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "query": query.toMap(),
    "info": info.toMap(),
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "result": result,
  };
}

class Info {
  Info({
    this.timestamp,
    this.rate,
  });

  int timestamp;
  double rate;

  factory Info.fromJson(String str) => Info.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Info.fromMap(Map<String, dynamic> json) => Info(
    timestamp: json["timestamp"],
    rate: json["rate"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "timestamp": timestamp,
    "rate": rate,
  };
}

class Query {
  Query({
    this.from,
    this.to,
    this.amount,
  });

  String from;
  String to;
  int amount;

  factory Query.fromJson(String str) => Query.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Query.fromMap(Map<String, dynamic> json) => Query(
    from: json["from"],
    to: json["to"],
    amount: json["amount"],
  );

  Map<String, dynamic> toMap() => {
    "from": from,
    "to": to,
    "amount": amount,
  };
}

abstract class getSelectedCurrencyAmountRepository{
  Future<CurrencyAmount> getSelectedCurrencyAmount(String baseCurreny,String selectedCurrency,String amount);
}