import 'package:flutter/material.dart';
import 'package:famfam/screens/components/body.dart';

class VoteRandomScreen extends StatelessWidget {
  const VoteRandomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VoteRandomBody(),
    );
  }
}
