import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";
  String _expression = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _expression = "";
      } else if (buttonText == "=") {
        try {
          _output = _evaluateExpression(_expression);
        } catch (e) {
          _output = "Error";
        }
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
        _expression += buttonText;
      }
    });
  }

  String _evaluateExpression(String expression) {
    try {
      const evaluator = ExpressionEvaluator();
      final parsedExpression = Expression.parse(expression);
      final result = evaluator.eval(parsedExpression, {});
      return result.toString();
    } catch (e) {
      return "Error";
    }
  }

  Widget _buildButton(String buttonText) {
    final bool isOperator = ["+", "-", "*", "/"].contains(buttonText);
    final Color buttonColor = buttonText == "C"
        ? Colors.orangeAccent
        : buttonText == "="
            ? Colors.blue.shade900
            : isOperator
                ? Colors.blue
                : Colors.grey[200]!; // default color

    final Color textColor = isOperator || buttonText == "=" ? Colors.white : Colors.black;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: buttonColor,
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        title: const Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            // color: Colors.grey[100],
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: <Widget>[
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/")
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("*")
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-")
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("."),
                  _buildButton("0"),
                  _buildButton("00"),
                  _buildButton("+")
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("C"),
                  _buildButton("="),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}


