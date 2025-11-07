import 'package:flutter/material.dart';
import 'package:tugas_akhir/Widgets/Attendance/AttendanceCard.dart';
import 'package:tugas_akhir/services/Repository.dart';
import 'package:tugas_akhir/services/Models.dart';
import 'package:tugas_akhir/services/AuthManager.dart';

class TodayAttendance extends StatefulWidget {
  @override
  _TodayAttendanceState createState() => _TodayAttendanceState();
}

class _TodayAttendanceState extends State<TodayAttendance> {
  final AttendanceRepository _repository = AttendanceRepository();
  final AuthManager _authManager = AuthManager.instance;
  List<KehadiranHarian> _kehadiranList = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadKehadiranHariIni();
  }

  Future<void> _loadKehadiranHariIni() async {
    try {
      // Get user yang sedang login
      final currentUser = _authManager.currentUser;

      if (currentUser == null) {
        setState(() {
          _errorMessage = 'Pengguna tidak ditemukan. Silakan login kembali.';
          _isLoading = false;
        });
        return;
      }

      // Get tanggal hari ini
      final today = DateTime.now();
      final tanggal = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

      // Ambil kehadiran berdasarkan user yang login
      final kehadiran = await _repository.getKehadiranHariIni(currentUser.id ?? 1, tanggal);
      setState(() {
        _kehadiranList = kehadiran;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading kehadiran: $e');
      setState(() {
        _errorMessage = 'Gagal memuat data kehadiran';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 60, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  _errorMessage,
                  style: TextStyle(fontSize: 16, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _loadKehadiranHariIni,
                  child: Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_kehadiranList.isEmpty) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.event_available, size: 60, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Belum ada data kehadiran untuk hari ini',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: _kehadiranList.map((kehadiran) {
          return AttendanceCard(
            attendance: kehadiran.status,
            endtime: kehadiran.jamSelesai,
            staff: kehadiran.guru,
            starttime: kehadiran.jamMulai,
            subject: kehadiran.mataPelajaran,
          );
        }).toList(),
      ),
    );
  }
}
