import 'dart:convert';

import 'package:flutter/material.dart';

class CurrencyData {
  CurrencyData({
    this.success,
    this.timestamp,
    this.base,
    this.date,
    this.rates,
  });

  bool success;
  int timestamp;
  String base;
  DateTime date;
  Map<String, double> rates;

  factory CurrencyData.fromJson(String str) => CurrencyData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CurrencyData.fromMap(Map<String, dynamic> json) => CurrencyData(
    success: json["success"],
    timestamp: json["timestamp"],
    base: json["base"],
    date: DateTime.parse(json["date"]),
    rates: Map.from(json["rates"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "timestamp": timestamp,
    "base": base,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

abstract class getCurrencyConvertedListRepository{
  Future<CurrencyData> getCurrencyRatesList(String baseCurrency);
}