import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';
import 'core/utils/storage_util.dart';
import 'package:provider/provider.dart';

import 'features/home/viewmodels/home_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Load biến môi trường
  await StorageUtil.init();           // Khởi tạo lưu trữ cục bộ
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        // Thêm các ViewModel khác nếu cần
      ],
      child: const App(),
    );
  }
}