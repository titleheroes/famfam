// ignore_for_file: prefer_const_constructors, file_names

import 'package:famfam/Calendar/event.dart';
import 'package:famfam/Calendar/AddEvens.dart';

// ignore: unused_import
import 'package:famfam/Calendar/calendar.dart';
// import 'package:famfam/circleScreen/createCricle/body.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  final TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: size.height * 0.12,
                width: size.width * 1,
                // ignore: use_full_hex_values_for_flutter_colors
                decoration: BoxDecoration(
                  color: Color(0xffff6e5c7),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                  ),
                ),

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 390, top: 0),
                      child: IconButton(
                        icon: Icon(
                          IconData(0xf8f4,
                              fontFamily: 'MaterialIcons',
                              matchTextDirection: true),
                          color: Colors.black,
                          size: 45,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 215,
                        right: 0,
                      ),
                      child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.0596,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80),
                              topRight: Radius.circular(0),
                            ),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 14, left: 60),
                          child: Text(
                            "Calendar",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                                color: Colors.black87),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TableCalendar(
                focusedDay: selectedDay,
                firstDay: DateTime(1990),
                lastDay: DateTime(2050),
                calendarFormat: format,
                onFormatChanged: (CalendarFormat _format) {
                  setState(() {
                    format = _format;
                  });
                },
                startingDayOfWeek: StartingDayOfWeek.sunday,
                daysOfWeekVisible: true,

                //Day Changed
                onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  setState(() {
                    selectedDay = selectDay;
                    focusedDay = focusDay;
                  });
                  // ignore: avoid_print
                  print(focusedDay);
                },
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(selectedDay, date);
                },

                eventLoader: _getEventsfromDay,

                //To style the Calendar
                calendarStyle: CalendarStyle(
                  // isTodayHighlighted: true,
                  defaultTextStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  rowDecoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xfffEBE9E9)))),
                  disabledTextStyle: TextStyle(fontSize: 16),
                  // outsideTextStyle: TextStyle(fontSize: 15, color: Colors.grey),
                  weekendTextStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  cellPadding: EdgeInsets.all(12),
                  outsideDaysVisible: false,

                  selectedDecoration: BoxDecoration(
                    color: Color(0xfffFFC34A),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  todayTextStyle: TextStyle(color: Colors.red),
                  selectedTextStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                  todayDecoration: BoxDecoration(
                    color: Colors.white10,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  weekendDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Colors.brown[800]),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            // topLeft: Radius.circular(40),
                            bottomRight: Radius.circular(0))),
                    formatButtonShowsNext: false,
                    // formatButtonTextStyle: const TextStyle(
                    //   color: Colors.white,
                    // ),
                    headerMargin: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                      color: Colors.white),
                  decoration: BoxDecoration(
                    color: Color(0xfffFFC34A),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
                  weekendStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
                daysOfWeekHeight: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60)),
                    color: Color(0xffff6e5c7)),
                height: size.height * 0.43,
                child: DefaultTabController(
                  length: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 70,
                              child: TabBar(
                                labelColor: Colors.black,
                                unselectedLabelColor: Color(0xfffB5B0A2),
                                labelStyle: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w800),
                                unselectedLabelStyle:
                                    TextStyle(fontWeight: FontWeight.normal),
                                indicator: BoxDecoration(),
                                tabs: [
                                  Tab(
                                    text: "Activities",
                                  ),
                                  Tab(
                                    text: "Repeat",
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: TabBarView(
                                children: [
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        ..._getEventsfromDay(selectedDay).map(
                                          (Event event) => ListTile(
                                            title: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 5, 20, 5),
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 50, top: 10),
                                                  child: Text(
                                                    event.title,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Text("2"),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                // child: Padding(
                //     padding: EdgeInsets.zero,
                // child: Column(
                //   children: [
                //     Container(
                //       height: 30,
                //     ),

                //     Text(
                //       "Activities",
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 30,
                //       ),
                //     ),
                //     Container(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: [
                //           SizedBox(
                //             height: 15,
                //           ),
                //           ..._getEventsfromDay(selectedDay).map(
                //             (Event event) => ListTile(
                //               title: Padding(
                //                 padding:
                //                     const EdgeInsets.fromLTRB(20, 5, 20, 5),
                //                 child: Container(
                //                   height: 50,
                //                   decoration: BoxDecoration(
                //                       color: Colors.white,
                //                       borderRadius:
                //                           BorderRadius.circular(10)),
                //                   child: Padding(
                //                     padding: const EdgeInsets.only(
                //                         left: 50, top: 10),
                //                     child: Text(
                //                       event.title,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     )
                //   ],
                // )),

                //   Column(
                //   children: [
                //     Container(),
                //     ..._getEventsfromDay(selectedDay).map(
                //       (Event event) => ListTile(
                //         title: Text(
                //           event.title,
                //         ),
                //       ),
                //     ),
                //   ],
                // )
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xfffA2A2A2),
        // onPressed: () => showDialog(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     backgroundColor: Colors.white,
        //     title: const Text(
        //       "Add Note",
        //       textAlign: TextAlign.right,
        //     ),
        //     content: TextFormField(
        //       controller: _eventController,
        //     ),
        //     actions: [
        //       TextButton(
        //         child: const Text("Cancel"),
        //         onPressed: () => Navigator.pop(context),
        //       ),
        //       TextButton(
        //         child: const Text("Ok"),
        //         onPressed: () {
        //           if (_eventController.text.isEmpty) {
        //           } else {
        //             if (selectedEvents[selectedDay] != null) {
        //               selectedEvents[selectedDay]?.add(
        //                 Event(
        //                     title: _eventController.text,
        //                     locations: _eventController.text),
        //               );
        //             } else {
        //               selectedEvents[selectedDay] = [
        //                 Event(
        //                     title: _eventController.text,
        //                     locations: _eventController.text)
        //               ];
        //             }
        //           }
        //           Navigator.pop(context);
        //           _eventController.clear();
        //           setState(() {});
        //           return;
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddEvens()));
        },
        label: const Text(
          "Add",
        ),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
