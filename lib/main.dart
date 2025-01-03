import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iov_app/features/profile/profilemodels/profile_model.dart';
import 'package:iov_app/routes/route_state.dart';
import 'app.dart';
import 'core/utils/storage_util.dart';
import 'package:provider/provider.dart';

import 'features/home/viewmodels/home_viewmodel.dart';
import 'features/inspectionform/viewmodels/inspection_form_viewmodel.dart';
import 'features/kpi/screenmodels/kpi_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  await StorageUtil.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RouteState()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileModel()),
        ChangeNotifierProvider(create: (_) => InspectionFormViewmodel()),
        ChangeNotifierProvider(create: (_) => KpiModel())
      ],
      child: const App(),
    );
  }
}