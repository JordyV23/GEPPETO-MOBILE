import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConceptsScreen extends StatelessWidget {
  const ConceptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/logo-gpto.svg',
            width: 45,
          ),
          const Text(
            "GEPPETTO",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      )),
    );
  }
}
