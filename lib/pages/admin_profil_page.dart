import 'package:flutter/material.dart';
import 'user_home_page.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Admin')),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.switch_account),
          label: const Text("Masuk sebagai User"),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const UserHomePage()),
            );
          },
        ),
      ),
    );
  }
}
