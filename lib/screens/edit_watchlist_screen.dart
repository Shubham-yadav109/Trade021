import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/stock_bloc.dart';
import '../bloc/stock_event.dart';
import '../models/stock_model.dart';
class EditWatchlistScreen extends StatefulWidget {
  const EditWatchlistScreen({super.key});
  @override
  State<EditWatchlistScreen> createState() => _EditWatchlistScreenState();
}
class _EditWatchlistScreenState extends State<EditWatchlistScreen> {
  List<Stock> localList = [];
  @override
  void initState() {
    super.initState();
    final bloc = context.read<StockBloc>();
    localList = List.from(bloc.state.currentList); // copy data
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<StockBloc>();
    final selected = bloc.state.selectedTab;
    String title = selected == 0 ? "Watchlist 1" : selected == 1 ? "Watchlist 5" : "Watchlist 6";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Edit Watchlist"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Icon(Icons.edit),
              ],
            ),
          ),
          Expanded(
            child: ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  final item = localList.removeAt(oldIndex);
                  localList.insert(
                    newIndex > oldIndex ? newIndex - 1 : newIndex,
                    item,
                  );
                });
              },
              children: [
                for (int i = 0; i < localList.length; i++)
                  ListTile(
                    key: ValueKey(localList[i].name),
                    leading: Icon(Icons.drag_handle),
                    title: Text(localList[i].name),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          localList.removeAt(i);
                        });
                      },
                    ),
                  )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Edit Other Watchlists",
                      style: TextStyle(color: Colors.black,fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<StockBloc>().add(
                        SaveWatchlist(localList),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Save Watchlist",
                      style: TextStyle(color: Colors.white,fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}