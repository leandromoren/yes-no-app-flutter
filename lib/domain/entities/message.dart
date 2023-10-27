//todo dentro de domain es codigo puro de dart
enum FromWho {
  me, //Mio
  hers //Ella
}

class Message {
  final String text;
  final String? imageUrl;
  late final FromWho fromWho;

  Message({
    required this.text,
    this.imageUrl,
    required this.fromWho
  });
}