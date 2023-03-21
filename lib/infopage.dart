// import"package:flutter/material.dart";
// class infopage extends StatefulWidget {
//   const infopage({Key? key}) : super(key: key);
//
//   @override
//   State<infopage> createState() => _infopageState();
// }
//
// class _infopageState extends State<infopage> {
//
//   @override
//   Widget build(BuildContext context) {
//     double width=MediaQuery.of(context).size.width;
//     double height=MediaQuery.of(context).size.height;
//     return  Container(
//         padding:EdgeInsets.all(20),
//     decoration :BoxDecoration(
//     gradient: LinearGradient(
//     // Where the linear gradient begins and ends
//     begin: Alignment.topRight,
//     //end: Alignment(0.3, 0),
//     end:Alignment.bottomLeft,
//     tileMode: TileMode.repeated, // repeats the gradient over page
//     colors: [
//     // Colors are easy thanks to Flutter's Colors class
//     Color(0xFF8EC5FC),
//     Color(0xFFE0C3FC),
//     //Colors.red,
//     //Colors.orange,
//     ],
//     ),
//     ),
//     child:Scaffold(
//     backgroundColor: Colors.transparent,
//     body:
//     Center(
//     child:SingleChildScrollView(
//     child:Column(
//       children:[
//     Container(
//     margin: const EdgeInsets.all(6.5),
//         //height:40,
//         padding:EdgeInsets.all(15),
//         width: width,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(
//             Radius.circular(10),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xffDDDDDD),
//               blurRadius: 6.0,
//               spreadRadius: 2.0,
//               offset: Offset(0.0, 0.0),
//             )
//           ],
//         ),
//     ),
//         SizedBox(
//           height:10,
//         )
//       ]
//     )
//     ),
//     )
//     )
//     );
//
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:medicare/styles/colors.dart';
// import 'package:medicare/styles/styles.dart';
//
// class ScheduleTab extends StatefulWidget {
//   const ScheduleTab({Key? key}) : super(key: key);
//
//   @override
//   State<ScheduleTab> createState() => _ScheduleTabState();
// }

import 'package:detect_blindness/styles/colors.dart';
import 'package:detect_blindness/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ScheduleTab extends StatefulWidget {
  const ScheduleTab({Key? key}) : super(key: key);

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}
enum FilterStatus { Online, Offline , Cancel }

List<Map> schedules = [
  {
    'img': 'assets/images/profile1.jpg',
    'doctorName': 'Dr. Ramesh Sharma',
    'doctorTitle': 'Eye Specialist',
    'reservedDate': 'Monday, Aug 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Online
  },
  {
    'img': 'assets/images/profile2.jpg',
    'doctorName': 'Dr. Sunita Verma',
    'doctorTitle': 'Eye Specialist',
    'reservedDate': 'Monday, Sep 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Online
  },
  {
    'img': 'assets/images/profile3.jpg',
    'doctorName': 'Dr. Akhilesh Sharma',
    'doctorTitle': 'Eye Specialist',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Online
  },
  {
    'img': 'assets/images/profile1',
    'doctorName': 'Dr. Ramesh Sharma',
    'doctorTitle': 'Eye Specialist',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Online
  },
  {
    'img': 'assets/images/profile3',
    'doctorName': 'Dr. Akhilesh Sharma',
    'doctorTitle': 'Eye Specialist',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Cancel
  },
  {
    'img': 'assets/images/profile4',
    'doctorName': 'Dr. Sam Smithh',
    'doctorTitle': 'Eye Specialist',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Cancel
  },
];

class _ScheduleTabState extends State<ScheduleTab>{
  FilterStatus status = FilterStatus.Online;
  Alignment _alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    List<Map> filteredSchedules = schedules.where((var schedule) {
      return schedule['status'] == status;
    }).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(MyColors.bg),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   if (filterStatus == FilterStatus.Upcoming) {
                              //     status = FilterStatus.Upcoming;
                              //     _alignment = Alignment.centerLeft;
                              //   } else if (filterStatus ==
                              //       FilterStatus.Complete) {
                              //     status = FilterStatus.Complete;
                              //     _alignment = Alignment.center;
                              //   } else if (filterStatus ==
                              //       FilterStatus.Cancel) {
                              //     status = FilterStatus.Cancel;
                              //     _alignment = Alignment.centerRight;
                              //   }
                              // });
                            },
                            child: Center(
                              child: Text(
                                filterStatus.name,
                                style: kFilterStyle,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  duration: Duration(milliseconds: 200),
                  alignment: _alignment,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(MyColors.primary),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules.length,
                itemBuilder: (context, index) {
                  var _schedule = filteredSchedules[index];
                  bool isLastElement = filteredSchedules.length + 1 == index;
                  return Card(
                    margin: !isLastElement
                        ? EdgeInsets.only(bottom: 20)
                        : EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(_schedule['img'])),

                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _schedule['doctorName'],
                                    style: TextStyle(
                                      color: Color(MyColors.header01),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _schedule['doctorTitle'],
                                    style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DateTimeCard(),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  child: Text('Cancel'),
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  child: Text('Message'),
                                  onPressed: () => {},
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class DateTimeCard extends StatelessWidget {
  const DateTimeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Color(MyColors.primary),
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Mon, July 29',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_alarm,
                color: Color(MyColors.primary),
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '11:00 ~ 12:10',
                style: TextStyle(
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}