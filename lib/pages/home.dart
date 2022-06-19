import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:new_verde/services/tab_navigation_handler.dart';
import 'package:new_verde/pages/index.dart';
import 'package:new_verde/widgets/index.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.white,
            ),
          )
        ],
        title: const Text('Historial'),
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex = Provider.of<TabNavigatorHandler>(context).selectedTab;

    switch (currentIndex) {
      case 1:
        return const MapHistoryPage();
      default:
        return const AddressPage();
    }
  }
}