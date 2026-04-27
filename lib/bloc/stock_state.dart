import '../models/stock_model.dart';
class StockState {
  final List<List<Stock>> watchlists;
  final int selectedTab;
  StockState({
    required this.watchlists,
    required this.selectedTab,
  });
  List<Stock> get currentList => watchlists[selectedTab];
  StockState copyWith({
    List<List<Stock>>? watchlists,
    int? selectedTab,
  }) {
    return StockState(
      watchlists: watchlists ?? this.watchlists,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}