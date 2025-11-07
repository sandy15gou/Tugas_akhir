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
import 'package:tugas_akhir/Widgets/DrawerListTile.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
          imgpath: "setting.gif",
          name: "Tentang Kami",
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
      ],
    );
  }
}
