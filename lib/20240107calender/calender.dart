import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderTest extends StatelessWidget {
  const CalenderTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green[100],
        body: TableCalendar(
          rowHeight: 80.0,
          firstDay: DateTime.utc(2023, 1, 1),
          lastDay: DateTime.utc(2024, 12, 31),
          focusedDay: DateTime.now(),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.green),
            weekendStyle: TextStyle(color: Colors.blue),
          ),
          calendarBuilders: CalendarBuilders(
            // todayBuilder: (context, date, event) {
            //   return Container(
            //     margin: const EdgeInsets.all(8.0),
            //     padding: const EdgeInsets.all(8.0),
            //     decoration: BoxDecoration(
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.white.withOpacity(0.8),
            //           spreadRadius: 2,
            //           blurRadius: 2,
            //           offset: const Offset(-2, -2),
            //         ),
            //         BoxShadow(
            //           color: Colors.black.withOpacity(0.2),
            //           spreadRadius: 2,
            //           blurRadius: 2,
            //           offset: const Offset(2, 2),
            //         ),
            //       ],
            //       borderRadius: BorderRadius.circular(10.0),
            //       color: Colors.red,
            //     ),
            //     child: Stack(
            //       children: [
            //         Row(
            //           children: [
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   date.day.toString(),
            //                   style: TextStyle(color: Colors.white),
            //                 ),
            //                 Text(
            //                   '予定があります',
            //                   style: TextStyle(color: Colors.white, fontSize: 8.0),
            //                 ),
            //                 Text(
            //                   '予定があります',
            //                   style: TextStyle(color: Colors.white, fontSize: 8.0),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   );
            // },
            prioritizedBuilder: (context, date, event) {
              final bool isToday = date == DateTime.now();
              return Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(-2, -2),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                  color: isToday ? Colors.red : Colors.blue,
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              date.day.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '予定があります',
                              style: TextStyle(color: Colors.white, fontSize: 8.0),
                            ),
                            Text(
                              '予定があります',
                              style: TextStyle(color: Colors.white, fontSize: 8.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
