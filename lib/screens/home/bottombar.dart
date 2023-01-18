import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'package:pay_manager/screens/home/home_pg.dart';

// ignore: camel_case_types
class bottomnavMM extends StatelessWidget {
  const bottomnavMM({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: screenhome.selectedindexNotifier,
      builder: (BuildContext ctx, int updatedindex, Widget? _) {
        return BottomNavigationBar(
          unselectedItemColor: Color.fromARGB(255, 116, 87, 0),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          currentIndex: updatedindex,
          onTap: (newIndex) {
            screenhome.selectedindexNotifier.value = newIndex;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(IconlyBroken.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(IconlyBroken.category), label: 'Catogory ')
          ],
        );
      },
    );
  }
}
