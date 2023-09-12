import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference ads = FirebaseFirestore.instance.collection('ads');

  Future<QuerySnapshot> getBorrowAds() async {
    return await ads.where('adType', isEqualTo: 'Take').get();
  }

  Future<QuerySnapshot> getLendAds() async {
    return await ads.where('adType', isEqualTo: 'Give').get();
  }
}
