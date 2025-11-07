import 'package:flutter/material.dart';
import 'package:tugas_akhir/services/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInfoPage extends StatefulWidget {
  @override
  _DatabaseInfoPageState createState() => _DatabaseInfoPageState();
}

class _DatabaseInfoPageState extends State<DatabaseInfoPage> {
  String? _databasePath;
  String? _databaseSize;
  List<String> _tables = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDatabaseInfo();
  }

  Future<void> _loadDatabaseInfo() async {
    try {
      // Get database path
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'school_management.db');

      // Get database instance
      final db = await DatabaseHelper.instance.database;

      // Get tables
      final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name"
      );

      setState(() {
        _databasePath = path;
        _tables = tables.map((t) => t['name'] as String).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading database info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Database'),
        backgroundColor: Color(0xFF134B70),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF134B70), Color(0xFF508C9B)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.storage, size: 40, color: Colors.white),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SQLite Database',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'school_management.db',
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
                  SizedBox(height: 24),

                  // Lokasi File
                  Text(
                    'Lokasi File Database:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF134B70),
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: SelectableText(
                      _databasePath ?? 'Loading...',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.info_outline, size: 16, color: Colors.blue),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Copy path di atas untuk membuka file database',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  // Daftar Tabel
                  Text(
                    'Tabel dalam Database:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF134B70),
                    ),
                  ),
                  SizedBox(height: 12),
                  ..._tables.map((table) => _buildTableCard(table)).toList(),

                  SizedBox(height: 24),

                  // Info Tambahan
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb_outline, color: Colors.blue),
                            SizedBox(width: 8),
                            Text(
                              'Cara Melihat Database:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        _buildInfoItem(
                          '1. Copy path di atas',
                          'Salin lokasi file database',
                        ),
                        _buildInfoItem(
                          '2. Download DB Browser for SQLite',
                          'https://sqlitebrowser.org',
                        ),
                        _buildInfoItem(
                          '3. Open Database',
                          'Buka file school_management.db',
                        ),
                        _buildInfoItem(
                          '4. Browse Data',
                          'Lihat semua data di setiap tabel',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTableCard(String tableName) {
    final icons = {
      'siswa': Icons.person,
      'jadwal_pelajaran': Icons.schedule,
      'kehadiran_harian': Icons.check_circle,
      'kehadiran_keseluruhan': Icons.calendar_today,
      'ujian': Icons.assignment,
      'nilai_ujian': Icons.grade,
      'pengajuan_izin': Icons.event_note,
    };

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF134B70).withAlpha(25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icons[tableName] ?? Icons.table_chart,
              color: Color(0xFF134B70),
            ),
          ),
          SizedBox(width: 12),
          Text(
            tableName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

