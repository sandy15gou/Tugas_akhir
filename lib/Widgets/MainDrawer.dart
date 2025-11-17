import 'package:flutter/material.dart';
import 'package:tugas_akhir/Screens/Attendance/Attendance.dart';
import 'package:tugas_akhir/Screens/DatabaseViewer.dart';
import 'package:tugas_akhir/Screens/Exam/Exam_Rseult.dart';
import 'package:tugas_akhir/Screens/Leave_Apply/LeaveApplySimple.dart';
import 'package:tugas_akhir/Screens/TimeTable/TimeTable.dart';
import 'package:tugas_akhir/Screens/home.dart';
import 'package:tugas_akhir/Screens/Profile/ProfilePage.dart';
import 'package:tugas_akhir/Screens/About/AboutPage.dart';
import 'package:tugas_akhir/Screens/Prestasi/PrestasiPage.dart';
import 'package:tugas_akhir/Screens/Library/PerpustakaanPage.dart';
import 'package:tugas_akhir/Screens/Auth/LoginPage.dart';
import 'package:tugas_akhir/Widgets/DrawerListTile.dart';
import 'package:tugas_akhir/services/AuthManager.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final authManager = AuthManager.instance;

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Logout'),
        content: Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await authManager.logout();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = authManager.currentUser;

    return ListView(
      children: [
        // User Info Header
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF134B70), Color(0xFF508C9B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 35,
                  color: Color(0xFF134B70),
                ),
              ),
              SizedBox(height: 12),
              Text(
                user?.nama ?? 'User',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  user?.role.toUpperCase() ?? 'GUEST',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              if (user?.nis != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    'NIS: ${user!.nis}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ),
              if (user?.nip != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    'NIP: ${user!.nip}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ),
            ],
          ),
        ),

        DrawerListTile(
            imgpath: "home.png",
            name: "Beranda",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Home(),
                ),
              );
            }),
        DrawerListTile(
          imgpath: "attendance.png",
          name: "Kehadiran",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Attendance(),
              ),
            );
          },
        ),
        DrawerListTile(
          imgpath: "profile.png",
          name: "Profil",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProfilePage(),
              ),
            );
          },
        ),
        DrawerListTile(
          imgpath: "exam.png",
          name: "Ujian",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ExamResult(),
              ),
            );
          },
        ),
        DrawerListTile(
            imgpath: "calendar.png",
            name: "Jadwal Pelajaran",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => TimeTable(),
                ),
              );
            }),
        DrawerListTile(
          imgpath: "library.png",
          name: "Perpustakaan",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => PerpustakaanPage(),
              ),
            );
          },
        ),
        DrawerListTile(
          imgpath: "school_building.png",
          name: "Profil Sekolah",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AboutPage(),
              ),
            );
          },
        ),
        DrawerListTile(
          imgpath: "leave_apply.png",
          name: "Ajukan Izin",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LeaveApplySimple(),
              ),
            );
          },
        ),
        DrawerListTile(
          imgpath: "exam.png",
          name: "Prestasi",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => PrestasiPage(),
              ),
            );
          },
        ),
        DrawerListTile(imgpath: "notification.png", name: "Notifikasi", ontap: () {}),
        Divider(),

        // Menu Database Viewer - Hanya untuk Admin
        if (authManager.canViewDatabase())
          DrawerListTile(
            imgpath: "setting.gif",
            name: "🔍 Lihat Database",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => DatabaseViewer(),
                ),
              );
            },
          ),

        // Tombol Logout
        DrawerListTile(
          imgpath: "exit.png",
          name: "Logout",
          ontap: _logout,
        ),
      ],
    );
  }
}
