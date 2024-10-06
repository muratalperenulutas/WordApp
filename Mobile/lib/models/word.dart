
class word_model{
  final String word;
  final String meaning1;
  final String? meaning2;
  final String? meaning3;


  const word_model({required this.word,
  required this.meaning1,
  this.meaning2,
  this.meaning3
  });

  factory word_model.fromJson(Map<String,dynamic> json) => word_model(
    word: json['word'] as String,
    meaning1: json['meaning1'] as String,
    meaning2: json['meaning2'] as String?,
    meaning3: json['meaning3'] as String?
  );

  Map<String,dynamic> toJson() => {
    'word': word,
    'meaning1': meaning1,
    'meaning2': meaning2?? ' ',
    'meaning3': meaning3?? ' ',
  };

}
 