import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sipao/services/firestore_service.dart';
import 'package:sipao/view/user/home/home_page.dart';
import 'package:sipao/view/user/profile/profile_page.dart';
import 'package:sipao/view/user/transaksi/detail_transaksi_page.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  String convertTimestampToFormattedDate(int timestamp) {
    // Membuat objek DateTime dari timestamp
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Mendapatkan nama bulan dalam bahasa Indonesia
    List<String> indonesianMonths = [
      "",
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember"
    ];

    // Mengonversi DateTime menjadi string dengan format yang diinginkan
    String formattedDate =
        "${dateTime.day} ${indonesianMonths[dateTime.month]} ${dateTime.year}";

    return formattedDate;
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

  IconData _getIconForStatus(String status) {
    switch (status) {
      case 'belumBayar':
        return EvaIcons.creditCardOutline;
      case 'lunas':
        return EvaIcons.navigationOutline;
      case 'batal':
        return EvaIcons.closeCircleOutline;
      case 'batal_kedaluarsa':
        return EvaIcons.closeCircleOutline;
      case 'batal_pemilik':
        return EvaIcons.closeCircleOutline;
      case 'selesai_norate':
        return EvaIcons.checkmarkCircle2Outline;
      case 'rated':
        return EvaIcons.starOutline;
      default:
        return EvaIcons.questionMarkCircleOutline;
    }
  }

  @override
  Widget build(BuildContext context) {
    String ket1 = "";
    String ket2 = "";
    String ket3 = "";
    String ket4 = "";
    int warna = 0;
    int warna2 = 0xFF6E6E6E;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
        return true;
      },
      child: Scaffold(
        //APPBAR
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Container(
            width: double.infinity,
            decoration: const ShapeDecoration(
              color: Color(0xFF141E46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //PROFIL
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 70,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Transaksi',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset(
                          "assets/images/sipao.png",
                          width: 32,
                        ),
                      ],
                    ),
                  ),
                  //CARI
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                              right: 10,
                            ),
                            child: Icon(
                              Icons.search,
                              size: 30,
                              color: Color(0xFF6E6E6E),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Cari riwayat transaksi..',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xFF6E6E6E),
                                fontSize: 16,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //FILTER
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Text(
                          "Semua",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        // color: Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Text(
                          "Proses",
                          style: TextStyle(
                            color: Color(0xFF6E6E6E),
                            fontSize: 14,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        // color: Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Text(
                          "Dibatalkan",
                          style: TextStyle(
                            color: Color(0xFF6E6E6E),
                            fontSize: 14,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        // color: Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Text(
                          "Selesai",
                          style: TextStyle(
                            color: Color(0xFF6E6E6E),
                            fontSize: 14,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //LIST
            StreamBuilder(
              stream: FirestoreService().getBookingsByUID(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    List<QueryDocumentSnapshot> transaksiList =
                        snapshot.data!.docs;
                    return Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          itemCount: transaksiList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            QueryDocumentSnapshot documentSnapshot =
                                transaksiList[index];

                            String id = documentSnapshot.id;

                            Map<String, dynamic> data =
                                documentSnapshot.data() as Map<String, dynamic>;

                            return FutureBuilder(
                              future: FirestoreService()
                                  .getArenaById(data['id_arena']),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else {
                                  if (snapshot.hasError) {
                                    return Text(snapshot.error.toString());
                                  } else {
                                    Map<String, dynamic> dataArena =
                                        snapshot.data!.data()
                                            as Map<String, dynamic>;
                                    if (data['status'] == 'belumBayar') {
                                      ket1 = "Belum Dibayar";
                                      ket2 = "Bayar sebelum pukul 23.59 WIB";
                                      ket3 = "Bayar sebelum";
                                      ket4 = "23.59 WIB";
                                      warna = 0xFFFF6969;
                                      warna2 = 0xFF6E6E6E;
                                    } else if (data['status'] == 'lunas') {
                                      ket1 = "Sudah Dibayar";
                                      ket2 =
                                          "Lunas pada pukul ${data['jam_bayar']}";
                                      warna = 0xFF141E46;
                                      warna2 = 0xFF6E6E6E;
                                    } else if (data['status'] == 'batal') {
                                      ket1 = "Dibatalkan";
                                      warna = 0xFFC70039;
                                      warna2 = 0xFF6E6E6E;
                                    } else if (data['status'] ==
                                        'batal_kedaluarsa') {
                                      ket1 = "Dibatalkan";
                                      ket2 = "Pembayaran kedaluarsa";
                                      warna = 0xFFC70039;
                                      warna2 = 0xFF6E6E6E;
                                    } else if (data['status'] ==
                                        'batal_pemilik') {
                                      ket1 = "Dibatalkan";
                                      ket2 = "Oleh Pemilik";
                                      warna = 0xFFC70039;
                                      warna2 = 0xFF6E6E6E;
                                    } else if (data['status'] ==
                                        'selesai_norate') {
                                      ket1 = "Selesai";
                                      ket2 = "Beri Rating";
                                      warna = 0xFF0B8B00;
                                      warna2 = 0xFF9E9800;
                                    } else if (data['status'] == 'rated') {
                                      ket1 = "Selesai";
                                      ket2 = data['rate'] + " Sangat Puas";
                                      warna = 0xFF9E9800;
                                      warna2 = 0xFF9E9800;
                                    }
                                    return InkWell(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailTransaksiPage(id: id),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 15,
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          height: 210,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFFDFD),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: const Color(0xFFD9D9D9),
                                              width: 2,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              children: [
                                                //SEC 1
                                                Expanded(
                                                  flex: 6,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      //ID
                                                      Text(
                                                        data['id_booking'],
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF6E6E6E),
                                                          fontSize: 14,
                                                          fontFamily: 'Sora',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      //ICON NAMAARENA KET
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            _getIconForStatus(
                                                                data['status']),
                                                            color: Color(warna),
                                                            size: 36,
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: 15,
                                                                left: 15,
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    dataArena[
                                                                        'nama'],
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          'Sora',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      top: 10,
                                                                    ),
                                                                    child: Text(
                                                                      'Booking untuk\n${data['tanggal']}\n${data['waktu']} WIB',
                                                                      style:
                                                                          const TextStyle(
                                                                        height:
                                                                            1.5,
                                                                        color: Color(
                                                                            0xFF6E6E6E),
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'Sora',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                //SEC 2
                                                Expanded(
                                                  flex: 4,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      //TANGGAL
                                                      Text(
                                                        convertTimestampToFormattedDate(
                                                            int.parse(data[
                                                                'waktu_booking'])),
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF6E6E6E),
                                                          fontSize: 14,
                                                          fontFamily: 'Sora',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      //KET
                                                      Text(
                                                        ket1,
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                          color: Color(warna),
                                                          fontSize: 14,
                                                          fontFamily: 'Sora',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      //KET2
                                                      Text(
                                                        ket2,
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                          color: Color(warna2),
                                                          fontSize: 14,
                                                          fontFamily: 'Sora',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                            );
                          },
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
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
      ),
    );
  }
}
