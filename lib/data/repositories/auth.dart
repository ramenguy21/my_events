import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/user.dart';
import '../models/user.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _apiService.post('/login', {
        'email': email,
        'password': password,
      });

      final user = UserModel.fromJson(response.data);
      await _storage.write(key: 'token', value: user.token);
      await _storage.write(key: 'email', value: email);

      return user;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<UserModel> register(String email, String password) async {
    try {
      final response = await _apiService.post('/register', {
        'email': email,
        'password': password,
      });

      final user = UserModel.fromJson(response.data);
      await _storage.write(key: 'token', value: user.token);
      await _storage.write(key: 'email', value: email);

      return user;
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }
}
