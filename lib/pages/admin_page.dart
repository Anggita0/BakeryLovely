import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import 'product_list_page.dart'; 
import 'user_home_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _currentIndex = 0;

  // Data pesanan
  List<Map<String, dynamic>> _orders = [];
  bool _loadingOrders = false;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() => _loadingOrders = true);
    final orders = await DatabaseHelper.instance.getOrdersWithProductName();
    setState(() {
      _orders = orders;
      _loadingOrders = false;
    });
  }

  // Tab Produk (pakai ProductListPage langsung)
  Widget _buildProductTab() {
    return const ProductListPage(isInTab: true);
  }

  // Tab Pesanan
  Widget _buildOrderTab() {
    if (_loadingOrders) return const Center(child: CircularProgressIndicator());

    return RefreshIndicator(
      onRefresh: _loadOrders,
      child: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final o = _orders[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              title: Text(o['product_name'] ?? 'Produk'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pemesan: ${o['customer_name']}'),
                  Text('Jumlah: ${o['quantity']} x Rp${o['price']}'),
                  Text('Total: Rp${o['total']}'),
                  Text('Lokasi: (${o['latitude']}, ${o['longitude']})'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Tab Profil
  Widget _buildProfileTab() {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.swap_horiz),
        label: const Text("Masuk sebagai User"),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const UserHomePage()),
          );
        },
      ),
    );
  }

  final List<Widget> _tabs = [];

  @override
  Widget build(BuildContext context) {
    _tabs.clear();
    _tabs.addAll([
      _buildProductTab(),
      _buildOrderTab(),
      _buildProfileTab(),
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bakery Lovely Admin'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: 'Produk'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Pesanan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
