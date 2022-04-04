import 'package:countriescode/route/routes.dart';
import 'package:countriescode/ui/countries_panel.dart';
import 'package:flutter/material.dart';

class ScreenOne extends StatefulWidget {
  ScreenOne({Key? key}) : super(key: key);

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen One"),
      ),
      body: bodyDesign(),
    );
  }

  bodyDesign() {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () {
          Routes.navigate(context, child: const CountriesPanel());
        },
        child: const Text(
          'Click to Navigate',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
