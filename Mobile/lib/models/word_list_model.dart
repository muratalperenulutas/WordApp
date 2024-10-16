
class word_list_model{
  final String wordListName;
  final int wordCount;
  final String wordListId;


  const word_list_model({required this.wordListName,
  required this.wordCount,
  required this.wordListId
  });

  factory word_list_model.fromJson(Map<String,dynamic> json) => word_list_model(
    wordListName: json['wordListName'] as String,
    wordCount: json['wordCount'] as int,
    wordListId: json['wordListId'] as String

  );

  Map<String,dynamic> toJson() => {
    'wordListName': wordListName,
    'wordCount': wordCount,
    'wordListId':wordListId
  };

}
 