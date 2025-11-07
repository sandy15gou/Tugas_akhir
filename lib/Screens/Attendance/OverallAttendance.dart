import 'package:flutter/material.dart';
import 'package:tugas_akhir/Widgets/Attendance/OverAllAttendanceCard.dart';
import 'package:tugas_akhir/services/Repository.dart';
import 'package:tugas_akhir/services/Models.dart';
import 'package:tugas_akhir/services/AuthManager.dart';

class OverallAttendance extends StatefulWidget {
  @override
  _OverallAttendanceState createState() => _OverallAttendanceState();
}

class _OverallAttendanceState extends State<OverallAttendance> {
  final AttendanceRepository _repository = AttendanceRepository();
  final AuthManager _authManager = AuthManager.instance;
  List<KehadiranKeseluruhan> _kehadiranList = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadKehadiran();
  }

  Future<void> _loadKehadiran() async {
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

      // Ambil kehadiran berdasarkan user yang login
      final kehadiran = await _repository.getKehadiranKeseluruhan(currentUser.id ?? 1);
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
                  onPressed: _loadKehadiran,
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
                Icon(Icons.event_busy, size: 60, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Tidak ada data kehadiran',
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
      body: ListView.builder(
        itemCount: _kehadiranList.length,
        itemBuilder: (context, index) {
          final kehadiran = _kehadiranList[index];
          return OverallAttendanceCard(
            date: kehadiran.tanggal,
            day: kehadiran.hari,
            firsthalf: kehadiran.hadirPagi,
            secondhalf: kehadiran.hadirSiang,
          );
        },
      ),
    );
  }
}
