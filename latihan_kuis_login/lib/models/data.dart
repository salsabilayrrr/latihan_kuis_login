class User {
  String username;
  String password;
  String nama;

  User({
    required this.username,
    required this.password,
    required this.nama,
  });
}

// Data akun tiruan untuk login
User user1 = User(
  username: 'budi123',
  password: 'password123',
  nama: 'Budi Santoso',
);