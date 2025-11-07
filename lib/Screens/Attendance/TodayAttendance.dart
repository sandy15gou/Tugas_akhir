import 'package:flutter/material.dart';
import 'package:tugas_akhir/Widgets/Attendance/AttendanceCard.dart';
import 'package:tugas_akhir/services/Repository.dart';
import 'package:tugas_akhir/services/Models.dart';

class TodayAttendance extends StatefulWidget {
  @override
  _TodayAttendanceState createState() => _TodayAttendanceState();
}

class _TodayAttendanceState extends State<TodayAttendance> {
  final AttendanceRepository _repository = AttendanceRepository();
  List<KehadiranHarian> _kehadiranList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadKehadiranHariIni();
  }

  Future<void> _loadKehadiranHariIni() async {
    try {
      // Get tanggal hari ini
      final today = DateTime.now();
      final tanggal = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

      final kehadiran = await _repository.getKehadiranHariIni(1, tanggal); // siswa_id = 1
      setState(() {
        _kehadiranList = kehadiran;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading kehadiran: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _kehadiranList.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Belum ada data kehadiran untuk hari ini',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Column(
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
