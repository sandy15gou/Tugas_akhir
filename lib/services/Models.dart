class Siswa {
  final int? id;
  final String nis;
  final String nama;
  final String kelas;
  final String sekolah;
  final String? foto;

  Siswa({
    this.id,
    required this.nis,
    required this.nama,
    required this.kelas,
    required this.sekolah,
    this.foto,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nis': nis,
      'nama': nama,
      'kelas': kelas,
      'sekolah': sekolah,
      'foto': foto,
    };
  }

  factory Siswa.fromMap(Map<String, dynamic> map) {
    return Siswa(
      id: map['id'],
      nis: map['nis'],
      nama: map['nama'],
      kelas: map['kelas'],
      sekolah: map['sekolah'],
      foto: map['foto'],
    );
  }
}

class KehadiranHarian {
  final int? id;
  final int siswaId;
  final String tanggal;
  final String mataPelajaran;
  final String guru;
  final String jamMulai;
  final String jamSelesai;
  final bool status;

  KehadiranHarian({
    this.id,
    required this.siswaId,
    required this.tanggal,
    required this.mataPelajaran,
    required this.guru,
    required this.jamMulai,
    required this.jamSelesai,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'siswa_id': siswaId,
      'tanggal': tanggal,
      'mata_pelajaran': mataPelajaran,
      'guru': guru,
      'jam_mulai': jamMulai,
      'jam_selesai': jamSelesai,
      'status': status ? 1 : 0,
    };
  }

  factory KehadiranHarian.fromMap(Map<String, dynamic> map) {
    return KehadiranHarian(
      id: map['id'],
      siswaId: map['siswa_id'],
      tanggal: map['tanggal'],
      mataPelajaran: map['mata_pelajaran'],
      guru: map['guru'],
      jamMulai: map['jam_mulai'],
      jamSelesai: map['jam_selesai'],
      status: map['status'] == 1,
    );
  }
}

class KehadiranKeseluruhan {
  final int? id;
  final int siswaId;
  final String tanggal;
  final String hari;
  final bool hadirPagi;
  final bool hadirSiang;

  KehadiranKeseluruhan({
    this.id,
    required this.siswaId,
    required this.tanggal,
    required this.hari,
    required this.hadirPagi,
    required this.hadirSiang,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'siswa_id': siswaId,
      'tanggal': tanggal,
      'hari': hari,
      'hadir_pagi': hadirPagi ? 1 : 0,
      'hadir_siang': hadirSiang ? 1 : 0,
    };
  }

  factory KehadiranKeseluruhan.fromMap(Map<String, dynamic> map) {
    return KehadiranKeseluruhan(
      id: map['id'],
      siswaId: map['siswa_id'],
      tanggal: map['tanggal'],
      hari: map['hari'],
      hadirPagi: map['hadir_pagi'] == 1,
      hadirSiang: map['hadir_siang'] == 1,
    );
  }
}

class Ujian {
  final int? id;
  final int siswaId;
  final String namaUjian;
  final String tanggal;

  Ujian({
    this.id,
    required this.siswaId,
    required this.namaUjian,
    required this.tanggal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'siswa_id': siswaId,
      'nama_ujian': namaUjian,
      'tanggal': tanggal,
    };
  }

  factory Ujian.fromMap(Map<String, dynamic> map) {
    return Ujian(
      id: map['id'],
      siswaId: map['siswa_id'],
      namaUjian: map['nama_ujian'],
      tanggal: map['tanggal'],
    );
  }
}

class NilaiUjian {
  final int? id;
  final int ujianId;
  final String mataPelajaran;
  final String bab;
  final String tanggal;
  final String jam;
  final int nilai;
  final String grade;

  NilaiUjian({
    this.id,
    required this.ujianId,
    required this.mataPelajaran,
    required this.bab,
    required this.tanggal,
    required this.jam,
    required this.nilai,
    required this.grade,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ujian_id': ujianId,
      'mata_pelajaran': mataPelajaran,
      'bab': bab,
      'tanggal': tanggal,
      'jam': jam,
      'nilai': nilai,
      'grade': grade,
    };
  }

  factory NilaiUjian.fromMap(Map<String, dynamic> map) {
    return NilaiUjian(
      id: map['id'],
      ujianId: map['ujian_id'],
      mataPelajaran: map['mata_pelajaran'],
      bab: map['bab'],
      tanggal: map['tanggal'],
      jam: map['jam'],
      nilai: map['nilai'],
      grade: map['grade'],
    );
  }
}

class PengajuanIzin {
  final int? id;
  final int siswaId;
  final String tipeIzin;
  final String alasan;
  final String keterangan;
  final String tanggalPengajuan;
  final String tanggalMulai;
  final String tanggalSelesai;
  final String status;
  final String? dokumen;

  PengajuanIzin({
    this.id,
    required this.siswaId,
    required this.tipeIzin,
    required this.alasan,
    required this.keterangan,
    required this.tanggalPengajuan,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.status,
    this.dokumen,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'siswa_id': siswaId,
      'tipe_izin': tipeIzin,
      'alasan': alasan,
      'keterangan': keterangan,
      'tanggal_pengajuan': tanggalPengajuan,
      'tanggal_mulai': tanggalMulai,
      'tanggal_selesai': tanggalSelesai,
      'status': status,
      'dokumen': dokumen,
    };
  }

  factory PengajuanIzin.fromMap(Map<String, dynamic> map) {
    return PengajuanIzin(
      id: map['id'],
      siswaId: map['siswa_id'],
      tipeIzin: map['tipe_izin'],
      alasan: map['alasan'],
      keterangan: map['keterangan'],
      tanggalPengajuan: map['tanggal_pengajuan'],
      tanggalMulai: map['tanggal_mulai'],
      tanggalSelesai: map['tanggal_selesai'],
      status: map['status'],
      dokumen: map['dokumen'],
    );
  }
}

class JadwalPelajaran {
  final int? id;
  final int siswaId;
  final int tingkatKelas;
  final String hari;
  final String mataPelajaran;
  final String guru;
  final String jamMulai;
  final String jamSelesai;
  final String ruangan;

  JadwalPelajaran({
    this.id,
    required this.siswaId,
    required this.tingkatKelas,
    required this.hari,
    required this.mataPelajaran,
    required this.guru,
    required this.jamMulai,
    required this.jamSelesai,
    required this.ruangan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'siswa_id': siswaId,
      'tingkat_kelas': tingkatKelas,
      'hari': hari,
      'mata_pelajaran': mataPelajaran,
      'guru': guru,
      'jam_mulai': jamMulai,
      'jam_selesai': jamSelesai,
      'ruangan': ruangan,
    };
  }

  factory JadwalPelajaran.fromMap(Map<String, dynamic> map) {
    return JadwalPelajaran(
      id: map['id'],
      siswaId: map['siswa_id'],
      tingkatKelas: map['tingkat_kelas'],
      hari: map['hari'],
      mataPelajaran: map['mata_pelajaran'],
      guru: map['guru'],
      jamMulai: map['jam_mulai'],
      jamSelesai: map['jam_selesai'],
      ruangan: map['ruangan'],
    );
  }
}

