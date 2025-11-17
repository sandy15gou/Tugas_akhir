import 'package:flutter/material.dart';
import 'package:tugas_akhir/Widgets/AppBar.dart';
import 'package:tugas_akhir/Widgets/MainDrawer.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    final List<Map<String, String>> staffList = [
      {"nama": "Siti Nurhaliza", "jabatan": "Guru Matematika"},
      {"nama": "Ahmad Fauzi", "jabatan": "Guru Bahasa Indonesia"},
      {"nama": "Dewi Kusuma", "jabatan": "Guru IPA"},
      {"nama": "Rahmat Hidayat", "jabatan": "Guru IPS"},
      {"nama": "Budi Santoso", "jabatan": "Guru Bahasa Inggris"},
      {"nama": "Pak Agus", "jabatan": "Guru PJOK"},
      {"nama": "Rina Amelia", "jabatan": "Guru Seni Budaya"},
      {"nama": "Hendra Wijaya", "jabatan": "Guru TIK"},
      {"nama": "Ustadz Yusuf", "jabatan": "Guru Pendidikan Agama"},
      {"nama": "Fitri Handayani", "jabatan": "Guru Prakarya"},
      {"nama": "Ibu Ratna", "jabatan": "Guru Bahasa Daerah"},
      {"nama": "Sri Wahyuni", "jabatan": "Staf Administrasi"},
      {"nama": "Andi Pratama", "jabatan": "Pustakawan"},
      {"nama": "Bambang Susilo", "jabatan": "Petugas Kebersihan"},
      {"nama": "Dedi Suhendra", "jabatan": "Satpam"},
    ];

    final List<Map<String, dynamic>> programUnggulan = [
      {"icon": Icons.sports_volleyball, "nama": "Bola Voli"},
      {"icon": Icons.emoji_people, "nama": "Pramuka"},
      {"icon": Icons.sports_soccer, "nama": "Futsal"},
      {"icon": Icons.sports_tennis, "nama": "Badminton"},
      {"icon": Icons.sports_kabaddi, "nama": "Sepak Takraw"},
      {"icon": Icons.sports_basketball, "nama": "Basket"},
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: CommonAppBar(
        title: "Profil Sekolah",
        menuenabled: true,
        notificationenabled: true,
        ontap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: Drawer(
        elevation: 0,
        child: MainDrawer(),
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
                color: Color(0xFF134B70),
              ),
            ),
            const SizedBox(height: 12),

            _prestasiCard(
              icon: Icons.sports_soccer,
              title: 'Tim Futsal Juara 1',
              description:
                  'Juara 1 Turnamen Futsal Antar SMP se-Kota tahun 2024. Prestasi luar biasa yang mengharumkan nama sekolah.',
              color: Colors.blue.shade50,
              iconColor: Colors.blue,
            ),
            const SizedBox(height: 16),
            _prestasiCard(
              icon: Icons.menu_book,
              title: 'Prestasi Tahfidz Qur\'an',
              description:
                  'Siswa menjuarai lomba Tahfidz 5 Juz tingkat provinsi tahun 2024, menjadi inspirasi bagi siswa lain.',
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
                color: Color(0xFF134B70),
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
              'Guru & Staf Sekolah',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF134B70),
              ),
            ),
            const SizedBox(height: 12),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: ExpansionTile(
                leading: const Icon(Icons.group, color: Color(0xFF134B70)),
                title: const Text(
                  "Guru dan Staf",
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

            const SizedBox(height: 24),

            // ==== KONTAK ====
            const Text(
              'Kontak',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF134B70),
              ),
            ),
            const SizedBox(height: 12),
            _buildContactItem(Icons.email, 'Email', 'smpn1jambi@gmail.com'),
            _buildContactItem(Icons.phone, 'Telepon', '+62 741-123456'),
            _buildContactItem(
                Icons.location_on, 'Alamat', 'Jl. Jendral Sudirman No. 45, Kota Jambi, Jambi 36122'),

            const SizedBox(height: 30),

            // ==== COPYRIGHT ====
            Center(
              child: Column(
                children: [
                  Divider(),
                  SizedBox(height: 10),
                  Text(
                    '© 2025 SMPN 1 Jambi',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'School Management System - All Rights Reserved',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
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
            // Icon Sekolah jika tidak ada foto
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xFF134B70).withAlpha(25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  Icons.school,
                  size: 100,
                  color: Color(0xFF134B70),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'KEPALA SEKOLAH',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF134B70)),
            ),
            const SizedBox(height: 8),
            const Text(
              'Kepala sekolah yang dikenal dengan kepemimpinan inspiratif dan dedikasi tinggi terhadap pendidikan.',
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
                          color: Color(0xFF134B70))),
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
          colors: [Color(0xFF134B70), Color(0xFF508C9B)],
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

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF134B70).withAlpha(25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Color(0xFF134B70), size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

