class User {
  final int? id;
  final String username;
  final String password;
  final String role; // 'siswa', 'guru', 'admin'
  final String nama;
  final String? nis; // untuk siswa
  final String? nip; // untuk guru
  final String? kelas; // untuk siswa (7A, 8B, 9C, dll)

  User({
    this.id,
    required this.username,
    required this.password,
    required this.role,
    required this.nama,
    this.nis,
    this.nip,
    this.kelas,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'role': role,
      'nama': nama,
      'nis': nis,
      'nip': nip,
      'kelas': kelas,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      role: map['role'],
      nama: map['nama'],
      nis: map['nis'],
      nip: map['nip'],
      kelas: map['kelas'],
    );
  }
}

