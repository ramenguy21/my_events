import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../controllers/auth_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AuthController _authController = Get.put(AuthController());

  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();

  bool _rememberMe = false;
  bool _obscureLoginPassword = true;
  bool _obscureSignupPassword = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              children: [
                SizedBox(height: height * 0.05),

                // Logo/Title
                Text(
                  'MyEvents',
                  style: AppTextStyles.h1.copyWith(fontSize: 32),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  'Discover and create amazing events',
                  style: AppTextStyles.caption,
                ),

                SizedBox(height: height * 0.04),

                // Tabs
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.textSecondary,
                    labelStyle: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: const [
                      Tab(text: 'Login'),
                      Tab(text: 'Sign Up'),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.03),

                // Tab Views
                SizedBox(
                  height: height * 0.55,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildLoginForm(height, width),
                      _buildSignupForm(height, width),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(double height, double width) {
    return Column(
      children: [
        _buildTextField(
          controller: _loginEmailController,
          label: 'Email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: height * 0.02),

        _buildTextField(
          controller: _loginPasswordController,
          label: 'Password',
          icon: Icons.lock_outlined,
          obscureText: _obscureLoginPassword,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureLoginPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            onPressed: () =>
                setState(() => _obscureLoginPassword = !_obscureLoginPassword),
          ),
        ),

        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (val) => setState(() => _rememberMe = val ?? false),
              activeColor: AppColors.primary,
            ),
            Text('Remember me', style: AppTextStyles.body),
          ],
        ),

        SizedBox(height: height * 0.02),

        Obx(
          () => SizedBox(
            width: double.infinity,
            height: height * 0.06,
            child: ElevatedButton(
              onPressed: _authController.isLoading.value
                  ? null
                  : () => _authController.login(
                      _loginEmailController.text,
                      _loginPasswordController.text,
                      _rememberMe,
                    ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _authController.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'Login',
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupForm(double height, double width) {
    return Column(
      children: [
        _buildTextField(
          controller: _signupEmailController,
          label: 'Email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: height * 0.02),

        _buildTextField(
          controller: _signupPasswordController,
          label: 'Password',
          icon: Icons.lock_outlined,
          obscureText: _obscureSignupPassword,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureSignupPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            onPressed: () => setState(
              () => _obscureSignupPassword = !_obscureSignupPassword,
            ),
          ),
        ),

        SizedBox(height: height * 0.03),

        Obx(
          () => SizedBox(
            width: double.infinity,
            height: height * 0.06,
            child: ElevatedButton(
              onPressed: _authController.isLoading.value
                  ? null
                  : () => _authController.register(
                      _signupEmailController.text,
                      _signupPasswordController.text,
                    ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _authController.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'Sign Up',
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
        prefixIcon: Icon(icon, color: AppColors.primary),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
