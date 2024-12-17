import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;


  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings = {};


  Future<bool> load() async {

    try {
      // Tạo đường dẫn tới file JSON cùng cấp
      String filePath = '/lang/${locale.languageCode}.json';

      // Đọc file JSON bằng File API
      String jsonString = await File(filePath).readAsString();

      // Parse JSON
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Chuyển đổi thành Map<String, String>
      _localizedStrings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });

      return true;
    } catch (e) {
      print('Error reading localization file: $e');
      return false;
    }
  }


  String? translate(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['vi', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}