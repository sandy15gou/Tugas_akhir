# 🔐 Panduan Login - Aplikasi Manajemen Sekolah SMPN 1 Jambi

## 📚 Daftar Akun Login

### 👤 **1. ADMIN**
**Username:** `admin`  
**Password:** `admin123`

#### Hak Akses Admin:
- ✅ **Full Access** ke semua fitur
- ✅ Dapat mengelola (CRUD) **Jadwal Pelajaran**
- ✅ Dapat mengelola (CRUD) **Prestasi Siswa**
- ✅ Dapat melihat semua data siswa dan guru
- ✅ Dapat melihat dashboard lengkap

---

### 👨‍🏫 **2. GURU**

#### **Guru 1 - Siti Nurhaliza (Guru Matematika)**
**Username:** `guru1`  
**Password:** `guru123`  
**NIP:** 198501012010012001

#### **Guru 2 - Budi Santoso (Guru Bahasa Inggris)**
**Username:** `guru2`  
**Password:** `guru123`  
**NIP:** 198605152011012002

#### Hak Akses Guru:
- ✅ Dapat melihat **Jadwal Pelajaran** (Read Only)
- ✅ Dapat melihat **Kehadiran** mereka sendiri
- ✅ Dapat melihat **Prestasi Siswa** (Read Only)
- ❌ **TIDAK** bisa mengedit Jadwal atau Prestasi

---

### 👨‍🎓 **3. SISWA**

#### **Siswa 1 - Ahmad Fadhil (Kelas 7A)**
**Username:** `siswa7`  
**Password:** `siswa123`  
**NIS:** NIS-2024007  
**Kelas:** 7A

**Jadwal Pelajaran yang Ditampilkan:**
- Matematika Dasar
- IPA Terpadu
- IPS Terpadu
- Bahasa Indonesia
- Bahasa Inggris
- PKn
- Dan mata pelajaran Kelas 7 lainnya

---

#### **Siswa 2 - Rizki Ramadhan (Kelas 8A)**
**Username:** `siswa8`  
**Password:** `siswa123`  
**NIS:** NIS-2024008  
**Kelas:** 8A

**Jadwal Pelajaran yang Ditampilkan:**
- Matematika
- IPA
- IPS
- Bahasa Indonesia
- Bahasa Inggris
- Dan mata pelajaran Kelas 8 lainnya

---

#### **Siswa 3 - Dewi Lestari (Kelas 9A)**
**Username:** `siswa9`  
**Password:** `siswa123`  
**NIS:** NIS-2024009  
**Kelas:** 9A

**Jadwal Pelajaran yang Ditampilkan:**
- Matematika Lanjut
- Fisika
- Kimia
- Ekonomi
- Geografi
- Persiapan UN
- Dan mata pelajaran Kelas 9 lainnya

---

#### Hak Akses Siswa:
- ✅ Dapat melihat **Jadwal Pelajaran** sesuai kelas mereka
- ✅ Dapat melihat **Kehadiran** mereka sendiri
- ✅ Dapat mengajukan **Izin/Sakit**
- ✅ Dapat melihat **Prestasi Siswa** (Read Only)
- ✅ Dapat melihat **Profil** mereka
- ❌ **TIDAK** bisa mengedit Jadwal atau Prestasi

---

## 🎯 Fitur Berdasarkan Role

| Fitur | Admin | Guru | Siswa |
|-------|-------|------|-------|
| Dashboard | ✅ | ✅ | ✅ |
| Lihat Jadwal Pelajaran | ✅ | ✅ | ✅ (Sesuai Kelas) |
| Edit Jadwal Pelajaran | ✅ | ❌ | ❌ |
| Lihat Kehadiran | ✅ | ✅ (Sendiri) | ✅ (Sendiri) |
| Lihat Prestasi | ✅ | ✅ | ✅ |
| Edit Prestasi | ✅ | ❌ | ❌ |
| Ajukan Izin | ✅ | ✅ | ✅ |
| Lihat Perpustakaan | ✅ | ✅ | ✅ |
| Tentang Kami | ✅ | ✅ | ✅ |
| Profil | ✅ | ✅ | ✅ |

---

## 📱 Cara Login

1. **Buka Aplikasi**
2. Pada halaman login, masukkan **Username** dan **Password**
3. Pilih **Role** (Siswa / Guru)
   - Jika login sebagai **Siswa**, sistem akan otomatis mendeteksi kelas
   - Jika login sebagai **Guru**, sistem akan menampilkan info guru
4. Klik tombol **LOGIN**
5. Dashboard akan muncul sesuai dengan role yang login

---

## 📝 Cara Registrasi Akun Baru

1. **Buka Aplikasi** dan klik **"Registrasi"** di halaman login
2. **Pilih Role**: Siswa atau Guru
3. **Isi Data yang Diperlukan:**
   
   **Untuk Siswa:**
   - Nama Lengkap
   - NIS (Nomor Induk Siswa) - Contoh: NIS-2024001
   - **Kelas** (Dropdown) - Pilih kelas: 7A, 7B, 7C, 8A, 8B, 8C, 9A, 9B, 9C
   - Username (minimal 4 karakter)
   - Password (minimal 6 karakter)
   - Konfirmasi Password
   
   **Untuk Guru:**
   - Nama Lengkap
   - NIP (Nomor Induk Pegawai) - Contoh: 198501012010012001
   - Username (minimal 4 karakter)
   - Password (minimal 6 karakter)
   - Konfirmasi Password

4. **Klik DAFTAR**
5. Jika berhasil, sistem akan redirect ke halaman login
6. **Login** dengan username dan password yang baru dibuat

**Catatan Penting:**
- ⚠️ Dropdown kelas **WAJIB** dipilih untuk siswa
- ✅ Kelas akan otomatis tersimpan dan ditampilkan di profil
- 📊 Jadwal pelajaran akan disesuaikan dengan tingkat kelas (7, 8, atau 9)

---

## 🔍 Perbedaan Tampilan Dashboard

### Dashboard Admin:
- Menampilkan nama: **Administrator**
- Role: **ADMIN**
- Tombol **+** muncul di halaman Jadwal & Prestasi

### Dashboard Guru:
- Menampilkan nama guru (contoh: **Siti Nurhaliza**)
- Label: **GURU**
- NIP ditampilkan
- Mata pelajaran yang diampu
- Tombol **+** TIDAK muncul

### Dashboard Siswa:
- Menampilkan nama siswa (contoh: **Ahmad Fadhil**)
- Label: **SISWA**
- NIS ditampilkan
- Kelas ditampilkan (contoh: **7A**)
- Tombol **+** TIDAK muncul

---

## 🎓 Fitur Khusus Sistem Mata Pelajaran

Sistem ini menggunakan **Smart Class Detection**:
- Siswa kelas 7 akan melihat mata pelajaran kelas 7
- Siswa kelas 8 akan melihat mata pelajaran kelas 8
- Siswa kelas 9 akan melihat mata pelajaran kelas 9

**Contoh:**
- Login sebagai `siswa7` → Melihat "Matematika Dasar"
- Login sebagai `siswa8` → Melihat "Matematika"
- Login sebagai `siswa9` → Melihat "Matematika Lanjut"

---

## ✅ Testing Checklist

### Test Login Admin:
- [ ] Login dengan `admin` / `admin123`
- [ ] Dashboard menampilkan "Administrator"
- [ ] Tombol + muncul di Jadwal Pelajaran
- [ ] Tombol + muncul di Prestasi
- [ ] Bisa tambah/edit/hapus jadwal
- [ ] Bisa tambah/edit/hapus prestasi

### Test Login Guru:
- [ ] Login dengan `guru1` / `guru123`
- [ ] Dashboard menampilkan "Siti Nurhaliza"
- [ ] NIP ditampilkan dengan benar
- [ ] Kehadiran menampilkan data guru
- [ ] Tombol + TIDAK muncul di Jadwal
- [ ] Tombol + TIDAK muncul di Prestasi

### Test Login Siswa Kelas 7:
- [ ] Login dengan `siswa7` / `siswa123`
- [ ] Dashboard menampilkan "Ahmad Fadhil - 7A"
- [ ] Jadwal menampilkan mata pelajaran Kelas 7
- [ ] Kehadiran menampilkan data Ahmad Fadhil
- [ ] Mata pelajaran sesuai: "Matematika Dasar", "IPA Terpadu", dll

### Test Login Siswa Kelas 8:
- [ ] Login dengan `siswa8` / `siswa123`
- [ ] Dashboard menampilkan "Rizki Ramadhan - 8A"
- [ ] Jadwal menampilkan mata pelajaran Kelas 8
- [ ] Kehadiran menampilkan data Rizki Ramadhan
- [ ] Mata pelajaran sesuai: "Matematika", "IPA", "IPS", dll

### Test Login Siswa Kelas 9:
- [ ] Login dengan `siswa9` / `siswa123`
- [ ] Dashboard menampilkan "Dewi Lestari - 9A"
- [ ] Jadwal menampilkan mata pelajaran Kelas 9
- [ ] Kehadiran menampilkan data Dewi Lestari
- [ ] Mata pelajaran sesuai: "Matematika Lanjut", "Fisika", "Kimia", dll

---

## 📞 Informasi Sekolah

**Nama Sekolah:** SMPN 1 Kota Jambi  
**Alamat:** Jl. Jenderal Sudirman No. 1, Kota Jambi  
**Email:** smpn1@jambi.sch.id  
**Telepon:** (0741) 123456

---

## 🚀 Quick Start

```bash
# 1. Uninstall aplikasi lama (jika ada)
adb uninstall com.example.tugas_akhir

# 2. Jalankan aplikasi
flutter run

# 3. Login dengan salah satu akun di atas
# 4. Explore fitur-fitur yang tersedia
```

---

## 📝 Catatan Penting

- ⚠️ **Jangan lupa logout** setelah selesai menggunakan aplikasi
- 🔒 Password default semua akun adalah `siswa123` untuk siswa dan `guru123` untuk guru
- 💾 Data dummy sudah tersedia untuk testing
- 🔄 Database akan di-reset jika aplikasi di-uninstall
- 📊 Setiap user memiliki data kehadiran masing-masing

---

## 🐛 Troubleshooting

**Masalah: Tidak bisa login**
- Pastikan username dan password benar
- Pastikan memilih role yang sesuai (Siswa/Guru)

**Masalah: Jadwal kosong**
- Pastikan sudah login dengan akun yang benar
- Untuk siswa, pastikan data kelas terdeteksi

**Masalah: Data tidak muncul**
- Coba logout dan login kembali
- Restart aplikasi
- Reinstall aplikasi jika perlu

---

**Dibuat oleh:** Tim Developer SMPN 1 Kota Jambi  
**Last Updated:** November 2024  
**Version:** 1.0.0

