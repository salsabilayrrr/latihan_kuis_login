import 'package:flutter/material.dart';

import 'models/food_item.dart';

class DetailPage extends StatefulWidget {
  final FoodItem foodItem;        // Menerima data makanan yang dipilih
  //artinya:
  //FoodItem → tipe datanya, yaitu class FoodItem
  //foodItem → nama variabel/parameter, ini kita yang menentukan
  //Jadi bisa saja namanya kamu ubah.

//Huruf kecil foodItem karena itu nama variabel, sedangkan FoodItem huruf besar karena itu nama class. 
//Ini mengikuti aturan penamaan Dart: nama class biasanya UpperCamelCase, sedangkan variabel lowerCamelCase.



  const DetailPage({super.key, required this.foodItem});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // Controller untuk mengatur teks angka di dalam TextField
  late TextEditingController _controller;





  //menambah variabel untuk tombol beda warna 
  // Variabel untuk melacak index tingkat kepedasan (0: Tidak Pedas, 1: Sedang, 2: Super Pedas)
  int _levelPedasIndex = 0;
  //bisa aja dihapus nih jadi dari class langusng ke override



  // Daftar warna dan teks keterangan untuk masing-masing tingkat kepedasan
  final List<Color> _warnaLevel = [Colors.green, Colors.orange, Colors.red];
  final List<String> _teksLevel = [
    'Tidak Pedas (Level 0)', 
    'Pedas Sedang (Level 1)', 
    'Super Pedas (Level 2)'
  ];






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
      appBar: AppBar(
        title: Text(widget.foodItem.name),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          // 👈 Fitur Favorite di pojok kanan atas DetailPage
          IconButton(
            icon: Icon(
              widget.foodItem.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: widget.foodItem.isFavorite ? Colors.red : Colors.white,
            ),
            tooltip: 'Favorit',
            onPressed: () {
              setState(() {
                // Membalik status favorit (True jadi False, False jadi True)
                widget.foodItem.isFavorite = !widget.foodItem.isFavorite;
              });
            },
          ),
        ],
        ),

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






  //menambah tombol berubah warna
  // 5. Bagian Pilihan Tingkat Kepedasan (Tombol Interaktif 3 Warna)
            const Text(
              'Pilih Tingkat Kepedasan:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // Warna latar belakang tombol berubah otomatis sesuai index aktif
                  backgroundColor: _warnaLevel[_levelPedasIndex],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  setState(() {
                    // Berputar dari 0 -> 1 -> 2 -> kembali ke 0 secara berulang
                    _levelPedasIndex = (_levelPedasIndex + 1) % _warnaLevel.length;
                  });
                },
                child: Text(
                  '🌶️ Status: ${_teksLevel[_levelPedasIndex]}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
          ),






            const SizedBox(height: 10),
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






          //kalo mau button + dan -
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ← TOMBOL KURANG (-)
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (widget.foodItem.quantity > 0) {
                        widget.foodItem.quantity--;  // ← Kurangi 1
                      }
                    });
                  },
                  icon: const Icon(Icons.remove_circle),
                  iconSize: 32,
                  color: Colors.orange,
                ),
                
                const SizedBox(width: 20),

                // ← TAMPILAN ANGKA
                Text(
                  '${widget.foodItem.quantity}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(width: 20),

                // ← TOMBOL TAMBAH (+)
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.foodItem.quantity++;  // ← Tambah 1
                    });
                  },
                  icon: const Icon(Icons.add_circle),
                  iconSize: 32,
                  color: Colors.orange,
                ),
              ],
            ),
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
            // 7. Tombol Selesai 
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
