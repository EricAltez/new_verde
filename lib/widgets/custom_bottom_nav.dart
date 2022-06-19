import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:new_verde/services/tab_navigation_handler.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabNavigatorHandler = Provider.of<TabNavigatorHandler>(context);

    return BottomNavigationBar(
      onTap: (int idx) => tabNavigatorHandler.selectedTab = idx,
      currentIndex: tabNavigatorHandler.selectedTab,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Direcciones',
        ),
      ],
    );
  }
}