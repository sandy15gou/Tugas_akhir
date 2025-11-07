import 'package:flutter/material.dart';

class OverallAttendanceCard extends StatefulWidget {
  final String date;
  final String day;
  final bool firsthalf;
  final bool secondhalf;

  const OverallAttendanceCard(
      {Key? key, required this.date, required this.day, required this.firsthalf, required this.secondhalf})
      : super(key: key);

  @override
  _OverallAttendanceCardState createState() => _OverallAttendanceCardState();
}

class _OverallAttendanceCardState extends State<OverallAttendanceCard>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation;
  late AnimationController animationController;

  // Format tanggal dari YYYY-MM-DD ke DD.MM.YYYY
  String formatDate(String date) {
    try {
      // Jika sudah dalam format DD.MM.YYYY
      if (date.contains('.')) {
        return date;
      }
      // Jika dalam format YYYY-MM-DD
      if (date.contains('-')) {
        final parts = date.split('-');
        if (parts.length == 3) {
          return '${parts[2]}.${parts[1]}.${parts[0]}';
        }
      }
      return date;
    } catch (e) {
      return date;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.2, 0.6, curve: Curves.fastOutSlowIn)));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Transform(
            transform:
                Matrix4.translationValues(delayedAnimation.value * width, 0, 0),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white70,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 3),
                    //blurRadius: 3,
                    //spreadRadius: 1,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatDate(widget.date),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${widget.day}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pagi",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Siang",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          widget.firsthalf == true ? Colors.green : Colors.red,
                    ),
                    child: Center(
                      child: widget.firsthalf == true
                          ? Text(
                              "P",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            )
                          : Text(
                              "A",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          widget.secondhalf == true ? Colors.green : Colors.red,
                    ),
                    child: Center(
                      child: widget.secondhalf == true
                          ? Text(
                              "P",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            )
                          : Text(
                              "A",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
