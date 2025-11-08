import 'package:sqflite/sqflite.dart';
import 'DatabaseHelper.dart';
import 'Models.dart';

class AttendanceRepository {
  final dbHelper = DatabaseHelper.instance;

  // Get kehadiran hari ini
  Future<List<KehadiranHarian>> getKehadiranHariIni(int siswaId, String tanggal) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'kehadiran_harian',
      where: 'siswa_id = ? AND tanggal = ?',
      whereArgs: [siswaId, tanggal],
    );
    return List.generate(maps.length, (i) => KehadiranHarian.fromMap(maps[i]));
  }

  // Get semua kehadiran harian
  Future<List<KehadiranHarian>> getAllKehadiranHarian(int siswaId) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'kehadiran_harian',
      where: 'siswa_id = ?',
      whereArgs: [siswaId],
      orderBy: 'tanggal DESC',
    );
    return List.generate(maps.length, (i) => KehadiranHarian.fromMap(maps[i]));
  }

  // Get kehadiran keseluruhan
  Future<List<KehadiranKeseluruhan>> getKehadiranKeseluruhan(int siswaId) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'kehadiran_keseluruhan',
      where: 'siswa_id = ?',
      whereArgs: [siswaId],
      orderBy: 'tanggal DESC',
    );
    return List.generate(maps.length, (i) => KehadiranKeseluruhan.fromMap(maps[i]));
  }

  // Insert kehadiran harian
  Future<int> insertKehadiranHarian(KehadiranHarian kehadiran) async {
    final db = await dbHelper.database;
    return await db.insert('kehadiran_harian', kehadiran.toMap());
  }

  // Insert kehadiran keseluruhan
  Future<int> insertKehadiranKeseluruhan(KehadiranKeseluruhan kehadiran) async {
    final db = await dbHelper.database;
    return await db.insert('kehadiran_keseluruhan', kehadiran.toMap());
  }

  // Update kehadiran harian
  Future<int> updateKehadiranHarian(KehadiranHarian kehadiran) async {
    final db = await dbHelper.database;
    return await db.update(
      'kehadiran_harian',
      kehadiran.toMap(),
      where: 'id = ?',
      whereArgs: [kehadiran.id],
    );
  }

  // Delete kehadiran harian
  Future<int> deleteKehadiranHarian(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'kehadiran_harian',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class ExamRepository {
  final dbHelper = DatabaseHelper.instance;

  // Get ujian by siswa
  Future<List<Ujian>> getUjianBySiswa(int siswaId) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'ujian',
      where: 'siswa_id = ?',
      whereArgs: [siswaId],
      orderBy: 'tanggal DESC',
    );
    return List.generate(maps.length, (i) => Ujian.fromMap(maps[i]));
  }

  // Get nilai ujian by ujian id
  Future<List<NilaiUjian>> getNilaiUjian(int ujianId) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'nilai_ujian',
      where: 'ujian_id = ?',
      whereArgs: [ujianId],
    );
    return List.generate(maps.length, (i) => NilaiUjian.fromMap(maps[i]));
  }

  // Insert ujian
  Future<int> insertUjian(Ujian ujian) async {
    final db = await dbHelper.database;
    return await db.insert('ujian', ujian.toMap());
  }

  // Insert nilai ujian
  Future<int> insertNilaiUjian(NilaiUjian nilai) async {
    final db = await dbHelper.database;
    return await db.insert('nilai_ujian', nilai.toMap());
  }

  // Update nilai ujian
  Future<int> updateNilaiUjian(NilaiUjian nilai) async {
    final db = await dbHelper.database;
    return await db.update(
      'nilai_ujian',
      nilai.toMap(),
      where: 'id = ?',
      whereArgs: [nilai.id],
    );
  }

  // Delete ujian
  Future<int> deleteUjian(int id) async {
    final db = await dbHelper.database;
    // Delete nilai ujian terlebih dahulu
    await db.delete('nilai_ujian', where: 'ujian_id = ?', whereArgs: [id]);
    // Kemudian delete ujian
    return await db.delete('ujian', where: 'id = ?', whereArgs: [id]);
  }
}

class LeaveRepository {
  final dbHelper = DatabaseHelper.instance;

  // Get semua pengajuan izin by siswa
  Future<List<PengajuanIzin>> getPengajuanIzin(int siswaId) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'pengajuan_izin',
      where: 'siswa_id = ?',
      whereArgs: [siswaId],
      orderBy: 'tanggal_pengajuan DESC',
    );
    return List.generate(maps.length, (i) => PengajuanIzin.fromMap(maps[i]));
  }

  // Get pengajuan izin by status
  Future<List<PengajuanIzin>> getPengajuanIzinByStatus(int siswaId, String status) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'pengajuan_izin',
      where: 'siswa_id = ? AND status = ?',
      whereArgs: [siswaId, status],
      orderBy: 'tanggal_pengajuan DESC',
    );
    return List.generate(maps.length, (i) => PengajuanIzin.fromMap(maps[i]));
  }

  // Insert pengajuan izin
  Future<int> insertPengajuanIzin(PengajuanIzin pengajuan) async {
    final db = await dbHelper.database;
    return await db.insert('pengajuan_izin', pengajuan.toMap());
  }

  // Update pengajuan izin
  Future<int> updatePengajuanIzin(PengajuanIzin pengajuan) async {
    final db = await dbHelper.database;
    return await db.update(
      'pengajuan_izin',
      pengajuan.toMap(),
      where: 'id = ?',
      whereArgs: [pengajuan.id],
    );
  }

  // Delete pengajuan izin
  Future<int> deletePengajuanIzin(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'pengajuan_izin',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Update status pengajuan
  Future<int> updateStatus(int id, String status) async {
    final db = await dbHelper.database;
    return await db.update(
      'pengajuan_izin',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class StudentRepository {
  final dbHelper = DatabaseHelper.instance;

  // Get siswa by id
  Future<Siswa?> getSiswaById(int id) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'siswa',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Siswa.fromMap(maps.first);
    }
    return null;
  }

  // Get siswa by NIS
  Future<Siswa?> getSiswaByNIS(String nis) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'siswa',
      where: 'nis = ?',
      whereArgs: [nis],
    );
    if (maps.isNotEmpty) {
      return Siswa.fromMap(maps.first);
    }
    return null;
  }

  // Get semua siswa
  Future<List<Siswa>> getAllSiswa() async {
    final db = await dbHelper.database;
    final maps = await db.query('siswa');
    return List.generate(maps.length, (i) => Siswa.fromMap(maps[i]));
  }

  // Insert siswa
  Future<int> insertSiswa(Siswa siswa) async {
    final db = await dbHelper.database;
    return await db.insert('siswa', siswa.toMap());
  }

  // Update siswa
  Future<int> updateSiswa(Siswa siswa) async {
    final db = await dbHelper.database;
    return await db.update(
      'siswa',
      siswa.toMap(),
      where: 'id = ?',
      whereArgs: [siswa.id],
    );
  }

  // Delete siswa
  Future<int> deleteSiswa(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'siswa',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class TimeTableRepository {
  final dbHelper = DatabaseHelper.instance;

  // Get jadwal by siswa dan hari
  Future<List<JadwalPelajaran>> getJadwalByHari(int siswaId, String hari) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'jadwal_pelajaran',
      where: 'siswa_id = ? AND hari = ?',
      whereArgs: [siswaId, hari],
      orderBy: 'jam_mulai ASC',
    );
    return List.generate(maps.length, (i) => JadwalPelajaran.fromMap(maps[i]));
  }

  // Get jadwal by tingkat kelas dan hari
  Future<List<JadwalPelajaran>> getJadwalByTingkatKelasAndHari(int tingkatKelas, String hari) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'jadwal_pelajaran',
      where: 'tingkat_kelas = ? AND hari = ?',
      whereArgs: [tingkatKelas, hari],
      orderBy: 'jam_mulai ASC',
    );
    return List.generate(maps.length, (i) => JadwalPelajaran.fromMap(maps[i]));
  }

  // Get semua jadwal siswa
  Future<List<JadwalPelajaran>> getAllJadwal(int siswaId) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'jadwal_pelajaran',
      where: 'siswa_id = ?',
      whereArgs: [siswaId],
      orderBy: 'jam_mulai ASC',
    );
    return List.generate(maps.length, (i) => JadwalPelajaran.fromMap(maps[i]));
  }

  // Get semua jadwal berdasarkan tingkat kelas
  Future<List<JadwalPelajaran>> getAllJadwalByTingkatKelas(int tingkatKelas) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'jadwal_pelajaran',
      where: 'tingkat_kelas = ?',
      whereArgs: [tingkatKelas],
      orderBy: 'jam_mulai ASC',
    );
    return List.generate(maps.length, (i) => JadwalPelajaran.fromMap(maps[i]));
  }

  // Get jadwal grouped by hari
  Future<Map<String, List<JadwalPelajaran>>> getJadwalGroupByHari(int siswaId) async {
    final allJadwal = await getAllJadwal(siswaId);
    final Map<String, List<JadwalPelajaran>> grouped = {};

    for (var jadwal in allJadwal) {
      if (!grouped.containsKey(jadwal.hari)) {
        grouped[jadwal.hari] = [];
      }
      grouped[jadwal.hari]!.add(jadwal);
    }

    return grouped;
  }

  // Get jadwal grouped by hari berdasarkan tingkat kelas
  Future<Map<String, List<JadwalPelajaran>>> getJadwalGroupByHariByTingkatKelas(int tingkatKelas) async {
    final allJadwal = await getAllJadwalByTingkatKelas(tingkatKelas);
    final Map<String, List<JadwalPelajaran>> grouped = {};

    for (var jadwal in allJadwal) {
      if (!grouped.containsKey(jadwal.hari)) {
        grouped[jadwal.hari] = [];
      }
      grouped[jadwal.hari]!.add(jadwal);
    }

    return grouped;
  }

  // Insert jadwal
  Future<int> insertJadwal(JadwalPelajaran jadwal) async {
    final db = await dbHelper.database;
    return await db.insert('jadwal_pelajaran', jadwal.toMap());
  }

  // Update jadwal
  Future<int> updateJadwal(JadwalPelajaran jadwal) async {
    final db = await dbHelper.database;
    return await db.update(
      'jadwal_pelajaran',
      jadwal.toMap(),
      where: 'id = ?',
      whereArgs: [jadwal.id],
    );
  }

  // Delete jadwal
  Future<int> deleteJadwal(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'jadwal_pelajaran',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class SiswaRepository {
  final dbHelper = DatabaseHelper.instance;

  // Get siswa by ID
  Future<Siswa?> getSiswaById(int id) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'siswa',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return Siswa.fromMap(maps.first);
  }

  // Get semua siswa
  Future<List<Siswa>> getAllSiswa() async {
    final db = await dbHelper.database;
    final maps = await db.query('siswa');
    return List.generate(maps.length, (i) => Siswa.fromMap(maps[i]));
  }

  // Insert siswa
  Future<int> insertSiswa(Siswa siswa) async {
    final db = await dbHelper.database;
    return await db.insert('siswa', siswa.toMap());
  }

  // Update siswa
  Future<int> updateSiswa(Siswa siswa) async {
    final db = await dbHelper.database;
    return await db.update(
      'siswa',
      siswa.toMap(),
      where: 'id = ?',
      whereArgs: [siswa.id],
    );
  }

  // Delete siswa
  Future<int> deleteSiswa(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'siswa',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

