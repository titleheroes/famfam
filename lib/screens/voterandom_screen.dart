import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:famfam/screens/components/body.dart';

class VoteRandomScreen extends StatelessWidget {
  const VoteRandomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: VoteRandomBody(),
    );
  }
}
