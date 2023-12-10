import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sipao/services/firestore_service.dart';
import 'package:sipao/view/user/home/detail_arena_page.dart';
import 'package:intl/intl.dart';

class ChooseArena extends StatefulWidget {
  const ChooseArena({super.key, required this.jenisOlahraga});

  final String jenisOlahraga;

  @override
  State<ChooseArena> createState() => _ChooseArenaState();
}

class _ChooseArenaState extends State<ChooseArena> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APPBAR
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          width: double.infinity,
          color: const Color(0xFF141E46),
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            'Arena ${widget.jenisOlahraga}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //HEADBAR
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF141E46),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //ALAMAT
                    const Row(
                      children: [
                        Icon(
                          EvaIcons.pinOutline,
                          color: Colors.white,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                          ),
                          child: Text(
                            "Malang,",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                          ),
                          child: Text(
                            "Jawa Timur",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Sora',
                            ),
                          ),
                        ),
                        Icon(
                          Icons.navigate_next_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ],
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
                        child: Row(
                          children: [
                            const Padding(
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
                                'Cari arena ${widget.jenisOlahraga} di Malang..',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
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
            //CHOOSE ARENA
            StreamBuilder(
              stream: FirestoreService().getArenas(widget.jenisOlahraga),
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
                    List<QueryDocumentSnapshot> arenaList = snapshot.data!.docs;
                    return SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 15,
                            mainAxisExtent: 280,
                          ),
                          itemCount: arenaList.length,
                          itemBuilder: (BuildContext context, int index) {
                            QueryDocumentSnapshot documentSnapshot =
                                arenaList[index];

                            Map<String, dynamic> data =
                                documentSnapshot.data() as Map<String, dynamic>;

                            data['harga'] = int.tryParse(data['harga']) ?? 0;
                            NumberFormat formatter =
                                NumberFormat('#,###', 'id_ID');
                            data['harga'] = formatter.format(data['harga']);

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailArenaPage(
                                      id: documentSnapshot.id,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                        ),
                                        child: Image.network(
                                          data['foto'],
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: 140,
                                        ),
                                      ),
                                      //RATING
                                      Container(
                                        width: 70,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF141E46),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                EvaIcons.star,
                                                color: Color(0xFFEAFF00),
                                                size: 16,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5,
                                                  ),
                                                  child: Text(
                                                    data['rating'],
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      color: Color(0xFFEAFF00),
                                                      fontSize: 14,
                                                      fontFamily: 'Sora',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //SEC2
                                  Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color(0x3F141E46),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['nama'],
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Sora',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 5,
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  EvaIcons.pinOutline,
                                                  color: Color(0xFF6E6E6E),
                                                  size: 14,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Text(
                                                      data['alamat'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF6E6E6E),
                                                        fontSize: 14,
                                                        fontFamily: 'Sora',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            data['kecamatan'],
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Color(0xFF6E6E6E),
                                              fontSize: 14,
                                              fontFamily: 'Sora',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //SEC3
                                  Container(
                                    height: 40,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFC70039),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Rp${data['harga']}/jam",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                              ),
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
      ),
    );
  }
}
