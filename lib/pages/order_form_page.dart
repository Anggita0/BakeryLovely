import 'package:flutter/material.dart';
import '../models/products.dart';
import '../helpers/database_helper.dart';
import '../models/order.dart';
import '../location_service.dart';

class OrderFormPage extends StatefulWidget {
  final Product product;
  const OrderFormPage({super.key, required this.product});

  @override
  State<OrderFormPage> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();

  bool _loading = false;

  void _submitOrder() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      final pos = await LocationService.getCurrentLocation();
      final quantity = int.parse(_quantityController.text);

      await DatabaseHelper.instance.insertOrder(
        Order(
          productId: widget.product.id!,
          customerName: _nameController.text,
          quantity: quantity,
          latitude: pos.latitude,
          longitude: pos.longitude,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Produk berhasil dipesan!")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal: $e")),
      );
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(title: const Text("Form Pemesanan")),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text("Harga: Rp${product.price}"),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: "Nama Pemesan",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Wajib diisi' : null,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _quantityController,
                      decoration: const InputDecoration(
                        labelText: "Jumlah",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        final num = int.tryParse(val ?? '');
                        if (num == null || num <= 0) return 'Jumlah tidak valid';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    ElevatedButton.icon(
                      onPressed: _submitOrder,
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text("Pesan"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
