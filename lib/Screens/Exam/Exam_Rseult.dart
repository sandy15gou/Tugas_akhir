import 'package:flutter/material.dart';
import 'package:tugas_akhir/Widgets/AppBar.dart';
import 'package:tugas_akhir/Widgets/MainDrawer.dart';
import 'package:tugas_akhir/services/AuthManager.dart';
import 'ManageJadwalUjianPage.dart';

class ExamResult extends StatefulWidget {
  @override
  _ExamResultState createState() => _ExamResultState();
}

class _ExamResultState extends State<ExamResult> {
  // Daftar jadwal ujian
  List<Map<String, dynamic>> _jadwalUjianList = [
    {
      'nama': 'Ujian Tengah Semester Ganjil',
      'tanggal': '15-20 Oktober 2024',
      'keterangan': 'UTS untuk semua mata pelajaran kelas 8',
      'status': 'Selesai',
      'mapel': [
        {'nama': 'Matematika', 'tanggal': '15 Oktober 2024', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'Bahasa Indonesia', 'tanggal': '16 Oktober 2024', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'IPA', 'tanggal': '17 Oktober 2024', 'waktu': '07.30 - 09.30', 'ruang': 'Lab IPA'},
        {'nama': 'Bahasa Inggris', 'tanggal': '18 Oktober 2024', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'IPS', 'tanggal': '19 Oktober 2024', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'Pendidikan Agama', 'tanggal': '20 Oktober 2024', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
      ],
    },
    {
      'nama': 'Ujian Akhir Semester Ganjil',
      'tanggal': '10-15 Desember 2024',
      'keterangan': 'UAS untuk semua mata pelajaran kelas 8',
      'status': 'Akan Datang',
      'mapel': [
        {'nama': 'Matematika', 'tanggal': '10 Desember 2024', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'Bahasa Indonesia', 'tanggal': '11 Desember 2024', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'IPA', 'tanggal': '12 Desember 2024', 'waktu': '07.30 - 09.30', 'ruang': 'Lab IPA'},
        {'nama': 'Bahasa Inggris', 'tanggal': '13 Desember 2024', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'IPS', 'tanggal': '14 Desember 2024', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'Pendidikan Agama', 'tanggal': '15 Desember 2024', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
      ],
    },
    {
      'nama': 'Ujian Tengah Semester Genap',
      'tanggal': '15-20 Maret 2025',
      'keterangan': 'UTS untuk semua mata pelajaran kelas 8',
      'status': 'Akan Datang',
      'mapel': [
        {'nama': 'Matematika', 'tanggal': '15 Maret 2025', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'Bahasa Indonesia', 'tanggal': '16 Maret 2025', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'IPA', 'tanggal': '17 Maret 2025', 'waktu': '07.30 - 09.30', 'ruang': 'Lab IPA'},
        {'nama': 'Bahasa Inggris', 'tanggal': '18 Maret 2025', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'IPS', 'tanggal': '19 Maret 2025', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'Pendidikan Agama', 'tanggal': '20 Maret 2025', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
      ],
    },
    {
      'nama': 'Ujian Akhir Semester Genap',
      'tanggal': '10-15 Juni 2025',
      'keterangan': 'UAS untuk semua mata pelajaran kelas 8 - Ujian Kenaikan Kelas',
      'status': 'Akan Datang',
      'mapel': [
        {'nama': 'Matematika', 'tanggal': '10 Juni 2025', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'Bahasa Indonesia', 'tanggal': '11 Juni 2025', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'IPA', 'tanggal': '12 Juni 2025', 'waktu': '07.30 - 09.30', 'ruang': 'Lab IPA'},
        {'nama': 'Bahasa Inggris', 'tanggal': '13 Juni 2025', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'IPS', 'tanggal': '14 Juni 2025', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
        {'nama': 'Pendidikan Agama', 'tanggal': '15 Juni 2025', 'waktu': '07.30 - 09.30', 'ruang': 'Ruang 8A'},
      ],
    },
  ];

  Future<void> _navigateToManageJadwal({Map<String, dynamic>? jadwal, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManageJadwalUjianPage(
          jadwalUjian: jadwal,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        if (result['delete'] == true && index != null) {
          // Hapus jadwal
          _jadwalUjianList.removeAt(index);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('✅ Jadwal ujian berhasil dihapus')),
          );
        } else if (index != null) {
          // Update jadwal
          _jadwalUjianList[index] = result;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('✅ Jadwal ujian berhasil diperbarui')),
          );
        } else {
          // Tambah jadwal baru
          _jadwalUjianList.add(result);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('✅ Jadwal ujian berhasil ditambahkan')),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final authManager = AuthManager.instance;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: CommonAppBar(
        menuenabled: true,
        notificationenabled: true,
        title: "Jadwal Ujian",
        ontap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: Drawer(
        elevation: 0,
        child: MainDrawer(),
      ),
      floatingActionButton: authManager.canEdit()
          ? FloatingActionButton(
              onPressed: () => _navigateToManageJadwal(),
              backgroundColor: Color(0xFF134B70),
              child: Icon(Icons.add, color: Colors.white),
              tooltip: 'Tambah Jadwal Ujian',
            )
          : null,
      body: Column(
        children: [
          // Header Info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF134B70), Color(0xFF508C9B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.assignment, color: Colors.white, size: 40),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jadwal Ujian',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Tahun Ajaran 2024/2025',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Daftar Jadwal Ujian
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: _jadwalUjianList.length,
              itemBuilder: (context, index) {
                final ujian = _jadwalUjianList[index];
                return _buildExamCard(ujian, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamCard(Map<String, dynamic> ujian, int index) {
    final isSelesai = ujian['status'] == 'Selesai';
    final authManager = AuthManager.instance;

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: EdgeInsets.all(16),
        leading: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelesai ? Colors.grey.shade200 : Color(0xFF134B70).withAlpha(25),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.event_note,
            color: isSelesai ? Colors.grey : Color(0xFF134B70),
            size: 28,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (authManager.canEdit())
              IconButton(
                icon: Icon(Icons.edit, color: Color(0xFF134B70), size: 20),
                onPressed: () => _navigateToManageJadwal(jadwal: ujian, index: index),
                tooltip: 'Edit',
              ),
            Icon(Icons.expand_more),
          ],
        ),
        title: Text(
          ujian['nama'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                SizedBox(width: 4),
                Text(
                  ujian['tanggal'],
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                ),
              ],
            ),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: isSelesai ? Colors.grey : Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                ujian['status'],
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        children: [
          // Keterangan
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ujian['keterangan'],
                    style: TextStyle(fontSize: 13, color: Colors.blue.shade900),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),

          // Detail Mata Pelajaran
          Text(
            'Detail Mata Pelajaran:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF134B70),
            ),
          ),
          SizedBox(height: 8),

          // List Mata Pelajaran
          ...ujian['mapel'].map<Widget>((mapel) {
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Color(0xFF134B70),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(Icons.book, color: Colors.white, size: 16),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          mapel['nama'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  _buildDetailRowSmall(Icons.calendar_today, 'Tanggal', mapel['tanggal']),
                  _buildDetailRowSmall(Icons.access_time, 'Waktu', mapel['waktu']),
                  _buildDetailRowSmall(Icons.meeting_room, 'Ruangan', mapel['ruang']),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDetailRowSmall(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          SizedBox(width: 6),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

