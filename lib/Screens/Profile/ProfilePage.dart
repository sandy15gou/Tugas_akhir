import 'package:flutter/material.dart';
import 'package:tugas_akhir/Widgets/AppBar.dart';
import 'package:tugas_akhir/Widgets/MainDrawer.dart';
import 'package:tugas_akhir/services/AuthManager.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final user = AuthManager.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(child: Text('User tidak ditemukan')),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(
        title: user.role == 'siswa' ? "Profil Siswa" : user.role == 'guru' ? "Profil Guru" : "Profil",
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
        child: Column(
          children: [
            // Header Card dengan Foto Profil
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF134B70), Color(0xFF508C9B)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  // Foto Profil
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 60, color: Color(0xFF134B70)),
                  ),
                  SizedBox(height: 16),
                  // Nama
                  Text(
                    user.nama,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Role Badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      user.role.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  // NIS atau NIP
                  if (user.nis != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        user.nis!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                  if (user.nip != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'NIP: ${user.nip}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ),
                  SizedBox(height: 24),
                ],
              ),
            ),

            // Informasi Detail
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Header
                  Text(
                    'Informasi Pribadi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF134B70),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Info Cards - berbeda untuk siswa dan guru
                  if (user.role == 'siswa') ...[
                    _buildInfoCard(
                      icon: Icons.badge,
                      title: 'Nomor Induk Siswa',
                      value: user.nis ?? '-',
                    ),
                    _buildInfoCard(
                      icon: Icons.person,
                      title: 'Nama Lengkap',
                      value: user.nama,
                    ),
                    _buildInfoCard(
                      icon: Icons.class_,
                      title: 'Kelas',
                      value: '8A',
                    ),
                    _buildInfoCard(
                      icon: Icons.school,
                      title: 'Sekolah',
                      value: 'SMPN 1 Jambi',
                    ),
                    _buildInfoCard(
                      icon: Icons.account_circle,
                      title: 'Username',
                      value: user.username,
                    ),
                  ],

                  if (user.role == 'guru') ...[
                    _buildInfoCard(
                      icon: Icons.badge,
                      title: 'Nomor Induk Pegawai',
                      value: user.nip ?? '-',
                    ),
                    _buildInfoCard(
                      icon: Icons.person,
                      title: 'Nama Lengkap',
                      value: user.nama,
                    ),
                    _buildInfoCard(
                      icon: Icons.work,
                      title: 'Jabatan',
                      value: 'Guru Mata Pelajaran',
                    ),
                    _buildInfoCard(
                      icon: Icons.school,
                      title: 'Sekolah',
                      value: 'SMPN 1 Jambi',
                    ),
                    _buildInfoCard(
                      icon: Icons.account_circle,
                      title: 'Username',
                      value: user.username,
                    ),
                  ],

                  if (user.role == 'admin') ...[
                    _buildInfoCard(
                      icon: Icons.person,
                      title: 'Nama',
                      value: user.nama,
                    ),
                    _buildInfoCard(
                      icon: Icons.admin_panel_settings,
                      title: 'Role',
                      value: 'Administrator',
                    ),
                    _buildInfoCard(
                      icon: Icons.account_circle,
                      title: 'Username',
                      value: user.username,
                    ),
                  ],

                  SizedBox(height: 24),

                  // Statistik - hanya untuk siswa
                  if (user.role == 'siswa') ...[
                    Text(
                      'Statistik Akademik',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF134B70),
                      ),
                    ),
                    SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            title: 'Kehadiran',
                            value: '95%',
                            icon: Icons.check_circle,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            title: 'Rata-rata',
                            value: '87.5',
                            icon: Icons.star,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            title: 'Tugas',
                            value: '24/25',
                            icon: Icons.assignment,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            title: 'Ujian',
                            value: '8/8',
                            icon: Icons.quiz,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                  ],

                  // Tombol Edit Profil (opsional)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Fitur edit profil akan segera hadir')),
                        );
                      },
                      icon: Icon(Icons.edit, color: Colors.white),
                      label: Text(
                        'Edit Profil',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF134B70),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF134B70).withAlpha(25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Color(0xFF134B70),
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(51)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

