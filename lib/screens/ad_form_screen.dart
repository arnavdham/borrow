import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'side_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AdFormPage extends StatefulWidget {
  @override
  _AdFormPageState createState() => _AdFormPageState();
}

class _AdFormPageState extends State<AdFormPage> {
  String _adType = 'Take'; // Default value
  String _transactionType = 'Sale'; // Default value
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final String currentUserEmail = FirebaseAuth.instance.currentUser!.email.toString();

  String? _imagePath;

  // Future<void> _getImage() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //       _imagePath = pickedFile.path;
  //     });
  //   }
  // }

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File file = File(pickedFile.path);
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('ad_images/$fileName.jpg');
      await firebaseStorageRef.putFile(file);

      final String imagePath = await firebaseStorageRef.getDownloadURL();

      setState(() {
        _imagePath = imagePath;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      backgroundColor: Color(0xFF0A2647),
      appBar: AppBar(
        backgroundColor: Color(0xFF144272),
        title: Center(child: Text('Post A Request')),
        actions: [
          IconButton(
              onPressed: null,
              icon: const Icon(
                Icons.chat,
                color: Colors.white,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5.0),
          width:  double.infinity,
          decoration:  BoxDecoration (
            color:  Color(0xff113861),
            borderRadius:  BorderRadius.circular(5.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 175.0,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _adType = 'Take';
                        });
                      },
                      child: Text('Take'),
                      style: ElevatedButton.styleFrom(
                        primary: _adType == 'Take' ? Colors.blue : Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 175.0,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _adType = 'Give';
                        });
                      },
                      child: Text('Give'),
                      style: ElevatedButton.styleFrom(
                        primary: _adType == 'Give' ? Colors.blue : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Item Title',labelStyle: TextStyle(color: Colors.white,fontSize: 15.0),filled: true,fillColor:Color(0xFF0A2647),
                      enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Color(0xFF144272),
                    )
                  )),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Item Description',labelStyle: TextStyle(color: Colors.white,fontSize: 15.0),filled: true,fillColor:Color(0xFF0A2647),enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Color(0xFF144272),
                      )
                  )),
                  maxLines: 3,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16.0),

              Row(
                children: [
                  Text('Post the item for:',style: TextStyle(color: Colors.white),),
                  SizedBox(width: 10.0),
                  DropdownButton<String>(
                    dropdownColor: Colors.black,
                    value: _transactionType,
                    onChanged: (String? newValue) { // Change String to String?
                      if (newValue != null) {
                        setState(() {
                          _transactionType = newValue;
                        });
                      }
                    },
                    items: <String>['Sale', 'Required'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(color: Colors.white),),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0,horizontal: 100.0),
                width: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary:Color(0xff0c9292),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
                  onPressed: _getImage,
                  child: Text('Select Image'),
                ),
              ),
              _imagePath != null
                  ? Image.file(
                File(_imagePath!), // Assuming _imagePath is a valid path
                height: 100.0,
              )
                  : Container(),
              SizedBox(height: 16.0),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0,horizontal: 100.0),
                width: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary:Color(0xff0c9292),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
                  onPressed: _submitAd,
                  child: Text('POST',style: TextStyle(fontSize: 20),),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF144272),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Image.asset(
                'assets/Lendbuttonfinal.jpg',
              ),
              iconSize: 60.0,
              onPressed: () {Navigator.pushNamed(context, 'lend');},
            ),
            IconButton(
              icon: Image.asset(
                'assets/Postbuttonfinal.jpg',
              ),
              iconSize: 60.0,
              onPressed: () {Navigator.pushNamed(context, 'adform');},
              isSelected: true,
            ),
            IconButton(
              icon: Image.asset(
                'assets/Borrowbuttonfinalfinal.jpg',
              ),
              iconSize: 60.0,
              onPressed: () {Navigator.pushNamed(context, 'borrow');},
              isSelected: true,
            ),
          ],
        ),
      ),
    );
  }

  void _submitAd() {
    String adType = _adType;
    String title = _titleController.text;
    String description = _descriptionController.text;
    String transactionType = _transactionType;


    FirebaseFirestore.instance.collection('ads').add({
      'adType': adType,
      'title': title,
      'description': description,
      'transactionType': transactionType,
      'imagePath': _imagePath,
      'uploaderEmail': currentUserEmail,
      'timestamp': DateTime.now().toString(),
    }).then((value) {
    // Optional: Show a confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ad Posted'),
          content: Text('Your ad has been posted successfully.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
    );
  }
}

