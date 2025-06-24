import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/theme.dart';
import 'package:flutter_application_1/pages/user_home_page.dart';
import 'location_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await LocationService.getCurrentLocation();
    print("Izin lokasi didapat");
  } catch (e) {
    print("Gagal dapat lokasi: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Roti',
      debugShowCheckedModeBanner: false,
      theme: pinkTheme,
      home: const UserHomePage(),
    );
  }
}
