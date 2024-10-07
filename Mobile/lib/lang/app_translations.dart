import 'package:get/get.dart';
import 'tr_tr.dart';
import 'en_us.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'tr_TR': trTR,
      };
}
