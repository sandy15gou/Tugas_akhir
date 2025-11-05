# 🎓 TUGAS AKHIR - School Management System

## Dashboard Only Version (No Login/Logout Required)

Aplikasi manajemen sekolah berbasis Flutter yang langsung menampilkan dashboard tanpa memerlukan login atau autentikasi.

---

## ✨ FITUR UTAMA

### 📊 **Dashboard**
- 8 Menu Cards dengan navigasi
- User Info Card
- Navigation Drawer (13 menu items)
- AppBar dengan notifikasi
- Smooth animations

### 📚 **Fitur Lengkap**
1. ✅ **Attendance (Kehadiran)**
   - Today Attendance
   - Overall Attendance
   - Percentage display
   - Subject-wise breakdown

2. ✅ **Examination (Ujian)**
   - Subject list
   - Marks display
   - Grade calculation
   - Result summary

3. ✅ **Leave Apply (Pengajuan Izin)**
   - Leave type selection
   - Date range picker
   - Reason input
   - Form validation

4. ⚠️ **UI Only (Belum Full Implementation)**
   - Profile
   - TimeTable
   - Library
   - Track Bus
   - Activity
   - Fees
   - Downloads
   - Notification

---

## 🚀 CARA INSTALL & RUN

### Prerequisites
- Flutter SDK (3.0.0 atau lebih baru)
- Android Studio / VS Code
- Android SDK / iOS SDK
- Java 17 (untuk Android build)

### Langkah Install

```bash
# 1. Masuk ke folder project
cd tugas_akhir

# 2. Install dependencies
flutter pub get

# 3. Run aplikasi
flutter run

# Atau build APK
flutter build apk --release
```

---

## 📁 STRUKTUR PROJECT

```
tugas_akhir/
├── lib/
│   ├── main.dart                 # Entry point
│   ├── Screens/
│   │   ├── home.dart            # Dashboard
│   │   ├── Attendance/          # Kehadiran
│   │   ├── Exam/                # Ujian
│   │   └── Leave_Apply/         # Pengajuan izin
│   ├── Widgets/
│   │   ├── AppBar.dart
│   │   ├── DashboardCards.dart
│   │   ├── MainDrawer.dart
│   │   ├── UserDetailCard.dart
│   │   └── ... (widgets lainnya)
│   └── services/
│       └── UserModel.dart
├── assets/                       # Icons & images
└── android/                      # Android config
```

---

## 🎨 FITUR YANG DIHAPUS

### ❌ Tidak Ada Dalam Project Ini:
- Login Screen
- Signup/Register
- Forgot Password
- Firebase Authentication
- Google Sign-In
- Session Management
- Logout Feature
- SplashScreen (optional)

---

## 🛠️ TEKNOLOGI YANG DIGUNAKAN

- **Framework:** Flutter 3.x
- **Language:** Dart
- **UI Library:** Material Design
- **State Management:** StatefulWidget
- **Navigation:** Navigator 2.0
- **Forms:** Form & TextFormField
- **Animations:** AnimationController

---

## 📦 DEPENDENCIES

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  dropdown_search: ^6.0.1
  date_time_picker: ^2.1.0
  fzregex: ^2.0.0
  flrx_validator: ^0.6.0
  flutter_svg: ^2.0.16
  flutter_randomcolor: ^1.0.16
  randomizer_null_safe: ^0.1.5
```

---

## 🎯 CARA PENGGUNAAN

### 1. **Jalankan Aplikasi**
```bash
flutter run
```

### 2. **Navigasi**
- Aplikasi langsung buka **Dashboard**
- Tap card untuk navigasi ke fitur
- Tap icon menu untuk buka drawer
- Tap back button untuk kembali

### 3. **Customize User Data**
Edit file `lib/Widgets/UserDetailCard.dart`:
```dart
Text("YOUR_STUDENT_ID"),  // Student ID
Text("YOUR_NAME"),        // Student Name
Text("YOUR_CLASS"),       // Class
```

---

## 🔧 CUSTOMIZATION

### Tambah Menu Card Baru
Edit `lib/Screens/home.dart`:
```dart
Bouncing(
  onPress: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YourNewPage(),
      ),
    );
  },
  child: DashboardCard(
    name: "New Feature",
    imgpath: "icon.png",
  ),
),
```

### Tambah Drawer Menu
Edit `lib/Widgets/MainDrawer.dart`:
```dart
DrawerListTile(
  imgpath: "icon.png",
  name: "Menu Name",
  ontap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YourPage(),
      ),
    );
  },
),
```

---

## 📱 SCREENSHOTS

```
Dashboard:
┌────────────────────────┐
│  School Management     │
│  ═══════════════════   │
│  👤 BCM2005           │
│  John Doe | Class 10-A │
├────────────────────────┤
│ 📊          👤        │
│Attendance   Profile    │
│                        │
│ 📝          📅        │
│ Exam      TimeTable    │
│                        │
│ 📚          🚌        │
│Library     Track Bus   │
│                        │
│ 🎯          📄        │
│Activity      Leave     │
└────────────────────────┘
```

---

## ⚡ PERFORMANCE TIPS

1. **Optimize Images:** Compress assets ke ukuran kecil
2. **Lazy Loading:** Load data on demand
3. **Caching:** Cache user data locally
4. **Pagination:** Untuk list panjang
5. **Debouncing:** Untuk search/filter

---

## 🐛 TROUBLESHOOTING

### Error: Package not found
```bash
flutter clean
flutter pub get
```

### Error: Gradle build failed
```bash
cd android
./gradlew clean
cd ..
flutter run
```

### Error: Assets not loading
Check `pubspec.yaml` → pastikan assets listed dengan benar

---

## 📝 NEXT DEVELOPMENT

### Untuk Production:
1. **Backend Integration**
   - REST API
   - Database (MySQL/PostgreSQL)
   - Authentication (JWT/OAuth)

2. **State Management**
   - Provider / Riverpod
   - Bloc / Cubit
   - GetX

3. **Advanced Features**
   - Push Notifications
   - PDF Generation
   - Charts & Graphs
   - File Upload/Download
   - Real-time Updates

4. **Testing**
   - Unit Tests
   - Widget Tests
   - Integration Tests

---

## 👨‍💻 DEVELOPER

**Project:** Tugas Akhir - School Management System  
**Type:** Dashboard Only (No Auth)  
**Version:** 1.0.0  
**Date:** November 2025

---

## 📄 LICENSE

This project is for educational purposes.

---

## 🎉 READY TO USE!

Project ini **siap digunakan** tanpa perlu setup Firebase atau backend lainnya.

Cukup:
1. `flutter pub get`
2. `flutter run`
3. Enjoy! 🚀

**No Login Required - Langsung ke Dashboard!**

