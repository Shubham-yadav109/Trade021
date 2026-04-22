import 'package:flutter/material.dart';
import '../models/stock_model.dart';
class StockTile extends StatelessWidget {
  final Stock stock;
  const StockTile({required Key key, required this.stock}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isUp = stock.change >= 0;
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stock.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 2),
              Text(
                stock.type,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                stock.price.toStringAsFixed(2),
                style: TextStyle(
                  color: isUp ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "${isUp ? "+" : ""}${stock.change.toStringAsFixed(2)} "
                    "(${stock.change.toStringAsFixed(2)}%)",
                style: TextStyle(
                  color: isUp ? Colors.green : Colors.red,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}