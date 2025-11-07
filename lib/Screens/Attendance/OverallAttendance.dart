import 'package:flutter/material.dart';
import 'package:tugas_akhir/Widgets/Attendance/OverAllAttendanceCard.dart';
import 'package:tugas_akhir/services/Repository.dart';
import 'package:tugas_akhir/services/Models.dart';

class OverallAttendance extends StatefulWidget {
  @override
  _OverallAttendanceState createState() => _OverallAttendanceState();
}

class _OverallAttendanceState extends State<OverallAttendance> {
  final AttendanceRepository _repository = AttendanceRepository();
  List<KehadiranKeseluruhan> _kehadiranList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadKehadiran();
  }

  Future<void> _loadKehadiran() async {
    try {
      final kehadiran = await _repository.getKehadiranKeseluruhan(1); // siswa_id = 1
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
                  child: Text(
                    'Tidak ada data kehadiran',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
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
