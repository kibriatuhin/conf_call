import 'package:conf_call/screens/history_meeting_screen.dart';
import 'package:conf_call/screens/meeting_screens.dart';
import 'package:conf_call/utils/colors.dart';
import 'package:conf_call/widgets/home_meeting_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/login";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  _onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
     MeetingScreens(),
    const HistoryMeetingScreen(),
    const Text("contact"),
    const Text("setting")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text("Meet & Chat"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onPageChange,
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.comment_bank),
            label: "Meet & chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_clock),
            label: "Meetings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "contact",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
          ),
        ],
      ),
      body: pages[_page],
    );
  }
}
