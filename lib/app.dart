import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iov_app/core/local/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'providers.dart';
import 'routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders, // Đăng ký các Provider
      child: MaterialApp(
        supportedLocales: const [
          Locale('vi', 'VN'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode &&
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        title: "${AppLocalizations.of(context)?.translate('welcome')}",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: appRoutes,
      ),
    );
  }
}