import 'package:flutter/material.dart';

import 'login.dart';

class ProfilePage extends StatelessWidget {
  final VoidCallback? onMenuTap; // Fungsi untuk pindah ke tab Menu

  final String namaUser; // 👈 1. Tambahkan variabel penangkap nama di sini
  final String username;

  const ProfilePage({
    super.key,
    this.onMenuTap,
    required this.namaUser, 
    required this.username,// 👈 2. Wajibkan parameter ini saat ProfilePage dipanggil
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),

          // 1. Foto Profil / Avatar
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.orangeAccent,
            child: Icon(Icons.person, size: 60, color: Colors.orange),
          ),

          const SizedBox(height: 16),
          // 2. Nama Pembuat
          Text(
            namaUser,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),



        const SizedBox(height: 4),

          Text(
            '@$username',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 4),






          const SizedBox(height: 4),
          //3. Peran
          const Text(
            'Pelanggan Resto',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),

          const SizedBox(height: 40),
          //4. Kartu Menu 1: Menu Resto
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.restaurant_menu, color: Colors.orange),
              ),

              title: Text(
                'Menu Resto',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              subtitle: const Text(
                'Pesan makanan favorit Anda dengan mudah.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),

              onTap: onMenuTap,
            ),
          ),

          const SizedBox(height: 16),
          // 5. Kartu Menu 2: Pemesanan
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.receipt_long, color: Colors.orange),
              ),
              title: const Text(
                'Pemesanan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: const Text(
                'Jumlah dan harga dihitung otomatis.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
          ),

          //tambahan logout
          const SizedBox(height: 16),

          //OPSI PERTAMA TOMBOL LOGOUT
          // 6. Kartu Tombol Logout (Terpisah rapi sebagai elemen anak dari Column)
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.red, // Warna merah untuk tombol keluar
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.logout, color: Colors.white),
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
              subtitle: const Text(
                'Keluar dari akun Anda.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              onTap: () {
                // Aksi saat tombol Logout diklik
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ),

          //OPSI KEDUA tombol logout ada di halaman profile
          const SizedBox(height: 16),

          // 6. Tombol Logout di dalam Halaman Profil
          SizedBox(
            width: double.infinity, // Membuat tombol melebar penuh
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Warna latar merah
                foregroundColor: Colors.white, // Warna teks & ikon putih
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              icon: const Icon(Icons.logout),
              label: const Text(
                'Logout',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // Aksi saat tombol logout diklik
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
