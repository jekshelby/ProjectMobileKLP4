import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'Ans',
    '=',
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
                SizedBox(
                  height: 50,
                ),
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
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemBuilder: (BuildContext context, int index) {
              //Clear Button
              if (index == 0) {
                return MyButton(
                  buttonTapped: () {
                    setState(() {
                      userQuestion = '';
                    });
                  },
                  buttonText: buttons[index],
                  color: Colors.green,
                  textColor: Colors.white,
                );
              }

              //Delete Button
              else if (index == 1) {
                return MyButton(
                  buttonTapped: () {
                    setState(() {
                      userQuestion =
                          userQuestion.substring(0, userQuestion.length - 1);
                    });
                  },
                  buttonText: buttons[index],
                  color: Colors.red,
                  textColor: Colors.white,
                );
              }

              //equals button
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

              //Rest of the buttons
              else {
                return MyButton(
                  buttonTapped: () {
                    setState(() {
                      userQuestion += buttons[index];
                    });
                  },
                  buttonText: buttons[index],
                  color: isOperator(buttons[index])
                      ? Colors.deepPurple
                      : Colors.white,
                  textColor: isOperator(buttons[index])
                      ? Colors.white
                      : Colors.deepPurple,
                );
              }
            },
          )),
        ),
      ]),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQeustion = userQuestion;
    finalQeustion = finalQeustion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQeustion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
