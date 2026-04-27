import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/stock_bloc.dart';
import '../bloc/stock_event.dart';
import '../bloc/stock_state.dart';
import '../widgets/MarketHeader.dart';
import '../widgets/stock_tile.dart';
import 'edit_watchlist_screen.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}
class _HomeScreen extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (!mounted) return false;
      context.read<StockBloc>().add(UpdatePrices());
      return true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            MarketHeader(),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for instruments",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            BlocBuilder<StockBloc, StockState>(
              builder: (context, state) {
                return Row(
                  children: [
                    _tab(context, "Watchlist 1", 0, state.selectedTab),
                    _tab(context, "Watchlist 5", 1, state.selectedTab),
                    _tab(context, "Watchlist 6", 2, state.selectedTab),
                  ],
                );
              },
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditWatchlistScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.sort),
                  label: Text("Sort by"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<StockBloc, StockState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.currentList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          StockTile(
                            key: ValueKey(state.currentList[index].name),
                            stock: state.currentList[index],
                          ),
                          Divider(
                            height: 1,
                            thickness: 0.8,
                            color: Colors.grey[300],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _tab(BuildContext context, String text, int index, int selected) {
    return GestureDetector(
      onTap: () {
        context.read<StockBloc>().add(ChangeTab(index));
      },
      child: Padding(
        padding: EdgeInsets.only(right: 15),
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                fontWeight: selected == index
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            if (selected == index)
              Container(
                height: 2,
                width: 60,
                color: Colors.black,
              )
          ],
        ),
      ),
    );
  }
}