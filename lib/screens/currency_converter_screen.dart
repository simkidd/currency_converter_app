import 'package:flutter/material.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _amountController = TextEditingController();

  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  final Map<String, double> _conversionRates = {
    'USD': 1.0,
    'EUR': 0.85,
    'GBP': 0.75,
    'NGN': 410.0,
  };

  // function to handle currency conversion
  void _convertCurrency() {
    double amount = double.tryParse(_amountController.text) ?? 0;
    double conversionRate =
        _conversionRates[_toCurrency]! / _conversionRates[_fromCurrency]!;
    double result = amount * conversionRate;

    // show the result in a dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Conversion Result'),
        content: Text(
          '$amount $_fromCurrency = $result $_toCurrency',
          style: const TextStyle(fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount input
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
                hintText: 'Enter amount',
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // Currency selection dropdowns
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _fromCurrency,
                    decoration: const InputDecoration(
                      labelText: 'From',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _fromCurrency = value!;
                      });
                    },
                    items: ['USD', 'EUR', 'GBP', 'NGN']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'To',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _toCurrency = value!;
                      });
                    },
                    items: ['USD', 'EUR', 'GBP', 'NGN']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Conversion button
              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: ElevatedButton(
                onPressed: _convertCurrency,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text('Convert'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
