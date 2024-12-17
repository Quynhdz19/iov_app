import 'package:provider/provider.dart';
import 'features/auth/viewmodels/auth_viewmodel.dart';

final appProviders = [
  ChangeNotifierProvider(create: (_) => AuthViewModel()),
];