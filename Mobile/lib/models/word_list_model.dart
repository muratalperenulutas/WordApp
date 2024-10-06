
class word_list_model{
  final String wordListName;
  final int wordCount;


  const word_list_model({required this.wordListName,
  required this.wordCount,

  });

  factory word_list_model.fromJson(Map<String,dynamic> json) => word_list_model(
    wordListName: json['listName'] as String,
    wordCount: json['wordCount'] as int,

  );

  Map<String,dynamic> toJson() => {
    'wordListName': wordListName,
    'wordCount': wordCount,

  };

}
 