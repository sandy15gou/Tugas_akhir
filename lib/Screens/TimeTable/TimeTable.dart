import 'package:flutter/material.dart';
import 'package:tugas_akhir/Widgets/AppBar.dart';
import 'package:tugas_akhir/Widgets/MainDrawer.dart';
import 'package:tugas_akhir/Widgets/UserDetailCard.dart';
import 'package:tugas_akhir/Widgets/TimeTable/TimeTableCard.dart';
import 'package:tugas_akhir/services/Repository.dart';
import 'package:tugas_akhir/services/Models.dart';
import 'package:tugas_akhir/services/AuthManager.dart';
import 'ManageJadwalPage.dart';

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> with SingleTickerProviderStateMixin {
  final TimeTableRepository _repository = TimeTableRepository();
  Map<String, List<JadwalPelajaran>> _jadwalByHari = {};
  bool _isLoading = true;
  late TabController _tabController;

  final List<String> _hariList = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _hariList.length, vsync: this);
    _loadJadwal();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadJadwal() async {
    try {
      final authManager = AuthManager.instance;
      final currentUser = authManager.currentUser;

      if (currentUser == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Semua user (siswa, guru, admin) melihat jadwal berdasarkan tingkat kelas
      if (authManager.isSiswa) {
        final tingkatKelas = authManager.getTingkatKelas();
        if (tingkatKelas != null) {
          final jadwal = await _repository.getJadwalGroupByHariByTingkatKelas(tingkatKelas);
          setState(() {
            _jadwalByHari = jadwal;
            _isLoading = false;
          });
        } else {
          setState(() {
            _jadwalByHari = {};
            _isLoading = false;
          });
        }
      } else if (authManager.isGuru || authManager.isAdmin) {
        // Untuk guru dan admin, tampilkan semua jadwal dari semua kelas
        // atau bisa pilih kelas tertentu
        final allJadwal = <String, List<JadwalPelajaran>>{};

        // Load jadwal untuk semua tingkat kelas (7, 8, 9)
        for (int tingkat in [7, 8, 9]) {
          final jadwalKelas = await _repository.getJadwalGroupByHariByTingkatKelas(tingkat);
          jadwalKelas.forEach((hari, jadwalList) {
            if (!allJadwal.containsKey(hari)) {
              allJadwal[hari] = [];
            }
            allJadwal[hari]!.addAll(jadwalList);
          });
        }

        // Sort jadwal by jam_mulai
        allJadwal.forEach((hari, jadwalList) {
          jadwalList.sort((a, b) => a.jamMulai.compareTo(b.jamMulai));
        });

        setState(() {
          _jadwalByHari = allJadwal;
          _isLoading = false;
        });
      } else {
        setState(() {
          _jadwalByHari = {};
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading jadwal: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _navigateToManageJadwal({JadwalPelajaran? jadwal}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManageJadwalPage(
          jadwal: jadwal,
        ),
      ),
    );

    // Refresh jika ada perubahan
    if (result == true) {
      _loadJadwal();
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final authManager = AuthManager.instance;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(
        title: "Jadwal Pelajaran",
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
      floatingActionButton: authManager.canEdit()
          ? FloatingActionButton(
              onPressed: () => _navigateToManageJadwal(),
              backgroundColor: Color(0xFF134B70),
              child: Icon(Icons.add, color: Colors.white),
              tooltip: 'Tambah Jadwal',
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            UserDetailCard(),

            // Tab Bar untuk hari
            DefaultTabController(
              length: _hariList.length,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.black26,
                        indicatorColor: Colors.blue,
                        isScrollable: true,
                        tabs: _hariList.map((hari) => Tab(text: hari)).toList(),
                      ),
                    ),
                  ),

                  Container(
                    height: MediaQuery.of(context).size.height * 0.68,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : TabBarView(
                            controller: _tabController,
                            children: _hariList.map((hari) {
                              final jadwalHariIni = _jadwalByHari[hari] ?? [];

                              if (jadwalHariIni.isEmpty) {
                                return Center(
                                  child: Text(
                                    'Tidak ada jadwal untuk hari $hari',
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                );
                              }

                              return ListView.builder(
                                itemCount: jadwalHariIni.length,
                                itemBuilder: (context, index) {
                                  final jadwal = jadwalHariIni[index];
                                  return TimeTableCard(
                                    mataPelajaran: jadwal.mataPelajaran,
                                    guru: jadwal.guru,
                                    jamMulai: jadwal.jamMulai,
                                    jamSelesai: jadwal.jamSelesai,
                                    ruangan: jadwal.ruangan,
                                    tingkatKelas: (authManager.isGuru || authManager.isAdmin)
                                        ? jadwal.tingkatKelas
                                        : null, // Only show class level for admin/guru
                                    onTap: authManager.canEdit()
                                        ? () => _navigateToManageJadwal(jadwal: jadwal)
                                        : null,
                                  );
                                },
                              );
                            }).toList(),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

