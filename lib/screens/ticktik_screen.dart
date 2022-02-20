import 'package:flutter/material.dart';
import 'package:famfam/screens/components/body.dart';

class TickTikScreen extends StatelessWidget {
  const TickTikScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TickBody(),
    );
  }
}
