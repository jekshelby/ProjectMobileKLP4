import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = ''; 
  var userAnswer = ''; 
  final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[900]);

  final List<String> buttons = [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', ',', 'Ans', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(children: <Widget>[
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userQuestion,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                // Tombol Clear (C)
                if (index == 0) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion = ''; 
                        userAnswer = ''; 
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.green,
                    textColor: Colors.white,
                  );
                } 
                // Tombol Ans
                else if (index == buttons.length - 2) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion += userAnswer; 
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.blue,
                    textColor: Colors.white,
                  );
                }
                // Tombol Delete (DEL)
                else if (index == 1) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        if (userQuestion.isNotEmpty) {
                          userQuestion = userQuestion.substring(0, userQuestion.length - 1);
                        }
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.red,
                    textColor: Colors.white,
                  );
                }
                // Tombol Sama Dengan (=)
                else if (index == buttons.length - 1) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        equalPressed(); 
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                  );
                }
                // Tombol lainnya
                else {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        if (isOperator(buttons[index])) {
                          userQuestion += ' ${buttons[index]} ';
                        } else {
                          userQuestion = _formatNumberInput(userQuestion + buttons[index]);
                        }
                      });
                    },
                    buttonText: buttons[index],
                    color: isOperator(buttons[index]) ? Colors.deepPurple : Colors.white,
                    textColor: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
                  );
                }
              },
            ),
          ),
        ),
      ]), 
    );
  }

  String _formatNumberInput(String input) {
    String cleanInput = input.replaceAll('.', ''); // Menghapus titik dari input
    try {
      double number = double.parse(cleanInput); 
      final formatter = NumberFormat('#,###', 'en_US'); 
      return formatter.format(number);
    } catch (e) {
      return input; // Jika gagal, kembalikan input asli
    }
  }

  bool isOperator(String x) {
    return ['%', '/', 'x', '-', '+', '='].contains(x);
  }

  void equalPressed() {
    try {
      String finalQuestion = userQuestion.replaceAll('x', '*'); 
      finalQuestion = finalQuestion.replaceAll('.', ''); // Menghapus titik sebelum menghitung

      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // Format hasil akhir dengan titik sebagai pemisah ribuan
      final formatter = NumberFormat('#,###', 'en_US');
      userAnswer = formatter.format(eval);
    } catch (e) {
      userAnswer = 'Error'; // Tangani kesalahan
    }
  }

  String formatNumber(String number) {
    if (number.isEmpty) {
      return '';
    }
    try {
      String cleanedNumber = number.replaceAll('.', ''); // Hapus titik yang sudah ada
      final formatter = NumberFormat('#,###', 'en_US');
      return formatter.format(double.parse(cleanedNumber));
    } catch (e) {
      return number;
    }
  }
}
