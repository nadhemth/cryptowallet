import 'package:flutter/material.dart';
import 'AddFundsScreen.dart';
import 'BuyScreen.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  // Total balance is initially in USD
  double totalBalance = 1000.00;

  // List of available currencies with their prices and sample amounts
  final List<Map<String, dynamic>> currencies = [
    {
      'name': 'BTC',
      'price': 60000,
      'amount': 0, // Sample amount
    },
    {
      'name': 'ETH',
      'price': 3000,
      'amount': 0, // Sample amount
    },
    {
      'name': 'BNB',
      'price': 250,
      'amount': 0, // Sample amount
    },
    {
      'name': 'USDT',
      'price': 1,
      'amount': 0, // Sample amount
    },
    {
      'name': 'USD',
      'price': 1.00,
      'amount': 1000.0, // USD always 1:1
    },
  ];

  // Initially selected currency is USD
  String selectedCurrency = 'USD';

  // Function to navigate to the AddFunds screen
  void _navigateToAddFunds() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddFundsScreen()),
    );
  }

  // Function to navigate to the Buy screen
  void _navigateToBuy(String currencyName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BuyScreen(currencyName: currencyName)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the selected currency data
    final selectedCurrencyData = currencies.firstWhere((currency) => currency['name'] == selectedCurrency);
    final selectedCurrencyAmount = selectedCurrencyData['amount'];
    final selectedCurrencyPrice = selectedCurrencyData['price'];

    // Calculate USD equivalent if the selected currency is not USD
    final usdEquivalent = selectedCurrency == 'USD'
        ? selectedCurrencyAmount
        : selectedCurrencyAmount * selectedCurrencyPrice;

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
            Row(
              children: [
                Text(
                  selectedCurrency == 'USD'
                      ? '\$${totalBalance.toStringAsFixed(2)}'
                      : '${selectedCurrencyAmount.toStringAsFixed(4)}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedCurrency,
                  onChanged: (String? newCurrency) {
                    setState(() {
                      selectedCurrency = newCurrency!;
                    });
                  },
                  dropdownColor: const Color(0xFF39475B),
                  style: TextStyle(color: Colors.white),
                  items: currencies.map<DropdownMenuItem<String>>((currency) {
                    return DropdownMenuItem<String>(
                      value: currency['name'],
                      child: Text(currency['name']),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 10),
            if (selectedCurrency != 'USD')
              Text(
                '≈ \$${(usdEquivalent).toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white70, fontSize: 12),
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
