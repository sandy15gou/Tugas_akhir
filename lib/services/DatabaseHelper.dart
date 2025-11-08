import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('school_management.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 4, // Increment version untuk trigger onCreate lagi
      onCreate: _createDB,
      onUpgrade: (db, oldVersion, newVersion) async {
        // Drop semua table dan buat ulang
        await db.execute('DROP TABLE IF EXISTS jadwal_pelajaran');
        await db.execute('DROP TABLE IF EXISTS kehadiran_harian');
        await db.execute('DROP TABLE IF EXISTS kehadiran_keseluruhan');
        await db.execute('DROP TABLE IF EXISTS nilai_ujian');
        await db.execute('DROP TABLE IF EXISTS ujian');
        await db.execute('DROP TABLE IF EXISTS pengajuan_izin');
        await db.execute('DROP TABLE IF EXISTS siswa');

        // Buat ulang semua table
        await _createDB(db, newVersion);
      },
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'INTEGER NOT NULL';
    const intType = 'INTEGER NOT NULL';

    // Tabel Siswa
    await db.execute('''
      CREATE TABLE siswa (
        id $idType,
        nis $textType,
        nama $textType,
        kelas $textType,
        sekolah $textType,
        foto TEXT
      )
    ''');

    // Tabel Jadwal Pelajaran
    await db.execute('''
      CREATE TABLE jadwal_pelajaran (
        id $idType,
        siswa_id $intType,
        tingkat_kelas $intType,
        hari $textType,
        mata_pelajaran $textType,
        guru $textType,
        jam_mulai $textType,
        jam_selesai $textType,
        ruangan $textType,
        FOREIGN KEY (siswa_id) REFERENCES siswa (id)
      )
    ''');

    // Tabel Kehadiran Harian
    await db.execute('''
      CREATE TABLE kehadiran_harian (
        id $idType,
        siswa_id $intType,
        tanggal $textType,
        mata_pelajaran $textType,
        guru $textType,
        jam_mulai $textType,
        jam_selesai $textType,
        status $boolType,
        FOREIGN KEY (siswa_id) REFERENCES siswa (id)
      )
    ''');

    // Tabel Kehadiran Keseluruhan
    await db.execute('''
      CREATE TABLE kehadiran_keseluruhan (
        id $idType,
        siswa_id $intType,
        tanggal $textType,
        hari $textType,
        hadir_pagi $boolType,
        hadir_siang $boolType,
        FOREIGN KEY (siswa_id) REFERENCES siswa (id)
      )
    ''');

    // Tabel Ujian
    await db.execute('''
      CREATE TABLE ujian (
        id $idType,
        siswa_id $intType,
        nama_ujian $textType,
        tanggal $textType,
        FOREIGN KEY (siswa_id) REFERENCES siswa (id)
      )
    ''');

    // Tabel Nilai Ujian
    await db.execute('''
      CREATE TABLE nilai_ujian (
        id $idType,
        ujian_id $intType,
        mata_pelajaran $textType,
        bab $textType,
        tanggal $textType,
        jam $textType,
        nilai $intType,
        grade $textType,
        FOREIGN KEY (ujian_id) REFERENCES ujian (id)
      )
    ''');

    // Tabel Pengajuan Izin
    await db.execute('''
      CREATE TABLE pengajuan_izin (
        id $idType,
        siswa_id $intType,
        tipe_izin $textType,
        alasan $textType,
        keterangan TEXT,
        tanggal_pengajuan $textType,
        tanggal_mulai $textType,
        tanggal_selesai $textType,
        status $textType,
        dokumen TEXT,
        FOREIGN KEY (siswa_id) REFERENCES siswa (id)
      )
    ''');

    // Insert data dummy siswa
    await db.insert('siswa', {
      'nis': 'NIS-2024001',
      'nama': 'Ahmad Zulfikar',
      'kelas': '8A',
      'sekolah': 'SMPN 1 Jambi',
      'foto': 'assets/home.png'
    });

    // Insert data dummy kehadiran harian untuk siswa kelas 7 (ID: 4)
    await db.insert('kehadiran_harian', {
      'siswa_id': 4,
      'tanggal': '2024-11-07',
      'mata_pelajaran': 'Matematika Dasar',
      'guru': 'Siti Nurhaliza',
      'jam_mulai': '07.00',
      'jam_selesai': '08.30',
      'status': 1
    });

    await db.insert('kehadiran_harian', {
      'siswa_id': 4,
      'tanggal': '2024-11-07',
      'mata_pelajaran': 'Bahasa Indonesia',
      'guru': 'Ahmad Fauzi',
      'jam_mulai': '08.30',
      'jam_selesai': '10.00',
      'status': 1
    });

    await db.insert('kehadiran_harian', {
      'siswa_id': 4,
      'tanggal': '2024-11-07',
      'mata_pelajaran': 'IPA Terpadu',
      'guru': 'Dewi Kusuma',
      'jam_mulai': '10.15',
      'jam_selesai': '11.45',
      'status': 0
    });

    // Insert data dummy kehadiran harian untuk siswa kelas 8 (ID: 5)
    await db.insert('kehadiran_harian', {
      'siswa_id': 5,
      'tanggal': '2024-11-07',
      'mata_pelajaran': 'Bahasa Inggris',
      'guru': 'Budi Santoso',
      'jam_mulai': '09.00',
      'jam_selesai': '10.00',
      'status': 1
    });

    await db.insert('kehadiran_harian', {
      'siswa_id': 5,
      'tanggal': '2024-11-07',
      'mata_pelajaran': 'Matematika',
      'guru': 'Siti Nurhaliza',
      'jam_mulai': '10.00',
      'jam_selesai': '11.00',
      'status': 1
    });

    await db.insert('kehadiran_harian', {
      'siswa_id': 5,
      'tanggal': '2024-11-07',
      'mata_pelajaran': 'IPA',
      'guru': 'Dewi Kusuma',
      'jam_mulai': '11.00',
      'jam_selesai': '12.00',
      'status': 0
    });

    // Insert data dummy kehadiran harian untuk siswa kelas 9 (ID: 6)
    await db.insert('kehadiran_harian', {
      'siswa_id': 6,
      'tanggal': '2024-11-07',
      'mata_pelajaran': 'Matematika Lanjut',
      'guru': 'Siti Nurhaliza',
      'jam_mulai': '07.00',
      'jam_selesai': '08.30',
      'status': 1
    });

    await db.insert('kehadiran_harian', {
      'siswa_id': 6,
      'tanggal': '2024-11-07',
      'mata_pelajaran': 'Fisika',
      'guru': 'Dewi Kusuma',
      'jam_mulai': '08.30',
      'jam_selesai': '10.00',
      'status': 1
    });

    await db.insert('kehadiran_harian', {
      'siswa_id': 6,
      'tanggal': '2024-11-07',
      'mata_pelajaran': 'Bahasa Inggris',
      'guru': 'Budi Santoso',
      'jam_mulai': '10.15',
      'jam_selesai': '11.45',
      'status': 1
    });

    // Insert data dummy kehadiran harian untuk guru (ID: 2)
    await db.insert('kehadiran_harian', {
      'siswa_id': 2,
      'tanggal': '2024-11-07',
      'mata_pelajaran': 'Matematika Kelas 8A',
      'guru': 'Siti Nurhaliza',
      'jam_mulai': '07.00',
      'jam_selesai': '08.30',
      'status': 1
    });

    await db.insert('kehadiran_harian', {
      'siswa_id': 2,
      'tanggal': '2024-11-07',
      'mata_pelajaran': 'Matematika Kelas 8B',
      'guru': 'Siti Nurhaliza',
      'jam_mulai': '08.30',
      'jam_selesai': '10.00',
      'status': 1
    });

    await db.insert('kehadiran_harian', {
      'siswa_id': 2,
      'tanggal': '2024-11-07',
      'mata_pelajaran': 'Matematika Kelas 9A',
      'guru': 'Siti Nurhaliza',
      'jam_mulai': '10.15',
      'jam_selesai': '11.45',
      'status': 1
    });

    // Insert data dummy kehadiran keseluruhan
    final dates = [
      {'date': '2020-12-19', 'day': 'Sabtu', 'pagi': 1, 'siang': 1},
      {'date': '2020-12-22', 'day': 'Senin', 'pagi': 1, 'siang': 0},
      {'date': '2020-12-23', 'day': 'Selasa', 'pagi': 1, 'siang': 1},
      {'date': '2020-12-24', 'day': 'Rabu', 'pagi': 0, 'siang': 0},
      {'date': '2020-12-25', 'day': 'Kamis', 'pagi': 1, 'siang': 1},
      {'date': '2020-12-26', 'day': 'Jumat', 'pagi': 1, 'siang': 1},
    ];

    // Data untuk siswa kelas 7 (ID: 4)
    for (var data in dates) {
      await db.insert('kehadiran_keseluruhan', {
        'siswa_id': 4,
        'tanggal': data['date'],
        'hari': data['day'],
        'hadir_pagi': data['pagi'],
        'hadir_siang': data['siang'],
      });
    }

    // Data untuk siswa kelas 8 (ID: 5)
    for (var data in dates) {
      await db.insert('kehadiran_keseluruhan', {
        'siswa_id': 5,
        'tanggal': data['date'],
        'hari': data['day'],
        'hadir_pagi': data['pagi'],
        'hadir_siang': data['siang'],
      });
    }

    // Data untuk siswa kelas 9 (ID: 6)
    for (var data in dates) {
      await db.insert('kehadiran_keseluruhan', {
        'siswa_id': 6,
        'tanggal': data['date'],
        'hari': data['day'],
        'hadir_pagi': data['pagi'],
        'hadir_siang': data['siang'],
      });
    }

    // Data untuk guru (ID: 2)
    final datesGuru = [
      {'date': '2020-12-19', 'day': 'Sabtu', 'pagi': 1, 'siang': 1},
      {'date': '2020-12-22', 'day': 'Senin', 'pagi': 1, 'siang': 0},
      {'date': '2020-12-23', 'day': 'Selasa', 'pagi': 1, 'siang': 1},
      {'date': '2020-12-24', 'day': 'Rabu', 'pagi': 0, 'siang': 0},
      {'date': '2020-12-25', 'day': 'Kamis', 'pagi': 1, 'siang': 1},
      {'date': '2020-12-26', 'day': 'Jumat', 'pagi': 1, 'siang': 1},
    ];

    for (var data in datesGuru) {
      await db.insert('kehadiran_keseluruhan', {
        'siswa_id': 2,
        'tanggal': data['date'],
        'hari': data['day'],
        'hadir_pagi': data['pagi'],
        'hadir_siang': data['siang'],
      });
    }

    // Data untuk guru 2 (ID: 3)
    for (var data in datesGuru) {
      await db.insert('kehadiran_keseluruhan', {
        'siswa_id': 3,
        'tanggal': data['date'],
        'hari': data['day'],
        'hadir_pagi': data['pagi'],
        'hadir_siang': data['siang'],
      });
    }

    // Insert data dummy ujian
    await db.insert('ujian', {
      'siswa_id': 1,
      'nama_ujian': 'Ujian Semester 1',
      'tanggal': '15/12/2020'
    });

    // Insert data dummy nilai ujian
    await db.insert('nilai_ujian', {
      'ujian_id': 1,
      'mata_pelajaran': 'Bahasa (Tamil)',
      'bab': '1-5',
      'tanggal': '12/12/2020',
      'jam': '9.00-10.00',
      'nilai': 90,
      'grade': 'A+'
    });

    await db.insert('nilai_ujian', {
      'ujian_id': 1,
      'mata_pelajaran': 'Bahasa Inggris',
      'bab': '1-5',
      'tanggal': '13/12/2020',
      'jam': '9.00-10.00',
      'nilai': 85,
      'grade': 'A+'
    });

    // Insert data dummy pengajuan izin
    await db.insert('pengajuan_izin', {
      'siswa_id': 1,
      'tipe_izin': 'Sakit',
      'alasan': 'Sakit',
      'keterangan': 'Ini contoh alasan izin. Ini contoh alasan izin. Ini contoh alasan izin.',
      'tanggal_pengajuan': '05.12.2020',
      'tanggal_mulai': '11.12.2020',
      'tanggal_selesai': '12.12.2020',
      'status': 'Disetujui',
      'dokumen': null
    });

    // Insert data dummy jadwal pelajaran
    // Jadwal untuk Kelas 7
    final jadwalKelas7 = [
      // SENIN
      {'hari': 'Senin', 'mapel': 'Matematika Dasar', 'guru': 'Siti Nurhaliza', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 7A'},
      {'hari': 'Senin', 'mapel': 'Bahasa Indonesia', 'guru': 'Ahmad Fauzi', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 7A'},
      {'hari': 'Senin', 'mapel': 'IPA Terpadu', 'guru': 'Dewi Kusuma', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Lab IPA'},
      {'hari': 'Senin', 'mapel': 'Bahasa Inggris', 'guru': 'Budi Santoso', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Ruang 7A'},
      // SELASA
      {'hari': 'Selasa', 'mapel': 'IPS Terpadu', 'guru': 'Rahmat Hidayat', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 7A'},
      {'hari': 'Selasa', 'mapel': 'Pendidikan Agama', 'guru': 'Ustadz Yusuf', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 7A'},
      {'hari': 'Selasa', 'mapel': 'Matematika Dasar', 'guru': 'Siti Nurhaliza', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Ruang 7A'},
      {'hari': 'Selasa', 'mapel': 'Seni Budaya', 'guru': 'Rina Amelia', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Ruang Seni'},
      // RABU
      {'hari': 'Rabu', 'mapel': 'PJOK', 'guru': 'Pak Agus', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Lapangan'},
      {'hari': 'Rabu', 'mapel': 'Bahasa Inggris', 'guru': 'Budi Santoso', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 7A'},
      {'hari': 'Rabu', 'mapel': 'PKn', 'guru': 'Rina Kartika', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Ruang 7A'},
      {'hari': 'Rabu', 'mapel': 'Prakarya', 'guru': 'Fitri Handayani', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Ruang Praktek'},
      // KAMIS
      {'hari': 'Kamis', 'mapel': 'Matematika Dasar', 'guru': 'Siti Nurhaliza', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 7A'},
      {'hari': 'Kamis', 'mapel': 'Bahasa Indonesia', 'guru': 'Ahmad Fauzi', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 7A'},
      {'hari': 'Kamis', 'mapel': 'IPA Terpadu', 'guru': 'Dewi Kusuma', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Lab IPA'},
      {'hari': 'Kamis', 'mapel': 'TIK', 'guru': 'Hendra Wijaya', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Lab Komputer'},
      // JUMAT
      {'hari': 'Jumat', 'mapel': 'Pendidikan Agama', 'guru': 'Ustadz Yusuf', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 7A'},
      {'hari': 'Jumat', 'mapel': 'Bahasa Daerah', 'guru': 'Ibu Ratna', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 7A'},
    ];

    // Jadwal untuk Kelas 8
    final jadwalKelas8 = [
      // SENIN
      {'hari': 'Senin', 'mapel': 'Matematika', 'guru': 'Siti Nurhaliza', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 8A'},
      {'hari': 'Senin', 'mapel': 'Bahasa Indonesia', 'guru': 'Ahmad Fauzi', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 8A'},
      {'hari': 'Senin', 'mapel': 'IPA', 'guru': 'Dewi Kusuma', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Lab IPA'},
      {'hari': 'Senin', 'mapel': 'Bahasa Inggris', 'guru': 'Budi Santoso', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Ruang 8A'},
      // SELASA
      {'hari': 'Selasa', 'mapel': 'IPS', 'guru': 'Rahmat Hidayat', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 8A'},
      {'hari': 'Selasa', 'mapel': 'Pendidikan Agama', 'guru': 'Ustadz Yusuf', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 8A'},
      {'hari': 'Selasa', 'mapel': 'Matematika', 'guru': 'Siti Nurhaliza', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Ruang 8A'},
      {'hari': 'Selasa', 'mapel': 'Seni Budaya', 'guru': 'Rina Amelia', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Ruang Seni'},
      // RABU
      {'hari': 'Rabu', 'mapel': 'PJOK', 'guru': 'Pak Agus', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Lapangan'},
      {'hari': 'Rabu', 'mapel': 'Bahasa Inggris', 'guru': 'Budi Santoso', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 8A'},
      {'hari': 'Rabu', 'mapel': 'IPA', 'guru': 'Dewi Kusuma', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Lab IPA'},
      {'hari': 'Rabu', 'mapel': 'Prakarya', 'guru': 'Fitri Handayani', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Ruang Praktek'},
      // KAMIS
      {'hari': 'Kamis', 'mapel': 'Matematika', 'guru': 'Siti Nurhaliza', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 8A'},
      {'hari': 'Kamis', 'mapel': 'Bahasa Indonesia', 'guru': 'Ahmad Fauzi', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 8A'},
      {'hari': 'Kamis', 'mapel': 'IPS', 'guru': 'Rahmat Hidayat', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Ruang 8A'},
      {'hari': 'Kamis', 'mapel': 'TIK', 'guru': 'Hendra Wijaya', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Lab Komputer'},
      // JUMAT
      {'hari': 'Jumat', 'mapel': 'Pendidikan Agama', 'guru': 'Ustadz Yusuf', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 8A'},
      {'hari': 'Jumat', 'mapel': 'Bahasa Daerah', 'guru': 'Ibu Ratna', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 8A'},
    ];

    // Jadwal untuk Kelas 9
    final jadwalKelas9 = [
      // SENIN
      {'hari': 'Senin', 'mapel': 'Matematika Lanjut', 'guru': 'Siti Nurhaliza', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 9A'},
      {'hari': 'Senin', 'mapel': 'Bahasa Indonesia', 'guru': 'Ahmad Fauzi', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 9A'},
      {'hari': 'Senin', 'mapel': 'Fisika', 'guru': 'Dewi Kusuma', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Lab IPA'},
      {'hari': 'Senin', 'mapel': 'Bahasa Inggris', 'guru': 'Budi Santoso', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Ruang 9A'},
      // SELASA
      {'hari': 'Selasa', 'mapel': 'Ekonomi', 'guru': 'Rahmat Hidayat', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 9A'},
      {'hari': 'Selasa', 'mapel': 'Pendidikan Agama', 'guru': 'Ustadz Yusuf', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 9A'},
      {'hari': 'Selasa', 'mapel': 'Matematika Lanjut', 'guru': 'Siti Nurhaliza', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Ruang 9A'},
      {'hari': 'Selasa', 'mapel': 'Seni Budaya', 'guru': 'Rina Amelia', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Ruang Seni'},
      // RABU
      {'hari': 'Rabu', 'mapel': 'PJOK', 'guru': 'Pak Agus', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Lapangan'},
      {'hari': 'Rabu', 'mapel': 'Bahasa Inggris', 'guru': 'Budi Santoso', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 9A'},
      {'hari': 'Rabu', 'mapel': 'Kimia', 'guru': 'Dewi Kusuma', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Lab IPA'},
      {'hari': 'Rabu', 'mapel': 'Persiapan UN', 'guru': 'Tim Pengajar', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Ruang 9A'},
      // KAMIS
      {'hari': 'Kamis', 'mapel': 'Matematika Lanjut', 'guru': 'Siti Nurhaliza', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 9A'},
      {'hari': 'Kamis', 'mapel': 'Bahasa Indonesia', 'guru': 'Ahmad Fauzi', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 9A'},
      {'hari': 'Kamis', 'mapel': 'Geografi', 'guru': 'Rahmat Hidayat', 'mulai': '10.15', 'selesai': '11.45', 'ruangan': 'Ruang 9A'},
      {'hari': 'Kamis', 'mapel': 'TIK', 'guru': 'Hendra Wijaya', 'mulai': '12.30', 'selesai': '14.00', 'ruangan': 'Lab Komputer'},
      // JUMAT
      {'hari': 'Jumat', 'mapel': 'Pendidikan Agama', 'guru': 'Ustadz Yusuf', 'mulai': '07.00', 'selesai': '08.30', 'ruangan': 'Ruang 9A'},
      {'hari': 'Jumat', 'mapel': 'Bimbingan Konseling', 'guru': 'Bu Ratna', 'mulai': '08.30', 'selesai': '10.00', 'ruangan': 'Ruang 9A'},
    ];

    // Insert jadwal kelas 7 (siswa_id: 4)
    for (var jadwal in jadwalKelas7) {
      await db.insert('jadwal_pelajaran', {
        'siswa_id': 4,
        'tingkat_kelas': 7,
        'hari': jadwal['hari'],
        'mata_pelajaran': jadwal['mapel'],
        'guru': jadwal['guru'],
        'jam_mulai': jadwal['mulai'],
        'jam_selesai': jadwal['selesai'],
        'ruangan': jadwal['ruangan'],
      });
    }

    // Insert jadwal kelas 8 (siswa_id: 3)
    for (var jadwal in jadwalKelas8) {
      await db.insert('jadwal_pelajaran', {
        'siswa_id': 3,
        'tingkat_kelas': 8,
        'hari': jadwal['hari'],
        'mata_pelajaran': jadwal['mapel'],
        'guru': jadwal['guru'],
        'jam_mulai': jadwal['mulai'],
        'jam_selesai': jadwal['selesai'],
        'ruangan': jadwal['ruangan'],
      });
    }

    // Insert jadwal kelas 9 (siswa_id: 5)
    for (var jadwal in jadwalKelas9) {
      await db.insert('jadwal_pelajaran', {
        'siswa_id': 5,
        'tingkat_kelas': 9,
        'hari': jadwal['hari'],
        'mata_pelajaran': jadwal['mapel'],
        'guru': jadwal['guru'],
        'jam_mulai': jadwal['mulai'],
        'jam_selesai': jadwal['selesai'],
        'ruangan': jadwal['ruangan'],
      });
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

