class ad {
  final String adType;
  final String title;
  final String description;
  final String transactionType;
  final String imagePath;
  final String uploaderEmail;
  final String timestamp;

  ad({
    required this.adType,
    required this.title,
    required this.description,
    required this.transactionType,
    required this.imagePath,
    required this.uploaderEmail,
    required this.timestamp,
  });

  Map<String,dynamic> toMap(){
    return {
      'adType': adType,
      'title':title,
      'description':description,
      'transactionType':transactionType,
      'imagePath':imagePath,
      'uploaderEmail':uploaderEmail,
      'timestamp':timestamp,
    };
  }
}
