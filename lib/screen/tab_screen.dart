// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:myproject/screen/blogs_screen.dart';
import 'package:myproject/screen/calculate_calories.dart';
import 'package:myproject/screen/doctor_recomendation.dart';
import 'package:myproject/screen/home_screen.dart';
import 'package:myproject/viewmodel/tab_viewmodel.dart';
import 'package:provider/provider.dart';

import 'notification_screen.dart';

class TabScreen extends StatelessWidget {
  String role;

  TabScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Consumer<TabScreenViewModel>(
      builder: (context, viewModel, _) {
        return Scaffold(
          body: IndexedStack(
            index: viewModel.selectedTabIndex,
            children: [
              HomeScreen(role: role),
              const BlogsScreen(),
              DoctorRecommendation(role: role),
              CaloriesCalculator(),
              NotificationScreen(
                id: '',
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: viewModel.selectedTabIndex,
            onTap: (index) => viewModel.setTabIndex(index),
            type: BottomNavigationBarType.fixed,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label: 'Blogs',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Appointment',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/calories.png",
                  width: 30,
                ),
                label: 'Calories',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.notifications_sharp),
                label: 'Notification',
              ),
              // const BottomNavigationBarItem(
              //   icon: Icon(Icons.person),
              //   label: 'Profile',
              // ),
            ],
          ),
        );
      },
    );
  }
}
