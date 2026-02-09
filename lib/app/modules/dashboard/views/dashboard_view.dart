import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/views/home_view.dart';
import '../../pencarian/views/pencarian_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: const [
            HomeView(),
            PencarianView(),
          ],
        ),
      ),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.tabIndex.value,
          onTap: controller.changeTabIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            bottomNavigationBarItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: 'Home',
            ),
            bottomNavigationBarItem(
              icon: Icons.search_outlined,
              activeIcon: Icons.search,
              label: 'Pencarian',
            ),
          ],
        ),
      ),
    );
  }
}


BottomNavigationBarItem bottomNavigationBarItem({
  required IconData icon,
  required String label,
  required IconData activeIcon,
}) {
  return BottomNavigationBarItem(
    icon: Icon(icon, color: Colors.grey),
    label: label,
    activeIcon: Icon(activeIcon, color: Colors.blue),
  );
}
