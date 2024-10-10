class BookModel {
  final int? id;
  final String title;
  final String author;
  final String email;
  final String pdfPath;
  final String description;

  BookModel({
    this.id,
    required this.title,
    required this.author,
    required this.email,
    required this.pdfPath,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'email': email,
      'pdfPath': pdfPath,
      'description': description,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      email: map['email'],
      pdfPath: map['pdfPath'],
      description: map['description'],
    );
  }
}
