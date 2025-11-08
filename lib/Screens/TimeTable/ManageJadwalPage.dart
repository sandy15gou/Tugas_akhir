import 'package:flutter/material.dart';
import 'package:tugas_akhir/services/Models.dart';
import 'package:tugas_akhir/services/Repository.dart';

class ManageJadwalPage extends StatefulWidget {
  final JadwalPelajaran? jadwal; // null jika tambah baru, ada value jika edit
  final int siswaId;

  const ManageJadwalPage({
    Key? key,
    this.jadwal,
    required this.siswaId,
  }) : super(key: key);

  @override
  _ManageJadwalPageState createState() => _ManageJadwalPageState();
}

class _ManageJadwalPageState extends State<ManageJadwalPage> {
  final _formKey = GlobalKey<FormState>();
  final TimeTableRepository _repository = TimeTableRepository();

  // Controllers
  late TextEditingController _mataPelajaranController;
  late TextEditingController _guruController;
  late TextEditingController _ruanganController;

  // Dropdown values
  String? _selectedHari;
  String? _selectedJamMulai;
  String? _selectedJamSelesai;
  int? _selectedTingkatKelas;

  final List<String> _hariList = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
  final List<int> _tingkatKelasList = [7, 8, 9];
  final List<String> _jamList = [
    '06.30', '07.00', '07.30', '08.00', '08.30', '09.00', '09.30', '10.00',
    '10.15', '10.30', '11.00', '11.30', '12.00', '12.30', '13.00', '13.30',
    '14.00', '14.30', '15.00', '15.30', '16.00'
  ];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _mataPelajaranController = TextEditingController(
      text: widget.jadwal?.mataPelajaran ?? '',
    );
    _guruController = TextEditingController(
      text: widget.jadwal?.guru ?? '',
    );
    _ruanganController = TextEditingController(
      text: widget.jadwal?.ruangan ?? '',
    );

    // Initialize dropdown values
    _selectedHari = widget.jadwal?.hari;
    _selectedJamMulai = widget.jadwal?.jamMulai;
    _selectedJamSelesai = widget.jadwal?.jamSelesai;
    _selectedTingkatKelas = widget.jadwal?.tingkatKelas;
  }

  @override
  void dispose() {
    _mataPelajaranController.dispose();
    _guruController.dispose();
    _ruanganController.dispose();
    super.dispose();
  }

  Future<void> _simpanJadwal() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final jadwal = JadwalPelajaran(
        id: widget.jadwal?.id,
        siswaId: widget.siswaId,
        tingkatKelas: _selectedTingkatKelas ?? 8, // Default kelas 8
        hari: _selectedHari!,
        mataPelajaran: _mataPelajaranController.text,
        guru: _guruController.text,
        jamMulai: _selectedJamMulai!,
        jamSelesai: _selectedJamSelesai!,
        ruangan: _ruanganController.text,
      );

      if (widget.jadwal == null) {
        // Tambah baru
        await _repository.insertJadwal(jadwal);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ Jadwal berhasil ditambahkan')),
        );
      } else {
        // Update
        await _repository.updateJadwal(jadwal);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ Jadwal berhasil diperbarui')),
        );
      }

      Navigator.pop(context, true); // Return true untuk refresh
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _hapusJadwal() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus jadwal ini?'),
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

    if (confirm != true) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _repository.deleteJadwal(widget.jadwal!.id!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Jadwal berhasil dihapus')),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.jadwal != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Jadwal' : 'Tambah Jadwal'),
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Tingkat Kelas
                    Text('Tingkat Kelas', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      value: _selectedTingkatKelas,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Pilih tingkat kelas',
                      ),
                      items: _tingkatKelasList.map((kelas) {
                        return DropdownMenuItem(
                          value: kelas,
                          child: Text('Kelas $kelas'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedTingkatKelas = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih tingkat kelas';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Hari
                    Text('Hari', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedHari,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Pilih hari',
                      ),
                      items: _hariList.map((hari) {
                        return DropdownMenuItem(
                          value: hari,
                          child: Text(hari),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedHari = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pilih hari';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Mata Pelajaran
                    Text('Mata Pelajaran', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _mataPelajaranController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Contoh: Matematika',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan mata pelajaran';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Guru
                    Text('Nama Guru', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _guruController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Contoh: Siti Nurhaliza',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan nama guru';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Jam Mulai & Selesai
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Jam Mulai', style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                value: _selectedJamMulai,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Jam',
                                ),
                                items: _jamList.map((jam) {
                                  return DropdownMenuItem(
                                    value: jam,
                                    child: Text(jam),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedJamMulai = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Pilih jam';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Jam Selesai', style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                value: _selectedJamSelesai,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Jam',
                                ),
                                items: _jamList.map((jam) {
                                  return DropdownMenuItem(
                                    value: jam,
                                    child: Text(jam),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedJamSelesai = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Pilih jam';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Ruangan
                    Text('Ruangan', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _ruanganController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Contoh: Ruang 8A',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan ruangan';
                        }
                        return null;
                      },
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
                        isEdit ? 'Perbarui Jadwal' : 'Simpan Jadwal',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

