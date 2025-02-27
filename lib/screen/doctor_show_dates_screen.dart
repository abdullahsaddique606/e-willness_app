import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class DoctorShowAppointmentsScreen extends StatefulWidget {
  @override
  _DoctorShowAppointmentsScreenState createState() => _DoctorShowAppointmentsScreenState();
}

class _DoctorShowAppointmentsScreenState extends State<DoctorShowAppointmentsScreen> {
  List<DateTime> _appointmentDates = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<List<DateTime>> _fetchDoctorAppointments() async {
    List<DateTime> appointmentDates = [];
    var doctorId = FirebaseAuth.instance.currentUser?.uid ?? '';

    var snapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('doctorId', isEqualTo: doctorId)
        .get();

    for (var doc in snapshot.docs) {
      var data = doc.data();
      var appointmentDate = (data['appointmentDate'] as Timestamp).toDate();
      debugPrint("-------appoi-------${appointmentDate}");
      appointmentDates.add(appointmentDate);
    }

    return appointmentDates;
  }

  Future<void> _loadAppointments() async {
    var dates = await _fetchDoctorAppointments();
    setState(() {
      _appointmentDates = dates;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
      ),
      body: _appointmentDates.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : TableCalendar(
        firstDay: DateTime.utc(2020, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        calendarFormat: CalendarFormat.month,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, date, _) {
            bool hasAppointment = _appointmentDates.any((appointmentDate) =>
            isSameDay(appointmentDate, date) && !isPastDate(date));
            return Container(
              margin: const EdgeInsets.all(6.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: hasAppointment ? Colors.red : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Text(
                date.day.toString(),
                style: TextStyle(color: hasAppointment ? Colors.white : Colors.black),
              ),
            );
          },
        ),
      ),
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  bool isPastDate(DateTime date) {
    DateTime now = DateTime.now();
    return date.isBefore(DateTime(now.year, now.month, now.day));
  }
}
