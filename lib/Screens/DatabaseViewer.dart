import 'package:flutter/material.dart';
import 'package:tugas_akhir/services/DatabaseHelper.dart';
import 'package:tugas_akhir/services/Repository.dart';
import 'package:tugas_akhir/services/Models.dart';

class DatabaseViewer extends StatefulWidget {
  @override
  _DatabaseViewerState createState() => _DatabaseViewerState();
}

class _DatabaseViewerState extends State<DatabaseViewer> {
  final StudentRepository _studentRepo = StudentRepository();
  final AttendanceRepository _attendanceRepo = AttendanceRepository();
  final TimeTableRepository _timetableRepo = TimeTableRepository();
  final ExamRepository _examRepo = ExamRepository();
  final LeaveRepository _leaveRepo = LeaveRepository();

  Siswa? _siswa;
  List<KehadiranHarian> _kehadiranHarian = [];
  List<KehadiranKeseluruhan> _kehadiranKeseluruhan = [];
  List<JadwalPelajaran> _jadwal = [];
  List<Ujian> _ujian = [];
  List<PengajuanIzin> _izin = [];

  bool _isLoading = true;
  String _dbPath = '';

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _resetDatabase() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Close existing database
      final db = await DatabaseHelper.instance.database;
      await db.close();

      // Delete database file
      await db.delete('jadwal_pelajaran');
      await db.delete('kehadiran_harian');
      await db.delete('kehadiran_keseluruhan');
      await db.delete('nilai_ujian');
      await db.delete('ujian');
      await db.delete('pengajuan_izin');
      await db.delete('siswa');

      // Recreate with dummy data
      await _insertDummyData(db);

      // Reload data
      await _loadAllData();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Database berhasil direset dan diisi ulang!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error resetting database: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _insertDummyData(db) async {
    // Insert siswa
    await db.insert('siswa', {
      'nis': 'NIS-2024001',
      'nama': 'Ahmad Zulfikar',
      'kelas': '8A',
      'sekolah': 'SMPN 1 Jambi',
      'foto': 'assets/home.png'
    });

    // Insert jadwal pelajaran
    final jadwalData = [
      // SENIN
      {'hari': 'Senin', 'mapel': 'Matematika', 'guru': 'Siti Nurhaliza', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 8A'},
      {'hari': 'Senin', 'mapel': 'Bahasa Indonesia', 'guru': 'Ahmad Fauzi', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 8A'},
      {'hari': 'Senin', 'mapel': 'IPA', 'guru': 'Dewi Kusuma', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Lab IPA'},
      {'hari': 'Senin', 'mapel': 'Bahasa Inggris', 'guru': 'Budi Santoso', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Ruang 8A'},

      // SELASA
      {'hari': 'Selasa', 'mapel': 'IPS', 'guru': 'Rahmat Hidayat', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 8A'},
      {'hari': 'Selasa', 'mapel': 'Pendidikan Agama', 'guru': 'Ustadz Yusuf', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 8A'},
      {'hari': 'Selasa', 'mapel': 'Matematika', 'guru': 'Siti Nurhaliza', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Ruang 8A'},
      {'hari': 'Selasa', 'mapel': 'Seni Budaya', 'guru': 'Rina Amelia', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Ruang Seni'},

      // RABU
      {'hari': 'Rabu', 'mapel': 'PJOK', 'guru': 'Pak Agus', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Lapangan'},
      {'hari': 'Rabu', 'mapel': 'Bahasa Inggris', 'guru': 'Budi Santoso', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 8A'},
      {'hari': 'Rabu', 'mapel': 'IPA', 'guru': 'Dewi Kusuma', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Lab IPA'},
      {'hari': 'Rabu', 'mapel': 'Prakarya', 'guru': 'Fitri Handayani', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Ruang Praktek'},

      // KAMIS
      {'hari': 'Kamis', 'mapel': 'Matematika', 'guru': 'Siti Nurhaliza', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 8A'},
      {'hari': 'Kamis', 'mapel': 'Bahasa Indonesia', 'guru': 'Ahmad Fauzi', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 8A'},
      {'hari': 'Kamis', 'mapel': 'IPS', 'guru': 'Rahmat Hidayat', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Ruang 8A'},
      {'hari': 'Kamis', 'mapel': 'TIK', 'guru': 'Hendra Wijaya', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Lab Komputer'},

      // JUMAT
      {'hari': 'Jumat', 'mapel': 'Pendidikan Agama', 'guru': 'Ustadz Yusuf', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 8A'},
      {'hari': 'Jumat', 'mapel': 'Bahasa Daerah', 'guru': 'Ibu Ratna', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 8A'},
      {'hari': 'Jumat', 'mapel': 'Ekstrakurikuler', 'guru': 'Pembina', 'mulai': '10.15', 'selesai': '11.30', 'ruangan': 'Sesuai Pilihan'},
    ];

    for (var jadwal in jadwalData) {
      await db.insert('jadwal_pelajaran', {
        'siswa_id': 1,
        'hari': jadwal['hari'],
        'mata_pelajaran': jadwal['mapel'],
        'guru': jadwal['guru'],
        'jam_mulai': jadwal['mulai'],
        'jam_selesai': jadwal['selesai'],
        'ruangan': jadwal['ruangan'],
      });
    }

    // Insert kehadiran hari ini
    await db.insert('kehadiran_harian', {
      'siswa_id': 1,
      'tanggal': '2024-11-06',
      'mata_pelajaran': 'Bahasa Inggris',
      'guru': 'Budi Santoso',
      'jam_mulai': '09.00',
      'jam_selesai': '10.00',
      'status': 1
    });

    await db.insert('kehadiran_harian', {
      'siswa_id': 1,
      'tanggal': '2024-11-06',
      'mata_pelajaran': 'Matematika',
      'guru': 'Siti Nurhaliza',
      'jam_mulai': '10.00',
      'jam_selesai': '11.00',
      'status': 0
    });
  }

  Future<void> _loadAllData() async {
    try {
      // Get database path
      final db = await DatabaseHelper.instance.database;
      setState(() {
        _dbPath = db.path;
      });

      // Load semua data
      final siswa = await _studentRepo.getSiswaById(1);
      final kehadiranHarian = await _attendanceRepo.getAllKehadiranHarian(1);
      final kehadiranKeseluruhan = await _attendanceRepo.getKehadiranKeseluruhan(1);
      final jadwal = await _timetableRepo.getAllJadwal(1);
      final ujian = await _examRepo.getUjianBySiswa(1);
      final izin = await _leaveRepo.getPengajuanIzin(1);

      setState(() {
        _siswa = siswa;
        _kehadiranHarian = kehadiranHarian;
        _kehadiranKeseluruhan = kehadiranKeseluruhan;
        _jadwal = jadwal;
        _ujian = ujian;
        _izin = izin;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Viewer'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Reset & Isi Ulang Database',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Reset Database?'),
                  content: Text('Apakah Anda yakin ingin reset dan isi ulang database dengan data dummy?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Batal'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _resetDatabase();
                      },
                      child: Text('Ya, Reset'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Database Path
                  Card(
                    color: Colors.green[50],
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '✅ DATABASE BERHASIL DIBUAT!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Lokasi Database:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SelectableText(
                            _dbPath,
                            style: TextStyle(fontSize: 12, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Data Siswa
                  _buildSection(
                    'Data Siswa',
                    Icons.person,
                    Colors.blue,
                    _siswa != null
                        ? [
                            'ID: ${_siswa!.id}',
                            'NIS: ${_siswa!.nis}',
                            'Nama: ${_siswa!.nama}',
                            'Kelas: ${_siswa!.kelas}',
                            'Sekolah: ${_siswa!.sekolah}',
                          ]
                        : ['Tidak ada data'],
                  ),

                  // Kehadiran Harian
                  _buildSection(
                    'Kehadiran Hari Ini',
                    Icons.check_circle,
                    Colors.green,
                    _kehadiranHarian.isEmpty
                        ? ['Belum ada data']
                        : _kehadiranHarian.map((k) =>
                            '${k.mataPelajaran} (${k.guru}) - ${k.status ? "Hadir" : "Tidak Hadir"}').toList(),
                  ),

                  // Kehadiran Keseluruhan
                  _buildSection(
                    'Kehadiran Keseluruhan',
                    Icons.calendar_today,
                    Colors.orange,
                    ['Total: ${_kehadiranKeseluruhan.length} data'],
                  ),

                  // Jadwal Pelajaran
                  _buildSection(
                    'Jadwal Pelajaran',
                    Icons.schedule,
                    Colors.purple,
                    ['Total: ${_jadwal.length} jadwal'],
                  ),

                  // Ujian
                  _buildSection(
                    'Data Ujian',
                    Icons.assignment,
                    Colors.red,
                    _ujian.isEmpty
                        ? ['Tidak ada data']
                        : _ujian.map((u) => '${u.namaUjian} - ${u.tanggal}').toList(),
                  ),

                  // Pengajuan Izin
                  _buildSection(
                    'Pengajuan Izin',
                    Icons.notification_important,
                    Colors.teal,
                    _izin.isEmpty
                        ? ['Tidak ada data']
                        : _izin.map((i) => '${i.alasan} (${i.status})').toList(),
                  ),

                  SizedBox(height: 20),

                  // Summary
                  Card(
                    color: Colors.blue[50],
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'RINGKASAN DATABASE',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          _buildSummaryRow('Siswa', _siswa != null ? '1' : '0'),
                          _buildSummaryRow('Kehadiran Harian', '${_kehadiranHarian.length}'),
                          _buildSummaryRow('Kehadiran Keseluruhan', '${_kehadiranKeseluruhan.length}'),
                          _buildSummaryRow('Jadwal Pelajaran', '${_jadwal.length}'),
                          _buildSummaryRow('Ujian', '${_ujian.length}'),
                          _buildSummaryRow('Pengajuan Izin', '${_izin.length}'),
                          Divider(),
                          Text(
                            'Total Data: ${(_siswa != null ? 1 : 0) + _kehadiranHarian.length + _kehadiranKeseluruhan.length + _jadwal.length + _ujian.length + _izin.length}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSection(String title, IconData icon, Color color, List<String> items) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text('• $item'),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

