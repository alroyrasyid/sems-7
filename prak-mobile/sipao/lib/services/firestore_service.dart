import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FirestoreService {
  FirebaseAuth _authService = FirebaseAuth.instance;

  final CollectionReference jenisOlahraga =
      FirebaseFirestore.instance.collection("jenisOlahraga");
  final CollectionReference arenas =
      FirebaseFirestore.instance.collection("arenas_malang");
  final CollectionReference bookings =
      FirebaseFirestore.instance.collection("bookings");
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  //getUserByUID
  Future<DocumentSnapshot> getUserByUIDProfile() {
    final userStream = users.doc(_authService.currentUser!.uid).get();
    return userStream;
  }

  //getUserByUID
  Future<DocumentSnapshot> getUserByUID(uid) {
    final userStream = users.doc(uid).get();
    return userStream;
  }

  //getJenisOlahraga
  Stream<QuerySnapshot> getJenisOlahraga() {
    final jenisOlahragaStream = jenisOlahraga.snapshots();
    return jenisOlahragaStream;
  }

  //getArenas
  Stream<QuerySnapshot> getArenas(String jenisOlahraga) {
    final arenasStream =
        arenas.where('jenis', isEqualTo: jenisOlahraga).snapshots();
    return arenasStream;
  }

  // getArenaById
  Future<DocumentSnapshot> getArenaById(String id) {
    final arenaStream = arenas.doc(id).get();
    return arenaStream;
  }

  //postBooking
  Future<void> addBooking(
    String idBooking,
    String idArena,
    String waktuBooking,
    String tanggal,
    String waktu,
    String total,
    String metode,
  ) async {
    bookings.add({
      'uid': _authService.currentUser!.uid,
      'id_booking': idBooking,
      'id_arena': idArena,
      'waktu_booking': waktuBooking,
      'tanggal': tanggal,
      'waktu': waktu,
      'total': total,
      'metode': metode,
      'status': 'belumBayar',
      'jam_bayar': '',
      'rate': '',
    });
  }

  //getBookings
  Stream<QuerySnapshot> getBookingsByUID() {
    final bookingsStream = bookings
        .where('uid', isEqualTo: _authService.currentUser!.uid)
        .orderBy('waktu_booking', descending: true)
        .snapshots();
    return bookingsStream;
  }

  //getBookingByID
  Future<DocumentSnapshot> getBookingById(String id) {
    final bookingStream = bookings.doc(id).get();
    return bookingStream;
  }

  //updateBookingStatus
  Future<void> updateBookingStatus(String id, String status) async {
    bookings.doc(id).update({
      'status': status,
      'jam_bayar': DateFormat.Hm().format(DateTime.now()),
    });
  }

  //updatePhoneNumber
  Future<void> updatePhoneNumber(String notelp) async {
    users.doc(_authService.currentUser!.uid).update({
      'notelp': notelp,
    });
  }

  //post
  Future<void> addArena(
    String namaArena,
    String foto,
    String alamat,
    String jenisOlahraga,
  ) async {
    arenas.add({
      'namaArena': namaArena,
      'foto': foto,
      'alamat': alamat,
      'jenisOlahraga': jenisOlahraga
    });
  }

  //update
  Future<void> updateArena(
    String id,
    String namaArena,
    String foto,
    String alamat,
    String jenisOlahraga,
  ) async {
    arenas.doc(id).update({
      'namaArena': namaArena,
      'foto': foto,
      'alamat': alamat,
      'jenisOlahraga': jenisOlahraga,
    });
  }

  //delete
  Future<void> deleteArena(String id) async {
    arenas.doc(id).delete();
  }
}
