import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sipao/view/admin/home/admin_home_page.dart';
import 'package:sipao/view/admin/profile/admin_profile_page.dart';

class AdminTransaksiPage extends StatefulWidget {
  const AdminTransaksiPage({super.key});

  @override
  State<AdminTransaksiPage> createState() => _AdminTransaksiPageState();
}

class _AdminTransaksiPageState extends State<AdminTransaksiPage> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdminHomePage()),
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdminProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.homeOutline,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.calendarOutline,
              size: 30,
            ),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
              size: 30,
            ),
            label: 'Profil',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: const Color(0xFF141E46),
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontFamily: 'Sora',
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontFamily: 'Sora',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
