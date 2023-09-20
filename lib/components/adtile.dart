import 'package:flutter/material.dart';
import 'package:borrow/screens/chat_screen.dart';


class AdTile extends StatefulWidget {
  final String uploaderEmail;
  final String timestamp;
  final String title;
  final String transactionType;
  final String description;
  final String imagePath;

  AdTile({
    required this.uploaderEmail,
    required this.timestamp,
    required this.title,
    required this.transactionType,
    required this.description,
    required this.imagePath,
  });

  @override
  State<AdTile> createState() => _AdTileState();
}



class _AdTileState extends State<AdTile> {
  bool bookmarked = false;

  void openChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          receiveruserEmail: widget.uploaderEmail,
          receiverUserID: widget.timestamp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFF144272),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // First Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.uploaderEmail,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                DateTime.now().toString(),
                // widget.timestamp,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),

          // Second Row
          Container(
            color: Color(0xFF0A2647),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.imagePath, // Use the provided imagePath
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.transactionType,
                            style: TextStyle(color: Colors.green, fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        widget.description,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Third Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    bookmarked = !bookmarked;
                  });
                },
                icon: Icon(
                  bookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: openChat,
                icon: Icon(
                  Icons.chat,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
