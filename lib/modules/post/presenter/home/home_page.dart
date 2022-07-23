import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<int> currentPage = ValueNotifier(0);

  void onChangePage(index) {
    if (index == 0) {
      Modular.to.navigate('./posts');
    } else {
      Modular.to.navigate('./news');
    }
    currentPage.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [Expanded(child: RouterOutlet())],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: currentPage,
          builder: (context, value, _) {
            return BottomNavigationBar(
              selectedItemColor: primaryColor,
              currentIndex: value,
              onTap: onChangePage,
              items: const [
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.chat),
                  icon: Icon(Icons.chat_outlined),
                  label: 'Postagens',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.newspaper),
                  icon: Icon(Icons.newspaper_outlined),
                  label: 'Novidades',
                ),
              ],
            );
          }),
    );
  }
}
