import '../models/stock_model.dart';

abstract class StockEvent {
  const StockEvent();
}

class LoadStocksRequested extends StockEvent {
  const LoadStocksRequested();
}

class ReorderStockRequested extends StockEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderStockRequested(this.oldIndex, this.newIndex);
}

class WatchlistTabChanged extends StockEvent {
  final int tabIndex;

  const WatchlistTabChanged(this.tabIndex);
}

class DeleteStockRequested extends StockEvent {
  final int index;

  const DeleteStockRequested(this.index);
}

class SortStocksRequested extends StockEvent {
  final String type;

  const SortStocksRequested(this.type);
}

class SaveWatchlistRequested extends StockEvent {
  final List<Stock> updatedList;

  const SaveWatchlistRequested(this.updatedList);
}

class RefreshPricesRequested extends StockEvent {
  const RefreshPricesRequested();
}