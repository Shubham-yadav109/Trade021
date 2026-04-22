import 'dart:math';
import '../models/stock_model.dart';
final Random random = Random();
List<String> stockNames = [
  "RELIANCE","HDFCBANK","ASIANPAINT","TCS","INFY","WIPRO",
  "ICICI","SBIN","AXISBANK","KOTAKBANK","LT","ITC",
  "ONGC","MARUTI","BAJAJ","ADANI","POWERGRID","NTPC",
  "ULTRACEMCO","SUNPHARMA",
];
List<Stock> generateRandomStocks(int count) {
  return List.generate(count, (index) {
    double price = 100 + random.nextDouble() * 3000;
    double change = -10 + random.nextDouble() * 20;
    return Stock(
      name: stockNames[index],
      type: "NSE | EQ",
      price: double.parse(price.toStringAsFixed(2)),
      change: double.parse(change.toStringAsFixed(2)),
    );
  });
}