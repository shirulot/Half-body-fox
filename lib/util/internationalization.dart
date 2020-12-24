import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

///国际化工具类
class Internationalization extends LocalizationsDelegate<Translations> {
  ///支持的语言种类
  static const List<String> supportedLanguages = ['en', 'zh'];

  @override
  bool isSupported(Locale locale) =>
      supportedLanguages.indexOf(locale.languageCode) >= 0;

  @override
  Future<Translations> load(Locale locale) {
    print("load is called");
    return Translations.load(locale);
  }

  @override
  bool shouldReload(Internationalization old) => false;

  Iterable<Locale> supportedLocales() =>
      supportedLanguages.map<Locale>((lang) => new Locale(lang));
}

class Translations {
  Translations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
  }

  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  String text(String key) {
    print("start apply text");
    return _localizedValues[key] ?? '** $key not found';
  }

  static Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale);
    String jsonContent =
        await rootBundle.loadString("locale/${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  get currentLanguage => locale.languageCode;
}

class LocaleUtil {
  static Translations translations;

  static init(BuildContext context) {
    if (translations == null) {
      translations = Translations.of(context);
    }
  }

  static String text(String text) {
    if (translations == null) {
      print("translations un Init");
    } else {
      translations.text(text);
    }
  }
}
