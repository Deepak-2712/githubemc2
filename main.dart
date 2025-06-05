import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double size = 0;
  String inputValue = "";
  String calculatedValue = "";
  String operator = "";

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width / 5;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Display input value
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                inputValue,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ),

            // Calculator buttons
            Column(
              children: [
                _buildButtonRow(["7", "8", "9", "/"], [Colors.white38, Colors.white38, Colors.white38, Colors.orange]),
                _buildButtonRow(["4", "5", "6", "*"], [Colors.white38, Colors.white38, Colors.white38, Colors.orange]),
                _buildButtonRow(["1", "2", "3", "-"], [Colors.white38, Colors.white38, Colors.white38, Colors.orange]),
                _buildButtonRow(["0", ".", "=", "+"], [Colors.white38, Colors.white38, Colors.orange, Colors.orange]),
              ],
            ),

            // Clear button
            calcButton("clear", Colors.red),
          ],
        ),
      ),
    );
  }

  // Builds a row of calculator buttons
  Widget _buildButtonRow(List<String> texts, List<Color> colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        texts.length,
        (index) => calcButton(texts[index], colors[index]),
      ),
    );
  }

  // Builds a single calculator button
  Widget calcButton(String text, Color backgroundColor) {
    return InkWell(
      onTap: () {
        setState(() {
          if (text == "clear") {
            inputValue = "";
            calculatedValue = "";
            operator = "";
          } else if (["+", "-", "*", "/"].contains(text)) {
            calculatedValue = inputValue;
            inputValue = "";
            operator = text;
          } else if (text == "=") {
            double calc = double.tryParse(calculatedValue) ?? 0;
            double input = double.tryParse(inputValue) ?? 0;

            switch (operator) {
              case "+":
                inputValue = (calc + input).toString();
                break;
              case "-":
                inputValue = (calc - input).toString();
                break;
              case "*":
                inputValue = (calc * input).toString();
                break;
              case "/":
                inputValue = (calc / input).toString();
                break;
            }
          } else {
            inputValue += text;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
        ),
        margin: const EdgeInsets.all(10),
        height: size,
        width: size,
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
