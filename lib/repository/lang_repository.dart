import 'package:hive_flutter/hive_flutter.dart';
import 'package:rapid_response/models/lang_model.dart';

class LangRepository {
  late Box<Langs> _lang;

  Future<void> init() async {
    _lang = await Hive.openBox<Langs>('langBox');
  }

  Future<int> saveLang(String lang)  {
    return _lang.add(Langs(appLang: lang));
  }

  getLang(){
    List<Langs> langData = _lang.values.toList();
    if (langData.isNotEmpty) {
      return langData[langData.length - 1].appLang.toString();
    } else {
      return "";
    }
  }
}
