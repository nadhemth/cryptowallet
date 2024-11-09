import 'package:flutter/material.dart';
import 'AddFundsScreen.dart';
import 'BuyScreen.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  double totalBalance = 1000.00;
  final List<Map<String, dynamic>> currencies = [
    {
      'name': 'Bitcoin',
      'price': 60000.00,
    },
    {
      'name': 'Ethereum',
      'price': 4000.00,
    },
    {
      'name': 'Litecoin',
      'price': 200.00,
    },
  ];

  void _navigateToAddFunds() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddFundsScreen()),
    );
  }

  void _navigateToBuy(String currencyName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BuyScreen(currencyName: currencyName)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF212936),
      ),
      backgroundColor: const Color(0xFF212936),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Balance',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${totalBalance.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToAddFunds,
              child: Text(
                  'Add Funds',
                  style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB1E457), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: currencies.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color(0xFF39475B), // Card color to match background
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: ListTile(
                      title: Text(
                        currencies[index]['name'],
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Price: \$${currencies[index]['price'].toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: TextButton(
                        onPressed: () => _navigateToBuy(currencies[index]['name']),
                        child: Text(
                          'Buy Now',
                          style: TextStyle(
                            color: const Color(0xFFB1E457),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
