import 'package:borrow/components/adtile.dart';
import 'package:borrow/components/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:borrow/screens/side_bar.dart';
import 'package:borrow/components/ad.dart';

class BorrowScreen extends StatefulWidget {
  const BorrowScreen({Key? key}) : super(key: key);

  @override
  State<BorrowScreen> createState() => _BorrowScreenState();
}

class _BorrowScreenState extends State<BorrowScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideBar(),
        backgroundColor: Color(0xFF0A2647),
        appBar: AppBar(
          backgroundColor: Color(0xFF144272),

          title: Center(child: Text('Borrow Requests')),

          actions: [
            IconButton(onPressed: null, icon: const Icon(Icons.chat,color: Colors.white,)),
          ],
        ),
     body:FutureBuilder<QuerySnapshot>(
        future: _firebaseService.getBorrowAds(), // Fetch data from Firestore
      builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
           return CircularProgressIndicator(); // Display a loading indicator
          } else if (snapshot.hasError) {
           return Text('Error: ${snapshot.error}'); // Handle error
         } else {
           // Display the list of AdTiles
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
               itemBuilder: (context, index) {
                var adData = snapshot.data!.docs[index].data() as Map<String, dynamic>?;
                if (adData != null) {
                  return AdTile(
                    uploaderEmail: adData['uploaderEmail'] ?? '',
                    timestamp: adData['timestamp'] ?? '',
                    title: adData['title'] ?? '',
                    transactionType: adData['transactionType'] ?? '',
                    description: adData['description'] ?? '',
                    imagePath: adData['imagePath'] ?? '',
                  );
                } else {
                  return SizedBox.shrink(); // Return an empty widget if data is null
                }
            },
          );
          }
        },
       ),
        bottomNavigationBar: BottomAppBar(
          color: Color(0xFF144272),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Image.asset('assets/Lendbuttonfinal.jpg',
                width: 60.0,
                height: 60.0,
                ),
                iconSize: 60.0,
                onPressed: () {Navigator.pushNamed(context, 'lend');},
              ),
              IconButton(
                icon: Image.asset('assets/Postbuttonfinal.jpg',
                  width: 60.0,
                  height: 60.0,),
                iconSize: 60.0,
                onPressed: () { Navigator.pushNamed(context, 'adform');},
                isSelected: true,
              ),
              IconButton(
                icon: Image.asset('assets/Borrowbuttonfinalfinal.jpg',
                  width: 60.0,
                  height: 60.0,),
                iconSize: 60.0,
                onPressed: () { Navigator.pushNamed(context, 'borrow');},
                isSelected: true,
              ),
            ],
          ),
        ),
    );
  }
}