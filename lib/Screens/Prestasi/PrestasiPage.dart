import 'package:flutter/material.dart';
import 'package:tugas_akhir/Widgets/AppBar.dart';
import 'package:tugas_akhir/Widgets/MainDrawer.dart';
import 'package:tugas_akhir/services/AuthManager.dart';

class PrestasiPage extends StatefulWidget {
  @override
  State<PrestasiPage> createState() => _PrestasiPageState();
}

class _PrestasiPageState extends State<PrestasiPage> {
  final AuthManager _authManager = AuthManager.instance;

  List<Map<String, String>> prestasiList = [
    {
      "nama": "Hafizah",
      "judul": "Juara 1 Olimpiade Matematika Tingkat Kabupaten (2024)",
      "deskripsi":
          "Hafizah berhasil meraih juara pertama dalam Olimpiade Matematika tingkat kabupaten dengan perolehan nilai tertinggi.",
      "gambar": "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
    },
    {
      "nama": "Revaldho",
      "judul": "Juara 2 Lomba Pidato Bahasa Inggris Tingkat Provinsi (2025)",
      "deskripsi":
          "Menampilkan kemampuan berbicara Bahasa Inggris dengan percaya diri dan artikulasi yang jelas. Isi pidatonya inspiratif.",
      "gambar": "https://cdn-icons-png.flaticon.com/512/3135/3135810.png",
    },
  ];

  // Controller untuk input form
  final TextEditingController namaCtrl = TextEditingController();
  final TextEditingController judulCtrl = TextEditingController();
  final TextEditingController deskripsiCtrl = TextEditingController();
  final TextEditingController gambarCtrl = TextEditingController();

  // Cek apakah user adalah admin (hanya admin yang bisa edit)
  bool get canEdit => _authManager.isAdmin;

  void _tambahPrestasi() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Tambah Prestasi"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: namaCtrl,
                decoration: const InputDecoration(labelText: "Nama Siswa"),
              ),
              TextField(
                controller: judulCtrl,
                decoration: const InputDecoration(labelText: "Judul Prestasi"),
              ),
              TextField(
                controller: deskripsiCtrl,
                decoration: const InputDecoration(labelText: "Deskripsi"),
                maxLines: 3,
              ),
              TextField(
                controller: gambarCtrl,
                decoration: const InputDecoration(
                  labelText: "URL Gambar (opsional)",
                  hintText: "https://contoh.com/gambar.png",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                prestasiList.add({
                  "nama": namaCtrl.text,
                  "judul": judulCtrl.text,
                  "deskripsi": deskripsiCtrl.text,
                  "gambar": gambarCtrl.text.isEmpty
                      ? "https://cdn-icons-png.flaticon.com/512/190/190411.png"
                      : gambarCtrl.text,
                });
              });
              namaCtrl.clear();
              judulCtrl.clear();
              deskripsiCtrl.clear();
              gambarCtrl.clear();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Prestasi berhasil ditambahkan!')),
              );
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  void _editPrestasi(int index) {
    namaCtrl.text = prestasiList[index]["nama"]!;
    judulCtrl.text = prestasiList[index]["judul"]!;
    deskripsiCtrl.text = prestasiList[index]["deskripsi"]!;
    gambarCtrl.text = prestasiList[index]["gambar"]!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Edit Prestasi"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: namaCtrl,
                decoration: const InputDecoration(labelText: "Nama Siswa"),
              ),
              TextField(
                controller: judulCtrl,
                decoration: const InputDecoration(labelText: "Judul Prestasi"),
              ),
              TextField(
                controller: deskripsiCtrl,
                decoration: const InputDecoration(labelText: "Deskripsi"),
                maxLines: 3,
              ),
              TextField(
                controller: gambarCtrl,
                decoration: const InputDecoration(
                  labelText: "URL Gambar (opsional)",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                prestasiList[index] = {
                  "nama": namaCtrl.text,
                  "judul": judulCtrl.text,
                  "deskripsi": deskripsiCtrl.text,
                  "gambar": gambarCtrl.text.isEmpty
                      ? "https://cdn-icons-png.flaticon.com/512/190/190411.png"
                      : gambarCtrl.text,
                };
              });
              namaCtrl.clear();
              judulCtrl.clear();
              deskripsiCtrl.clear();
              gambarCtrl.clear();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Prestasi berhasil diupdate!')),
              );
            },
            child: const Text("Simpan Perubahan"),
          ),
        ],
      ),
    );
  }

  void _hapusPrestasi(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Prestasi"),
        content: const Text("Apakah kamu yakin ingin menghapus data ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                prestasiList.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Prestasi berhasil dihapus!')),
              );
            },
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final currentUser = _authManager.currentUser;
    final role = currentUser?.role ?? 'siswa';

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: CommonAppBar(
        title: "Prestasi",
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
      // FloatingActionButton hanya muncul untuk admin dan guru
      floatingActionButton: canEdit
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF1976D2),
              onPressed: _tambahPrestasi,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: prestasiList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.emoji_events, size: 100, color: Colors.grey[400]),
                  const SizedBox(height: 20),
                  Text(
                    'Belum ada data prestasi',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  if (canEdit) ...[
                    const SizedBox(height: 10),
                    Text(
                      'Klik tombol + untuk menambah prestasi',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: prestasiList.length,
              itemBuilder: (context, index) {
                final prestasi = prestasiList[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                        ),
                        child: Image.network(
                          prestasi["gambar"]!,
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 120,
                              width: 120,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.emoji_events,
                                size: 50,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prestasi["nama"]!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0D47A1),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                prestasi["judul"]!,
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                prestasi["deskripsi"]!,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  height: 1.4,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              // Tombol edit dan hapus hanya untuk admin dan guru
                              if (canEdit) ...[
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      onPressed: () => _editPrestasi(index),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                        size: 20,
                                      ),
                                      onPressed: () => _hapusPrestasi(index),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    namaCtrl.dispose();
    judulCtrl.dispose();
    deskripsiCtrl.dispose();
    gambarCtrl.dispose();
    super.dispose();
  }
}

