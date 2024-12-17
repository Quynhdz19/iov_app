import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iov_app/core/services/auth_service.dart';

class AuthViewModel with ChangeNotifier {
  static final String _baseUrl = dotenv.env['API_URL'] ?? '';

  AuthService _authService = new AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.login(username, password);

      if (response.hashCode == 200) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Xử lý lỗi
        _errorMessage = 'Login failed';
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}