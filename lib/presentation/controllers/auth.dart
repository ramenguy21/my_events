import 'package:get/get.dart';
import '../../data/repositories/auth.dart';
import '../../data/models/user.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  var errorMessage = ''.obs; // Add error state

  Future<void> login(String email, String password, bool rememberMe) async {
    try {
      isLoading.value = true;
      errorMessage.value = ''; // Clear previous errors

      final user = await _authRepository.login(email, password);
      currentUser.value = user;
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
    } catch (e) {
      errorMessage.value = e.toString(); // Set error message
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final user = await _authRepository.register(email, password);
      currentUser.value = user;
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkAuthStatus() async {
    final token = await _authRepository.getToken();
    if (token != null) {
      isLoggedIn.value = true;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    currentUser.value = null;
    isLoggedIn.value = false;
    Get.offAllNamed('/auth');
  }
}
