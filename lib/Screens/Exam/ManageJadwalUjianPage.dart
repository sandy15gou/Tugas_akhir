import 'package:flutter/material.dart';

class ManageJadwalUjianPage extends StatefulWidget {
  final Map<String, dynamic>? jadwalUjian; // null jika tambah baru

  const ManageJadwalUjianPage({
    Key? key,
    this.jadwalUjian,
  }) : super(key: key);

  @override
  _ManageJadwalUjianPageState createState() => _ManageJadwalUjianPageState();
}

class _ManageJadwalUjianPageState extends State<ManageJadwalUjianPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController _namaController;
  late TextEditingController _tanggalController;
  late TextEditingController _keteranganController;

  String? _selectedStatus;
  final List<String> _statusList = ['Akan Datang', 'Selesai'];

  // List mata pelajaran
  List<Map<String, String>> _mataPelajaranList = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _namaController = TextEditingController(
      text: widget.jadwalUjian?['nama'] ?? '',
    );
    _tanggalController = TextEditingController(
      text: widget.jadwalUjian?['tanggal'] ?? '',
    );
    _keteranganController = TextEditingController(
      text: widget.jadwalUjian?['keterangan'] ?? '',
    );

    _selectedStatus = widget.jadwalUjian?['status'];

    // Initialize mata pelajaran list
    if (widget.jadwalUjian != null && widget.jadwalUjian!['mapel'] != null) {
      _mataPelajaranList = List<Map<String, String>>.from(
        (widget.jadwalUjian!['mapel'] as List).map((e) => Map<String, String>.from(e))
      );
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tanggalController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  void _tambahMataPelajaran() {
    setState(() {
      _mataPelajaranList.add({
        'nama': '',
        'tanggal': '',
        'waktu': '',
        'ruang': '',
      });
    });
  }

  void _hapusMataPelajaran(int index) {
    setState(() {
      _mataPelajaranList.removeAt(index);
    });
  }

  void _simpanJadwal() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_mataPelajaranList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tambahkan minimal 1 mata pelajaran')),
      );
      return;
    }

    // Validasi semua mata pelajaran terisi
    for (var mapel in _mataPelajaranList) {
      if (mapel['nama']!.isEmpty || mapel['tanggal']!.isEmpty ||
          mapel['waktu']!.isEmpty || mapel['ruang']!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lengkapi semua data mata pelajaran')),
        );
        return;
      }
    }

    final jadwalData = {
      'nama': _namaController.text,
      'tanggal': _tanggalController.text,
      'keterangan': _keteranganController.text,
      'status': _selectedStatus!,
      'mapel': _mataPelajaranList,
    };

    Navigator.pop(context, jadwalData);
  }

  Future<void> _hapusJadwal() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus jadwal ujian ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      Navigator.pop(context, {'delete': true});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.jadwalUjian != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Jadwal Ujian' : 'Tambah Jadwal Ujian'),
        backgroundColor: Color(0xFF134B70),
        actions: [
          if (isEdit)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: _hapusJadwal,
              tooltip: 'Hapus Jadwal',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Nama Ujian
              Text('Nama Ujian', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contoh: Ujian Tengah Semester Ganjil',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama ujian';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Tanggal
              Text('Periode Tanggal', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                controller: _tanggalController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contoh: 15-20 Oktober 2024',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan periode tanggal';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Keterangan
              Text('Keterangan', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                controller: _keteranganController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contoh: UTS untuk semua mata pelajaran kelas 8',
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan keterangan';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Status
              Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Pilih status',
                ),
                items: _statusList.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pilih status';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),

              // Mata Pelajaran Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mata Pelajaran',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: _tambahMataPelajaran,
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text('Tambah', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF134B70),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              // List Mata Pelajaran
              ..._mataPelajaranList.asMap().entries.map((entry) {
                final index = entry.key;
                final mapel = entry.value;
                return _buildMataPelajaranCard(index, mapel);
              }).toList(),

              if (_mataPelajaranList.isEmpty)
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Belum ada mata pelajaran.\nKlik tombol "Tambah" untuk menambahkan.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),

              SizedBox(height: 24),

              // Tombol Simpan
              ElevatedButton(
                onPressed: _simpanJadwal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF134B70),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  isEdit ? 'Perbarui Jadwal Ujian' : 'Simpan Jadwal Ujian',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMataPelajaranCard(int index, Map<String, String> mapel) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mata Pelajaran ${index + 1}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red, size: 20),
                  onPressed: () => _hapusMataPelajaran(index),
                  tooltip: 'Hapus',
                ),
              ],
            ),
            SizedBox(height: 8),

            // Nama Mata Pelajaran
            TextFormField(
              initialValue: mapel['nama'],
              decoration: InputDecoration(
                labelText: 'Nama Mata Pelajaran',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              onChanged: (value) {
                setState(() {
                  _mataPelajaranList[index]['nama'] = value;
                });
              },
            ),
            SizedBox(height: 8),

            // Tanggal
            TextFormField(
              initialValue: mapel['tanggal'],
              decoration: InputDecoration(
                labelText: 'Tanggal',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                hintText: 'Contoh: 15 Oktober 2024',
              ),
              onChanged: (value) {
                setState(() {
                  _mataPelajaranList[index]['tanggal'] = value;
                });
              },
            ),
            SizedBox(height: 8),

            // Waktu
            TextFormField(
              initialValue: mapel['waktu'],
              decoration: InputDecoration(
                labelText: 'Waktu',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                hintText: 'Contoh: 07.30 - 09.30',
              ),
              onChanged: (value) {
                setState(() {
                  _mataPelajaranList[index]['waktu'] = value;
                });
              },
            ),
            SizedBox(height: 8),

            // Ruangan
            TextFormField(
              initialValue: mapel['ruang'],
              decoration: InputDecoration(
                labelText: 'Ruangan',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                hintText: 'Contoh: Ruang 8A',
              ),
              onChanged: (value) {
                setState(() {
                  _mataPelajaranList[index]['ruang'] = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

