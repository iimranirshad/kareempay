import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _amountController = TextEditingController();
  final double _dueAmount = 250.00;

  final _formKey = GlobalKey<FormState>();

  void _handlePay() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context); // Close the screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment Successful')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF253326),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hi, Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFF1A261C),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A261C),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Amount Due",
                        style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 10),
                    Text("RS ${_dueAmount.toStringAsFixed(2)}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    const Text("Due Date",
                        style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 5),
                    const Text("May 15, 2024",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF253326),
                          hintText: 'Enter amount to pay',
                          hintStyle: const TextStyle(color: Colors.white54),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }
                          final double? enteredAmount = double.tryParse(value);
                          if (enteredAmount == null) {
                            return 'Enter a valid number';
                          }
                          if (enteredAmount <= 0) {
                            return 'Amount must be greater than zero';
                          }
                          if (enteredAmount > _dueAmount) {
                            return 'Cannot exceed due amount (\$${_dueAmount.toStringAsFixed(2)})';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handlePay,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B4D3B),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text("Pay",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
