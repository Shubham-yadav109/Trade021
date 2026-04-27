import '../models/stock_model.dart';
abstract class StockEvent {
  const StockEvent();
}
class LoadStocks extends StockEvent {
  const LoadStocks();
}
class ReorderStock extends StockEvent {
  final int oldIndex;
  final int newIndex;
  const ReorderStock(this.oldIndex, this.newIndex);
}
class ChangeTab extends StockEvent {
  final int tabIndex;
  const ChangeTab(this.tabIndex);
}
class DeleteStock extends StockEvent {
  final int index;
  const DeleteStock(this.index);
}
class SortStocks extends StockEvent {
  final String type;
  const SortStocks(this.type);
}
class SaveWatchlist extends StockEvent {
  final List<Stock> updatedList;

  const SaveWatchlist(this.updatedList);
}
class UpdatePrices extends StockEvent {
  const UpdatePrices();
}