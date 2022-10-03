import 'package:flutter/material.dart';
import 'package:podliczajka/widget/calendar_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CalendarWidget(),
          Container(),
        ],
      ),
    );
  }
}
