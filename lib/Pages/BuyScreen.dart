import 'package:flutter/material.dart';

class BuyScreen extends StatefulWidget {
  final String currencyName;

  BuyScreen({required this.currencyName});

  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  bool isBuyingCrypto = true;
  String amount = "";

  void _toggleBuyMode() {
    setState(() {
      isBuyingCrypto = !isBuyingCrypto;
    });
  }

  void _addDigit(String digit) {
    setState(() {
      amount += digit;
    });
  }

  void _deleteDigit() {
    setState(() {
      if (amount.isNotEmpty) {
        amount = amount.substring(0, amount.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
        'Buy',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF212936),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF212936),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isBuyingCrypto ? "I want to pay" : "I want to get",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: _toggleBuyMode,
                  child: Text(isBuyingCrypto ? "By Crypto" : "By Money"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF39475B),
                      hintText: 'Please enter amount',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    controller: TextEditingController(text: amount),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Placeholder for currency change action
                  },
                  child: Row(
                    children: [
                      Icon(Icons.attach_money, color: Colors.white), // Placeholder for currency icon
                      Text(widget.currencyName, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF39475B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Spacer(),
            _buildCustomKeyboard(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: amount.isNotEmpty
                  ? () {
                // Navigate to select payment method
              }
                  : null,
              child: Text(
                  "Select Payment Method",
                  style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB1E457),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomKeyboard() {
    final keys = [
      "1", "2", "3",
      "4", "5", "6",
      "7", "8", "9",
      ".", "0", "⌫"
    ];

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.0,
      ),
      itemCount: keys.length,
      itemBuilder: (context, index) {
        String key = keys[index];
        return InkWell(
          onTap: () {
            if (key == "⌫") {
              _deleteDigit();
            } else if (key == "." && amount.contains(".")) {
              // Prevent adding multiple dots
              return;
            } else {
              _addDigit(key);
            }
          },
          child: Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFF39475B),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                key,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        );
      },
    );
  }
}
