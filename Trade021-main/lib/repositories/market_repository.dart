import 'dart:async';
import '../data/sample_data.dart';
import '../models/stock_model.dart';

class MarketRepository {
  Future<List<List<Stock>>> fetchInitialWatchlists() async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      generateRandomStocks(7),
      generateRandomStocks(5),
      generateRandomStocks(5),
    ];
  }

  Future<List<List<Stock>>> fetchUpdatedPrices(List<List<Stock>> currentWatchlists) async {
    // Simulate occasional network timeout
    if (random.nextDouble() > 0.95) {
      throw TimeoutException("Failed to fetch latest prices");
    }
    
    return currentWatchlists.map((list) {
      return list.map((stock) {
        double randomChange = (random.nextDouble() * 2 - 1);
        double newPrice = stock.price + randomChange;
        double newPercent = (randomChange / stock.price) * 100;
        return stock.copyWith(
          price: (newPrice * 100).round() / 100,
          change: (newPercent * 100).round() / 100,
        );
      }).toList();
    }).toList();
  }
}
