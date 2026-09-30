import 'package:flutter/material.dart';

import 'models/food_item.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {



  // kalo home mau ubah menjadi nama
  // final String namaUser;


  final String namaUsername;

  final List<FoodItem> foodList;
  //final List<FoodItem> foodList;
  //Artinya: Ini adalah variabel penampung data di dalam halaman home. 
  //Variabel ini bertugas menerima kiriman daftar data makanan (FoodItem) yang dikirimkan dari pusat navigasi (root.dart) agar bisa ditampilkan berderet ke bawah di layar.

  const HomePage({
    super.key, 



    //kalo mau menampilkan nama 
    // required this.namaUser, 



    required this.namaUsername,
    required this.foodList});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(


            //kalo mau home pake nama
            // 'Halo, ${widget.namaUser}',



            
            'Halo, ${widget.namaUsername}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            // 1. Kotak Utama: Menyediakan daftar yang bisa di-scroll ke bawah
            itemCount: widget.foodList.length,
            itemBuilder: (context, index) {
              final food = widget.foodList[index];
              //food yang kecil itu nama variabel yang kamu buat sendiri. 
              //Jadi bukan nama khusus dari Flutter dan bukan harus food.
              //bisa dibaca: Ambil satu makanan dari foodList pada posisi index, 
              //lalu simpan sementara dengan nama food."


              return Card(
                // 2. Kotak Kartu: Memberi efek tampilan kartu melayang
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                elevation: 2,
                child: ListTile(
                  // 3. Kotak Baris Menu: Mengatur tata letak standar menu
                  contentPadding: EdgeInsets.all(10),
                  //Menampilkan gambar makanan di sebelah kiri
                  leading: ClipRRect(
                    // -> Isi Kiri: Gambar Makanan
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      food.imageUrl,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),

                  //nama makanan
                  title: Text(
                    // -> Isi Tengah: Nama Makanan
                    food.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),




                  // 👈 TAMBAHAN: Tombol Favorite (Ikon Hati) di sebelah kanan (trailing)
                  trailing: IconButton(
                    icon: Icon(
                      
                    //kalo icon panah ke kanan itu namanya Icon.arrow_forward kalo back ke kiri upward ke atas downward ke bawah
                    //kalo siku itu Icons.chevron_right

                      food.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: food.isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        // Membalik status isFavorite (True <-> False)
                        food.isFavorite = !food.isFavorite;
                      });
                    },
                  ),





                  //deskripsi, jumlah porsi, dan total harga di bagian bawah nama
                  subtitle: Column(
                    //-> Isi Bawah: Disusun ke bawah (Vertikal)
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        food.description, //-> Deskripsi Makanan
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),

                      const SizedBox(height: 8),
                      Row(
                        // Row Utama untuk memisahkan Kiri (Porsi + Harga Satuan) dan Kanan (Total Harga)
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${food.quantity} porsi', // -> Porsi (di kiri)
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 2),
                              Text(
                                '${food.price}/ porsi', // -> Porsi (di kiri)
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Rp ${food.formattedTotal}', // -> Harga (di kanan)
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Aksi ketika item menu diklik untuk membuka halaman detail
                  onTap: () {
                    // 4. Aksi Sentuh: Tombol klik untuk pindah halaman
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(foodItem: food),
                        //foodItem karena sebagai penampung di detail Page bukan FoodItem yg merupakan class di food_item.dart
                      ),
                    ).then((_) {
                      setState(() {});
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
