import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';

class AdminOrdersPage extends StatefulWidget {
  const AdminOrdersPage({super.key});

  @override
  State<AdminOrdersPage> createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends State<AdminOrdersPage> {
  List<Map<String, dynamic>> _orders = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() => _loading = true);
    final orders = await DatabaseHelper.instance.getOrdersWithProductName();
    setState(() {
      _orders = orders;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesanan Masuk')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadOrders,
              child: ListView.builder(
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  final o = _orders[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
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
            ),
    );
  }
}
