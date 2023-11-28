import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view/home_view/home_view.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/splash_pic.jpg',
                fit: BoxFit.cover,
                height: height * .5,
                width: width * .9,
              ),
            ),
            SizedBox(
              height: height * .04,
            ),
            Text(
              'TOP HEADLINE',
              style: GoogleFonts.anton(
                color: Colors.grey.shade700,
                letterSpacing: 6,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: height * .04,
            ),
            const SpinKitChasingDots(
              color: Colors.blue,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
