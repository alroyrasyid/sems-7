import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sipao/services/firestore_service.dart';
import 'package:sipao/view/user/home/choose_date_page.dart.dart';

class DetailArenaPage extends StatefulWidget {
  const DetailArenaPage({super.key, required this.id});

  final String id;

  @override
  State<DetailArenaPage> createState() => _DetailArenaPageState();
}

class _DetailArenaPageState extends State<DetailArenaPage> {
  late Map<String, dynamic> dataMap = {};

  @override
  void initState() {
    Map<String, dynamic> dataMap = {
      'id': widget.id,
      'nama': namaArena,
      'jamBuka': '',
      'jamTutup': '',
      'harga': '',
      'jenis': '',
    };
    super.initState();
  }

  String convertCodeToTime(int code) {
    String formattedTime = '';

    if (code == 23) {
      formattedTime = '23.59';
    } else {
      int jam = code < 10 ? code : code;
      formattedTime = '${jam.toString().padLeft(2, '0')}.00';
    }

    return formattedTime;
  }

  String? namaArena;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirestoreService().getArenaById(widget.id),
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

              dataMap['id'] = widget.id;
              dataMap['nama'] = data['nama'];
              dataMap['jamBuka'] = data['jamBuka'];
              dataMap['jamTutup'] = data['jamTutup'];

              data['jamBuka'] = convertCodeToTime(int.parse(data['jamBuka']));
              data['jamTutup'] = convertCodeToTime(int.parse(data['jamTutup']));

              dataMap['harga'] = data['harga'];

              data['harga'] = int.tryParse(data['harga']) ?? 0;
              NumberFormat formatter = NumberFormat('#,###', 'id_ID');
              data['harga'] = formatter.format(data['harga']);

              dataMap['jenis'] = data['jenis'];

              return Stack(
                children: [
                  //HEADBAR
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(
                          data['foto'],
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: 300,
                        ),
                        //QUICKINFO
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //RATING AND FAVORITE
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          EvaIcons.star,
                                          color: Color(0xFF9F9800),
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Text(
                                            data['rating'],
                                            style: const TextStyle(
                                              color: Color(0xFF141E46),
                                              fontSize: 16,
                                              fontFamily: 'Sora',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          "(999+ Penilaian)",
                                          style: TextStyle(
                                            color: Color(0xFF737272),
                                            fontSize: 16,
                                            fontFamily: 'Sora',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      EvaIcons.heartOutline,
                                      color: Color(0xFF737272),
                                      size: 36,
                                    ),
                                  ],
                                ),
                                //NAMA ARENA
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Text(
                                    data['nama'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                //ALAMAT
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        EvaIcons.pinOutline,
                                        size: 20,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Text(
                                            data['alamat'] +
                                                ', Kec. ' +
                                                data['kecamatan'],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Sora',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        EvaIcons.diagonalArrowRightUpOutline,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ),
                                //TIME
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        EvaIcons.clockOutline,
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Text(
                                          data['jamBuka'] +
                                              ' - ' +
                                              data['jamTutup'] +
                                              ' WIB',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Sora',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Divider(
                            thickness: 1,
                            color: Color(0xFFCCCCCC),
                          ),
                        ),
                        //OWNER
                        FutureBuilder(
                          future:
                              FirestoreService().getUserByUID(data['owner']),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                            if (userSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              if (userSnapshot.hasError) {
                                return Text(userSnapshot.error.toString());
                              } else {
                                Map<String, dynamic> dataUser =
                                    userSnapshot.data!.data()
                                        as Map<String, dynamic>;

                                return SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        ClipOval(
                                          child: Image.network(
                                            dataUser['foto'],
                                            fit: BoxFit.fill,
                                            width: 64,
                                            height: 64,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Dikelola oleh ${dataUser['fullname']}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Sora',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 5,
                                                  ),
                                                  child: Text(
                                                    "Sedang aktif",
                                                    style: TextStyle(
                                                      color: Color(0xFF0B8B00),
                                                      fontSize: 14,
                                                      fontFamily: 'Sora',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Icon(
                                              EvaIcons.messageCircleOutline,
                                              color: Color(0xFF737272),
                                              size: 28,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Icon(
                                                EvaIcons.phoneOutline,
                                                color: Color(0xFF737272),
                                                size: 28,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Divider(
                            thickness: 1,
                            color: Color(0xFFCCCCCC),
                          ),
                        ),
                        //DESC
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Deskripsi",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Sora',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Text(
                                    data['deskripsi'],
                                    style: const TextStyle(
                                      color: Colors.black,
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
                        //PRICE
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Harga Sewa",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Sora',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        EvaIcons.pricetagsOutline,
                                        size: 28,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Text(
                                            "Rp${data['harga']}",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Sora',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Text(
                                    "* per jam per lapangan",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //SPEC
                        const SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Spesifikasi Arena",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Sora',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        EvaIcons.awardOutline,
                                        size: 28,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Text(
                                            "10 arena futsal spesifikasi internasional",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Sora',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //FACILITY
                        const SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Fasilitas Umum",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Sora',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        EvaIcons.shakeOutline,
                                        size: 28,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Text(
                                            "3 toilet/kamar mandi",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Sora',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        EvaIcons.pauseCircleOutline,
                                        size: 28,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Text(
                                            "Kantin",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Sora',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        EvaIcons.settingsOutline,
                                        size: 28,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Text(
                                            "Parkir mobil dan motor",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Sora',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        EvaIcons.npmOutline,
                                        size: 28,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Text(
                                            "Loker",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Sora',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //BUTTON
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 70,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFF141E46),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Icon(
                              EvaIcons.arrowBackOutline,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF141E46),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            EvaIcons.shareOutline,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
      //BOTTOM NAV
      bottomNavigationBar: SizedBox(
        height: 90,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChooseDatePage(
                      dataMap: dataMap,
                    ),
                  ),
                );
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
                "Pilih Jadwal",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
