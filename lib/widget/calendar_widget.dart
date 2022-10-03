import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pl-PL', null);

    return Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      child: TableCalendar(
        focusedDay: _focusedDay,
        firstDay: DateTime.utc(1970, 01, 01),
        lastDay: DateTime.utc(2040, 12, 31),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        rangeSelectionMode: RangeSelectionMode.disabled,
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          } else {
            showDatePicker(
                    context: context,
                    initialDate: _selectedDay!,
                    firstDate: DateTime.utc(2020, 01, 01),
                    lastDate: DateTime(DateTime.now().year + 10),
                    locale: Locale('pl', ''))
                .then(
              (date) => setState(
                () {
                  if (date == null) {
                    return;
                  }
                  _selectedDay = date;
                  _focusedDay = _selectedDay!;
                },
              ),
            );
          }
        },
        headerVisible: true,
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        daysOfWeekHeight: 15,
        rowHeight: 50,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          cellAlignment: Alignment.center,
          cellMargin: EdgeInsets.all(5),
          rowDecoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
          ),
          outsideTextStyle: TextStyle(color: Colors.white),
          defaultTextStyle: TextStyle(color: Colors.white),
          weekendTextStyle: TextStyle(color: Colors.red),
          todayDecoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.circle),
          selectedTextStyle:
              TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          selectedDecoration: BoxDecoration(
            color: Colors.lightBlue[100],
            shape: BoxShape.circle,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          decoration: BoxDecoration(color: Colors.transparent),
          weekdayStyle: TextStyle(color: Colors.white),
          weekendStyle: TextStyle(color: Colors.red),
          dowTextFormatter: (date, locale) =>
              DateFormat.E('pl-PL').format(date)[0].toUpperCase(),
        ),
      ),
    );
  }
}