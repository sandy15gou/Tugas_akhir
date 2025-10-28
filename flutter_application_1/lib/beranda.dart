import 'package:flutter/material.dart';

// ====================== MAIN APP ======================
class SMPN1App extends StatelessWidget {
  const SMPN1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMPN 1 Kota Jambi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorSchemeSeed: const Color(0xFF1E3C72),
      ),
      home: const BerandaPage(),
    );
  }
}

// ====================== BERANDA PAGE ======================
class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> staffList = [
      {"nama": "Budi Santoso", "jabatan": "Guru Matematika"},
      {"nama": "Siti Rahmawati", "jabatan": "Guru Bahasa Indonesia"},
      {"nama": "Andi Pratama", "jabatan": "Guru IPA"},
      {"nama": "Lestari Wulandari", "jabatan": "Guru IPS"},
      {"nama": "Rina Kartika", "jabatan": "Guru Bahasa Inggris"},
      {"nama": "Dedi Suhendra", "jabatan": "Guru PJOK"},
      {"nama": "Fitri Ananda", "jabatan": "Guru Seni Budaya"},
      {"nama": "Agus Saputra", "jabatan": "Guru PPKn"},
      {"nama": "Nanda Amelia", "jabatan": "Guru Agama"},
      {"nama": "Rafi Maulana", "jabatan": "Guru TIK"},
      {"nama": "Dewi Lestari", "jabatan": "Staf Administrasi"},
      {"nama": "Fajar Nugroho", "jabatan": "Staf Keuangan"},
      {"nama": "Indah Permata", "jabatan": "Pustakawan"},
      {"nama": "Roni Hidayat", "jabatan": "Petugas Kebersihan"},
      {"nama": "Taufik Rahman", "jabatan": "Satpam"},
    ];

    final List<Map<String, dynamic>> programUnggulan = [
      {"icon": Icons.sports_volleyball, "nama": "Bola Voli"},
      {"icon": Icons.emoji_people, "nama": "Pramuka"},
      {"icon": Icons.sports_soccer, "nama": "Futsal"},
      {"icon": Icons.sports_tennis, "nama": "Badminton"},
      {"icon": Icons.sports_kabaddi, "nama": "Sepak Takraw"},
      {"icon": Icons.sports_basketball, "nama": "Basket"}, // 🏀 Tambahan baru
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'SMPN 1 KOTA JAMBI',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==== KEPALA SEKOLAH ====
            _kepalaSekolahCard(),

            const SizedBox(height: 24),

            // ==== PRESTASI SEKOLAH ====
            const Text(
              'Prestasi Sekolah',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF1E3C72),
              ),
            ),
            const SizedBox(height: 12),

            _prestasiCard(
              icon: Icons.sports_soccer,
              title: 'Tim Futsal SMPN 1 Kota Jambi',
              description:
                  'Juara 1 Turnamen Futsal Antar SMP se-Kota Jambi tahun 2024. Prestasi luar biasa yang mengharumkan nama sekolah.',
              color: Colors.blue.shade50,
              iconColor: Colors.blue,
            ),
            const SizedBox(height: 16),
            _prestasiCard(
              icon: Icons.menu_book,
              title: 'Prestasi Tahfidz Qur’an',
              description:
                  'Siswa SMPN 1 Kota Jambi menjuarai lomba Tahfidz 5 Juz tingkat provinsi tahun 2024, menjadi inspirasi bagi siswa lain.',
              color: Colors.green.shade50,
              iconColor: Colors.green,
            ),

            const SizedBox(height: 24),

            // ==== PROGRAM UNGGULAN ====
            const Text(
              'Program Unggulan Sekolah',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF1E3C72),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: programUnggulan.map((program) {
                return _programCard(program["icon"], program["nama"]);
              }).toList(),
            ),

            const SizedBox(height: 24),

            // ==== GURU & STAF ====
            const Text(
              'Guru & Staf SMPN 1 Kota Jambi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF1E3C72),
              ),
            ),
            const SizedBox(height: 12),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: ExpansionTile(
                leading: const Icon(Icons.group, color: Color(0xFF1E3C72)),
                title: const Text(
                  "Guru dan Staf SMPN 1 Kota Jambi",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: staffList.map((staff) {
                  return ListTile(
                    leading: const Icon(Icons.person_outline,
                        color: Colors.blueAccent),
                    title: Text(staff["nama"]!,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(staff["jabatan"]!),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      // ==== NAVBAR BAWAH ====
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: ''),
        ],
      ),
    );
  }

  // ==== COMPONENTS ====

  Widget _kepalaSekolahCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      shadowColor: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/kepala_sekolah.png',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'KEPALA SEKOLAH',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF1E3C72)),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ibu Sri adalah kepala sekolah yang dikenal dengan kepemimpinan inspiratif dan dedikasi tinggi terhadap pendidikan di SMPN 1 Kota Jambi.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _prestasiCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required Color iconColor,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
              padding: const EdgeInsets.all(12),
              child: Icon(icon, color: Colors.white, size: 36),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF1E3C72))),
                  const SizedBox(height: 6),
                  Text(description,
                      style: const TextStyle(color: Colors.black87)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _programCard(IconData icon, String nama) {
    return Container(
      width: 165,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2A5298), Color(0xFF1E3C72)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 3))
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 50),
          const SizedBox(height: 8),
          Text(
            nama,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// ====================== LOGIN PAGE ======================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final nipController = TextEditingController();
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // Background Gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        // Back Button
        Positioned(
          top: 40,
          left: 20,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(2, 3),
                  )
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.arrow_back, color: Color(0xFF1E3C72)),
            ),
          ),
        ),

        // Login Card
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              color: Colors.white.withOpacity(0.95),
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.school,
                        size: 80, color: Color(0xFF1E3C72)),
                    const SizedBox(height: 16),
                    const Text("Login Akun SMPN 1 Kota Jambi",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3C72))),
                    const SizedBox(height: 30),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      decoration: InputDecoration(
                        labelText: "Masuk sebagai",
                        prefixIcon: const Icon(Icons.badge_outlined),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      items: const [
                        DropdownMenuItem(value: "Siswa", child: Text("Siswa")),
                        DropdownMenuItem(
                            value: "Staf/Guru", child: Text("Staf / Guru")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value;
                        });
                      },
                    ),

                    if (selectedRole == "Staf/Guru") ...[
                      const SizedBox(height: 16),
                      TextField(
                        controller: nipController,
                        decoration: InputDecoration(
                          labelText: 'Masukkan NIP',
                          prefixIcon:
                              const Icon(Icons.credit_card_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3C72),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () {
                          if (selectedRole == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Silakan pilih peran terlebih dahulu!')),
                            );
                            return;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Login sebagai ${selectedRole!} berhasil!')),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text("Lupa Password?",
                                style: TextStyle(color: Colors.grey))),
                        TextButton(
                            onPressed: () {},
                            child: const Text("Registrasi",
                                style: TextStyle(color: Colors.grey))),
                      ],
                    ),
                    const Divider(height: 32, color: Colors.grey),
                    const Text("Atau masuk dengan",
                        style: TextStyle(color: Colors.black54)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialButton(Icons.g_mobiledata, Colors.red),
                        const SizedBox(width: 20),
                        _socialButton(Icons.facebook, Colors.blue),
                        const SizedBox(width: 20),
                        _socialButton(Icons.apple, Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget _socialButton(IconData icon, Color color) {
    return Container(
      decoration:
          BoxDecoration(color: color, shape: BoxShape.circle),
      padding: const EdgeInsets.all(10),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}

void main() {
  runApp(const SMPN1App());
}
