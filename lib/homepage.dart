import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double purchasePrice = 0;
  double downPayment = 0;
  double repaymentTime = 0;
  double loanamount = 0;
  double interest = 0;
  double estimatepermonth = 0;

  void calculateMonthlyPayment() {
    if (purchasePrice <= 0 ||
        downPayment <= 0 ||
        repaymentTime <= 0 ||
        interest <= 0) {
      setState(() {
        loanamount = 0;
        estimatepermonth = 0;
      });
      return;
    }

    loanamount = purchasePrice - downPayment;

    double monthlyInterestRate = interest / 100 / 12;
    double numPayments = repaymentTime * 12;

    double temp = pow(1 + monthlyInterestRate, numPayments).toDouble();
    estimatepermonth = (loanamount * monthlyInterestRate * temp) / (temp - 1);

    setState(() {
      loanamount = loanamount;
      estimatepermonth = estimatepermonth;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.simpleCurrency(decimalDigits: 0);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 199, 200, 209),
              Color.fromARGB(255, 173, 176, 199)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Mortgage Calculator',
                    style:
                        TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  'Purchase Price: ${currencyFormatter.format(purchasePrice)}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Slider(
                  thumbColor: Colors.indigo[400],
                  activeColor: Colors.indigo[400],
                  inactiveColor: Colors.white,
                  value: purchasePrice,
                  min: 0,
                  max: 1000000,
                  divisions: 100,
                  onChanged: (value) {
                    setState(() {
                      purchasePrice = value;
                    });
                  },
                ),
                const SizedBox(height: 25),
                Text(
                  'Down Payment: ${currencyFormatter.format(downPayment)}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Slider(
                  thumbColor: Colors.indigo[400],
                  activeColor: Colors.indigo[400],
                  inactiveColor: Colors.white,
                  value: downPayment,
                  min: 0,
                  max: 1000000,
                  divisions: 100,
                  onChanged: (value) {
                    setState(() {
                      downPayment = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Repayment Time: ${repaymentTime.toInt()} years.',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Slider(
                  thumbColor: Colors.indigo[400],
                  activeColor: Colors.indigo[400],
                  inactiveColor: Colors.white,
                  value: repaymentTime,
                  min: 0,
                  max: 50,
                  divisions: 50,
                  onChanged: (values) {
                    setState(() {
                      repaymentTime = values;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Interest Rate: ${interest.toStringAsFixed(2)}%',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Slider(
                  thumbColor: Colors.indigo[400],
                  activeColor: Colors.indigo[400],
                  inactiveColor: Colors.white,
                  value: interest,
                  min: 0,
                  max: 25,
                  divisions: 100,
                  onChanged: (values) {
                    setState(() {
                      interest = values;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Loan amount',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Text(
                  currencyFormatter.format(loanamount),
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 26.0),
                const Text(
                  'Estimated pr. month:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Text(
                  currencyFormatter.format(estimatepermonth),
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    height: 55,
                    padding: const EdgeInsets.all(16.0),
                    onPressed: calculateMonthlyPayment,
                    color: Color.fromARGB(255, 86, 77, 219),
                    textColor: Colors.white,
                    child: const Text("Get a mortgage quote"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
