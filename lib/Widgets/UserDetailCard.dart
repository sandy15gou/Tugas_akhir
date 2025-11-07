import 'package:flutter/material.dart';
import 'package:tugas_akhir/services/AuthManager.dart';

class UserDetailCard extends StatefulWidget {
  @override
  _UserDetailCardState createState() => _UserDetailCardState();
}

class _UserDetailCardState extends State<UserDetailCard>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.2, 0.5, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3, 0.5, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    final double width = MediaQuery.of(context).size.width;
    final user = AuthManager.instance.currentUser;

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 3),
          child: Container(
            alignment: Alignment(0, 0),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 0.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF134B70), Color(0xFF508C9B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value * width, 0, 0),
                          child: Center(
                            child: CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: Color(0xFF134B70),
                              ),
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              delayedAnimation.value * width, 0, 0),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Role Badge
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(51),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    user?.role.toUpperCase() ?? 'USER',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                // Nama
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    user?.nama ?? 'User',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                // NIS atau NIP
                                if (user?.nis != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.orange[50],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        user!.nis!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (user?.nip != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.green[50],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'NIP: ${user!.nip}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11,
                                          color: Colors.green[800],
                                        ),
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        user?.role == 'siswa'
                                            ? "Kelas: 8A"
                                            : user?.role == 'guru'
                                                ? "Guru Mata Pelajaran"
                                                : "Administrator",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      SizedBox(width: 50),
                                      Text(
                                        "SMPN 1 Jambi",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
