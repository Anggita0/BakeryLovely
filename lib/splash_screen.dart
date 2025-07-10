import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/user_home_page.dart'; // pastikan import halaman tujuan

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay 3 detik lalu pindah ke halaman utama
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const UserHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cake_rounded,
              size: 100,
              color: Colors.pink.shade300,
            ),
            const SizedBox(height: 20),
            Text(
              'Bakery Lovely',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
