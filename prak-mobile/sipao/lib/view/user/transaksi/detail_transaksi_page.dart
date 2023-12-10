import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sipao/services/firestore_service.dart';
import 'package:sipao/view/user/transaksi/transaksi_page.dart';

class DetailTransaksiPage extends StatefulWidget {
  const DetailTransaksiPage({super.key, required this.id});

  final String id;

  @override
  State<DetailTransaksiPage> createState() => _DetailTransaksiPageState();
}

class _DetailTransaksiPageState extends State<DetailTransaksiPage> {
  void _showConfirm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pastikan kamu sudah membayar!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Image.asset(
                  "assets/images/1.png",
                  width: 128,
                  height: 128,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 110,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC70039),
                          elevation: 4,
                          shadowColor: const Color(0xFFCAD6FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Batal",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          FirestoreService()
                              .updateBookingStatus(widget.id, "lunas");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TransaksiPage(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF141E46),
                          elevation: 4,
                          shadowColor: const Color(0xFFCAD6FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Ya",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String convertTimestampToFormattedDateTime(int timestamp) {
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
    String formattedDateTime =
        "${dateTime.day} ${indonesianMonths[dateTime.month]} ${dateTime.year} ${_addZeroPrefix(dateTime.hour)}:${_addZeroPrefix(dateTime.minute)} WIB";

    return formattedDateTime;
  }

  String _addZeroPrefix(int value) {
    // Tambahkan awalan "0" pada nilai kurang dari 10
    return value < 10 ? "0$value" : "$value";
  }

  @override
  Widget build(BuildContext context) {
    String ket1 = "";
    String ket2 = "";
    String ket3 = "";
    String ket4 = "";
    int warna = 0;
    int warna2 = 0xFF6E6E6E;
    String btn1 = "";
    String btn2 = "";

    return Scaffold(
      //APPBAR
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF141E46),
            borderRadius: BorderRadius.circular(15),
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
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          EvaIcons.arrowBackOutline,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            'Detail Transaksi',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                        "assets/images/sipao.png",
                        width: 32,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      //BODY
      body: FutureBuilder(
          future: FirestoreService().getBookingById(widget.id),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                // Data ditemukan, akses menggunakan snapshot.data!.data()
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                if (data['status'] == 'belumBayar') {
                  ket1 = "Belum Dibayar";
                  ket2 = "Bayar sebelum pukul 23.59 WIB";
                  ket3 = "Bayar sebelum";
                  ket4 = "23.59 WIB";
                  warna = 0xFFFF6969;
                  warna2 = 0xFF6E6E6E;
                  btn1 = "Sudah Bayar";
                  btn2 = "Batalkan";
                } else if (data['status'] == 'lunas') {
                  ket1 = "Sudah Dibayar";
                  ket2 = "Lunas pada pukul ${data['jam_bayar']}";
                  warna = 0xFF141E46;
                  warna2 = 0xFF6E6E6E;
                  btn1 = "Selesai";
                } else if (data['status'] == 'batal') {
                  ket1 = "Dibatalkan";
                  warna = 0xFFC70039;
                  warna2 = 0xFF6E6E6E;
                  btn2 = "Booking Lagi";
                } else if (data['status'] == 'batal_kedaluarsa') {
                  ket1 = "Dibatalkan";
                  ket2 = "Pembayaran kedaluarsa";
                  warna = 0xFFC70039;
                  warna2 = 0xFF6E6E6E;
                  btn2 = "Booking Lagi";
                } else if (data['status'] == 'batal_pemilik') {
                  ket1 = "Dibatalkan";
                  ket2 = "Oleh Pemilik";
                  warna = 0xFFC70039;
                  warna2 = 0xFF6E6E6E;
                  btn2 = "Booking Lagi";
                } else if (data['status'] == 'selesai_norate') {
                  ket1 = "Selesai";
                  ket2 = "Beri Rating";
                  warna = 0xFF0B8B00;
                  warna2 = 0xFF9E9800;
                  btn1 = "Beri Ulasan";
                  btn2 = "Booking Lagi";
                } else if (data['status'] == 'rated') {
                  ket1 = "Selesai";
                  ket2 = data['rate'] + " Sangat Puas";
                  warna = 0xFF0B8B00;
                  warna2 = 0xFF9E9800;
                  btn1 = data['rate'] + " Sangat Puas";
                  btn2 = "Booking Lagi";
                }
                return FutureBuilder(
                  future: FirestoreService().getArenaById(data['id_arena']),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                        Map<String, dynamic> dataArena =
                            snapshot.data!.data() as Map<String, dynamic>;
                        dataArena['harga'] =
                            int.tryParse(dataArena['harga']) ?? 0;
                        NumberFormat formatter = NumberFormat('#,###', 'id_ID');
                        dataArena['harga'] =
                            formatter.format(dataArena['harga']);
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //KET
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                ),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Text(
                                        ket1,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Sora',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 7,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Color(warna),
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Divider(),
                              ),
                              //INVOICE
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Text(
                                            data['id_booking'],
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Color(0xFF6E6E6E),
                                              fontSize: 14,
                                              fontFamily: 'Sora',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const Icon(
                                                EvaIcons.copyOutline,
                                                size: 20,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5,
                                                ),
                                                child: Text(
                                                  'Lihat Invoice',
                                                  style: TextStyle(
                                                    color: Color(warna),
                                                    fontSize: 14,
                                                    fontFamily: 'Sora',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Expanded(
                                            flex: 6,
                                            child: Text(
                                              'Tanggal Transaksi',
                                              style: TextStyle(
                                                color: Color(0xFF6E6E6E),
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              convertTimestampToFormattedDateTime(
                                                  int.parse(
                                                      data['waktu_booking'])),
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Expanded(
                                            flex: 6,
                                            child: Text(
                                              'Jenis Olahraga',
                                              style: TextStyle(
                                                color: Color(0xFF6E6E6E),
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              dataArena['jenis'],
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Divider(),
                              ),
                              //DETAIL BOOKING
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Detail Booking',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Nama Arena',
                                              style: TextStyle(
                                                color: Color(0xFF6E6E6E),
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              dataArena['nama'],
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Nama Pelanggan',
                                              style: TextStyle(
                                                color: Color(0xFF6E6E6E),
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Alroy Rasyid Resan',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Booking Untuk',
                                              style: TextStyle(
                                                color: Color(0xFF6E6E6E),
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              data['tanggal'],
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Waktu',
                                              style: TextStyle(
                                                color: Color(0xFF6E6E6E),
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              data['waktu'] + " WIB",
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Total Tagihan',
                                              style: TextStyle(
                                                color: Color(0xFF6E6E6E),
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Rp' + dataArena['harga'],
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Biaya Admin',
                                              style: TextStyle(
                                                color: Color(0xFF6E6E6E),
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Rp2.000',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Total Bayar',
                                              style: TextStyle(
                                                color: Color(0xFF6E6E6E),
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Rp' + data['total'],
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Divider(),
                              ),
                              //RINCIAN PEMBAYARAN
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Rincian Pembayaran',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Expanded(
                                            flex: 6,
                                            child: Text(
                                              'Metode Pembayaran',
                                              style: TextStyle(
                                                color: Color(0xFF6E6E6E),
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              data['metode'],
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: Text(
                                              dataArena['jenis'],
                                              style: const TextStyle(
                                                color: Color(0xFF6E6E6E),
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              'Rp' + data['total'],
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: Text(
                                              ket3,
                                              style: const TextStyle(
                                                color: Color(0xFF6E6E6E),
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              ket4,
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Divider(),
                              ),
                              //TOTAL PEMBAYARAN
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 20,
                                  right: 20,
                                  left: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                      flex: 6,
                                      child: Text(
                                        'Total Pembayaran',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Sora',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        'Rp' + data['total'],
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Sora',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    }
                  },
                );
              }
            }
          }),
      //BOTTOM NAV
      bottomNavigationBar: FutureBuilder(
        future: FirestoreService().getBookingById(widget.id),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              double tinggi = 150;
              if (data['status'] == 'belumBayar') {
                ket1 = "Belum Dibayar";
                ket2 = "Bayar sebelum pukul 23.59 WIB";
                ket3 = "Bayar sebelum";
                ket4 = "23.59 WIB";
                warna = 0xFFFF6969;
                warna2 = 0xFF6E6E6E;
                btn1 = "Sudah Bayar";
                btn2 = "Batalkan";
              } else if (data['status'] == 'lunas') {
                ket1 = "Sudah Dibayar";
                ket2 = "Lunas pada pukul ${data['jam_bayar']}";
                warna = 0xFF141E46;
                warna2 = 0xFF6E6E6E;
                btn1 = "Selesai";
                tinggi = 90;
              } else if (data['status'] == 'batal') {
                ket1 = "Dibatalkan";
                warna = 0xFFC70039;
                warna2 = 0xFF6E6E6E;
                btn2 = "Booking Lagi";
                tinggi = 90;
              } else if (data['status'] == 'batal_kedaluarsa') {
                ket1 = "Dibatalkan";
                ket2 = "Pembayaran kedaluarsa";
                warna = 0xFFC70039;
                warna2 = 0xFF6E6E6E;
                btn2 = "Booking Lagi";
                tinggi = 90;
              } else if (data['status'] == 'batal_pemilik') {
                ket1 = "Dibatalkan";
                ket2 = "Oleh Pemilik";
                warna = 0xFFC70039;
                warna2 = 0xFF6E6E6E;
                btn2 = "Booking Lagi";
                tinggi = 90;
              } else if (data['status'] == 'selesai_norate') {
                ket1 = "Selesai";
                ket2 = "Beri Rating";
                warna = 0xFF0B8B00;
                warna2 = 0xFF9E9800;
                btn1 = "Beri Ulasan";
                btn2 = "Booking Lagi";
              } else if (data['status'] == 'rated') {
                ket1 = "Selesai";
                ket2 = data['rate'] + " Sangat Puas";
                warna = 0xFF0B8B00;
                warna2 = 0xFF9E9800;
                btn1 = data['rate'] + " Sangat Puas";
                btn2 = "Booking Lagi";
              }
              return SizedBox(
                height: tinggi,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      if (btn1 != "")
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              _showConfirm();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC70039),
                              elevation: 4,
                              shadowColor: const Color(0xFFCAD6FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              btn1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (btn2 != "")
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF141E46),
                                elevation: 4,
                                shadowColor: const Color(0xFFCAD6FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                btn2,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
