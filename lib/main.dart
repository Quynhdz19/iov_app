import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iov_app/features/profile/profilemodels/profile_model.dart';
import 'app.dart';
import 'core/utils/storage_util.dart';
import 'package:provider/provider.dart';

import 'features/home/viewmodels/home_viewmodel.dart';
import 'features/inspectionform/viewmodels/inspection_form_viewmodel.dart';
import 'features/kpi/screenmodels/kpi_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env"); // Load biến môi trường
  await StorageUtil.init();           // Khởi tạo lưu trữ cục bộ
  final deviceToken = await FirebaseMessaging.instance.getToken();
  print("Device Token: $deviceToken");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileModel()),
        ChangeNotifierProvider(create: (_) => InspectionFormViewmodel()),
        ChangeNotifierProvider(create: (_) => KpiModel()..loadFakeData())
      ],
      child: const App(),
    );
  }
}