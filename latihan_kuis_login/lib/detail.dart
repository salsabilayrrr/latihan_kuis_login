import 'package:flutter/material.dart';

import 'models/food_item.dart';

class DetailPage extends StatefulWidget {
  final FoodItem foodItem;
  const DetailPage({super.key, required this.foodItem});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // Controller untuk mengatur teks angka di dalam TextField
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.foodItem.quantity.toString(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.foodItem.name)),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Gambar Makanan (Ukuran Lebih Besar)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.foodItem.imageUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),
            // 2. Nama Makanan
            Text(
              widget.foodItem.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),
            // 3. Harga Satuan
            Text(
              'Rp ${widget.foodItem.formattedPrice} / porsi',
              style: const TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            // 4. Deskripsi Lengkap
            const SizedBox(height: 12),
            Text(
              widget.foodItem.description,
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
            const Divider(height: 32),

            // 5. Input Jumlah Porsi
            const Text(
              'Jumlah Porsi: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),

            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              keyboardType:
                  TextInputType.number, // Memunculkan keyboard angka di HP
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan jumlah porsi',
              ),
              onChanged: (value) {
                setState(() {
                  // a. Terjemahkan teks ketikan ke angka bulat (kalau kosong/salah, jadikan 0)
                  int parsedValue = int.tryParse(value) ?? 0;
                  // b. Masukkan angka hasil terjemahan tadi ke dalam data jumlah porsi makanan
                  widget.foodItem.quantity = parsedValue;
                });
              },
            ),

            // 6. Total Harga Dinamis (Ikut berubah saat jumlah porsi diketik)
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp ${widget.foodItem.formattedTotal}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            // 7. Tombol Selesai / Kembali
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Simpan Pemesanan',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
