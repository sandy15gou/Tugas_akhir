import 'package:flutter/material.dart';
import 'package:tugas_akhir/Widgets/AppBar.dart';
import 'package:tugas_akhir/Widgets/MainDrawer.dart';

class PerpustakaanPage extends StatefulWidget {
  @override
  _PerpustakaanPageState createState() => _PerpustakaanPageState();
}

class _PerpustakaanPageState extends State<PerpustakaanPage> {
  // Daftar kategori buku
  String _selectedCategory = 'Semua';
  final List<String> _categories = [
    'Semua',
    'Fiksi',
    'Non-Fiksi',
    'Pelajaran',
    'Komik',
  ];

  // Daftar buku dengan data lengkap
  final List<Map<String, dynamic>> _bukuList = [
    {
      'judul': 'Laskar Pelangi',
      'penulis': 'Andrea Hirata',
      'kategori': 'Fiksi',
      'tahun': '2005',
      'deskripsi': 'Novel tentang perjuangan 10 anak dari keluarga miskin yang berjuang untuk mendapatkan pendidikan.',
      'stok': 5,
      'gambar': 'https://via.placeholder.com/120x160/4CAF50/FFFFFF?text=Laskar+Pelangi',
    },
    {
      'judul': 'Bumi Manusia',
      'penulis': 'Pramoedya Ananta Toer',
      'kategori': 'Fiksi',
      'tahun': '1980',
      'deskripsi': 'Novel sejarah tentang kehidupan di masa kolonial Belanda.',
      'stok': 3,
      'gambar': 'https://via.placeholder.com/120x160/2196F3/FFFFFF?text=Bumi+Manusia',
    },
    {
      'judul': 'Matematika SMP Kelas 8',
      'penulis': 'Tim Penulis',
      'kategori': 'Pelajaran',
      'tahun': '2023',
      'deskripsi': 'Buku pelajaran matematika untuk siswa SMP kelas 8.',
      'stok': 25,
      'gambar': 'https://via.placeholder.com/120x160/FF9800/FFFFFF?text=Matematika+8',
    },
    {
      'judul': 'IPA Terpadu Kelas 8',
      'penulis': 'Tim Penulis',
      'kategori': 'Pelajaran',
      'tahun': '2023',
      'deskripsi': 'Buku pelajaran IPA untuk siswa SMP kelas 8.',
      'stok': 25,
      'gambar': 'https://via.placeholder.com/120x160/E91E63/FFFFFF?text=IPA+Terpadu',
    },
    {
      'judul': 'Bahasa Indonesia Kelas 8',
      'penulis': 'Tim Penulis',
      'kategori': 'Pelajaran',
      'tahun': '2023',
      'deskripsi': 'Buku pelajaran Bahasa Indonesia untuk siswa SMP kelas 8.',
      'stok': 25,
      'gambar': 'https://via.placeholder.com/120x160/9C27B0/FFFFFF?text=B.Indonesia',
    },
    {
      'judul': 'Negeri 5 Menara',
      'penulis': 'Ahmad Fuadi',
      'kategori': 'Fiksi',
      'tahun': '2009',
      'deskripsi': 'Novel tentang kisah inspiratif enam santri di Pondok Madani.',
      'stok': 4,
      'gambar': 'https://via.placeholder.com/120x160/00BCD4/FFFFFF?text=Negeri+5+Menara',
    },
    {
      'judul': 'Habis Gelap Terbitlah Terang',
      'penulis': 'R.A. Kartini',
      'kategori': 'Non-Fiksi',
      'tahun': '1911',
      'deskripsi': 'Kumpulan surat-surat R.A. Kartini tentang emansipasi wanita.',
      'stok': 6,
      'gambar': 'https://via.placeholder.com/120x160/673AB7/FFFFFF?text=RA+Kartini',
    },
    {
      'judul': 'Ensiklopedia Sains',
      'penulis': 'National Geographic',
      'kategori': 'Non-Fiksi',
      'tahun': '2020',
      'deskripsi': 'Ensiklopedia lengkap tentang ilmu pengetahuan dan teknologi.',
      'stok': 8,
      'gambar': 'https://via.placeholder.com/120x160/FF5722/FFFFFF?text=Ensiklopedia',
    },
    {
      'judul': 'Doraemon Vol. 1-45',
      'penulis': 'Fujiko F. Fujio',
      'kategori': 'Komik',
      'tahun': '1996',
      'deskripsi': 'Komik Doraemon lengkap volume 1 sampai 45.',
      'stok': 45,
      'gambar': 'https://via.placeholder.com/120x160/03A9F4/FFFFFF?text=Doraemon',
    },
    {
      'judul': 'One Piece Vol. 1-20',
      'penulis': 'Eiichiro Oda',
      'kategori': 'Komik',
      'tahun': '2000',
      'deskripsi': 'Komik petualangan bajak laut mencari harta karun.',
      'stok': 20,
      'gambar': 'https://via.placeholder.com/120x160/FF9800/FFFFFF?text=One+Piece',
    },
    {
      'judul': 'Sejarah Indonesia',
      'penulis': 'Tim Historian',
      'kategori': 'Non-Fiksi',
      'tahun': '2022',
      'deskripsi': 'Buku sejarah lengkap Indonesia dari masa kerajaan hingga modern.',
      'stok': 10,
      'gambar': 'https://via.placeholder.com/120x160/795548/FFFFFF?text=Sejarah+ID',
    },
    {
      'judul': 'English Grammar for SMP',
      'penulis': 'Betty Azar',
      'kategori': 'Pelajaran',
      'tahun': '2023',
      'deskripsi': 'Buku grammar Bahasa Inggris untuk siswa SMP.',
      'stok': 15,
      'gambar': 'https://via.placeholder.com/120x160/607D8B/FFFFFF?text=English+Grammar',
    },
  ];

  // Filter buku berdasarkan kategori
  List<Map<String, dynamic>> get _filteredBooks {
    if (_selectedCategory == 'Semua') {
      return _bukuList;
    }
    return _bukuList.where((book) => book['kategori'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: CommonAppBar(
        title: "Perpustakaan",
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
                Icon(Icons.library_books, color: Colors.white, size: 40),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Koleksi Perpustakaan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${_bukuList.length} Buku Tersedia',
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

          // Filter Kategori
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF134B70) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Color(0xFF134B70) : Colors.grey.shade300,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Daftar Buku
          Expanded(
            child: _filteredBooks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.menu_book, size: 80, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Tidak ada buku di kategori ini',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(12),
                    itemCount: _filteredBooks.length,
                    itemBuilder: (context, index) {
                      final buku = _filteredBooks[index];
                      return _buildBookCard(buku);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(Map<String, dynamic> buku) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          _showBookDetail(buku);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover Buku
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 110,
                  color: _getCategoryColor(buku['kategori']),
                  child: Center(
                    child: Icon(
                      Icons.menu_book,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),

              // Info Buku
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      buku['judul'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Penulis: ${buku['penulis']}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(buku['kategori']).withAlpha(51),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            buku['kategori'],
                            style: TextStyle(
                              fontSize: 11,
                              color: _getCategoryColor(buku['kategori']),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Tahun: ${buku['tahun']}',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.inventory_2, size: 16, color: Colors.green),
                        SizedBox(width: 4),
                        Text(
                          'Stok: ${buku['stok']} buku',
                          style: TextStyle(
                            fontSize: 12,
                            color: buku['stok'] > 0 ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Icon Detail
              Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String kategori) {
    switch (kategori) {
      case 'Fiksi':
        return Colors.blue;
      case 'Non-Fiksi':
        return Colors.green;
      case 'Pelajaran':
        return Colors.orange;
      case 'Komik':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  void _showBookDetail(Map<String, dynamic> buku) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.menu_book, color: Color(0xFF134B70)),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                buku['judul'],
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cover Buku Besar
              Center(
                child: Container(
                  width: 120,
                  height: 160,
                  decoration: BoxDecoration(
                    color: _getCategoryColor(buku['kategori']),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.menu_book,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildDetailRow('Penulis', buku['penulis']),
              _buildDetailRow('Kategori', buku['kategori']),
              _buildDetailRow('Tahun Terbit', buku['tahun']),
              _buildDetailRow('Stok Tersedia', '${buku['stok']} buku'),
              SizedBox(height: 12),
              Text(
                'Deskripsi:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 4),
              Text(
                buku['deskripsi'],
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Fitur peminjaman buku akan segera hadir'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: Icon(Icons.bookmark_add, color: Colors.white),
            label: Text('Pinjam', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF134B70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}

