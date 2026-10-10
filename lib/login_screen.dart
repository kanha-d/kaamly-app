import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  bool isValidPhone = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void onPhoneChanged(String value) {
    setState(() {
      isValidPhone = value.length == 10;
    });
  }

  void continueLogin() {
    if (!isValidPhone) return;

    // TODO:
    // Call your existing OTP API here.
    //
    // Example:
    // await apiService.sendOtp(phoneController.text);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MainScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 24,
                        top: 12,
                      ),
                      child: _CloseButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MainScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Illustration
                  SizedBox(
                    height: size.height * 0.35,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                      ),
                      child: Image.asset(
                        'assets/images/login-banner.jpg',
                        fit: BoxFit.contain,
                        // Prevent crash if asset isn't added yet.
                        errorBuilder: (_, __, ___) {
                          return const _LoginPlaceholder();
                        },
                      ),
                    ),
                  ),

                  // White content
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(
                      34,
                      22,
                      34,
                      28,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 0),
                        const Text(
                          'Hiring,',
                          style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          'Made Easy',
                          style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primary,
                            height: 1,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Phone field
                        Container(
                          height: 54,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFD0D3D8),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 16),

                              const SizedBox(width: 8),

                              const Text(
                                '+91',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.darkText,
                                ),
                              ),

                              const SizedBox(width: 10),
                              Container(
                                width: 1,
                                height: 25,
                                color: Colors.grey.shade300,
                              ),

                              const SizedBox(width: 14),

                              Expanded(
                                child: TextField(
                                  controller: phoneController,
                                  onChanged: onPhoneChanged,
                                  keyboardType:
                                  TextInputType.phone,
                                  maxLength: 10,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  decoration:
                                  const InputDecoration(
                                    hintText:
                                    '000 000 0000',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFA4A7AD),
                                    ),
                                    border: InputBorder.none,
                                    counterText: '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Continue button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed:
                            isValidPhone
                                ? continueLogin
                                : null,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                              AppTheme.primary,
                              disabledBackgroundColor:
                              const Color(0xFFBEC0C4),
                              foregroundColor: Colors.white,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(32),
                              ),
                            ),
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Divider
                        const _OrDivider(),

                        const SizedBox(height: 25),

                        // Social buttons
                        Row(
                          children: [
                            Expanded(

                              child: _SocialButton(
                                icon: const _GoogleIcon(),
                                onTap: () {},
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: _SocialButton(
                                icon: const Icon(
                                  Icons.apple,
                                  size: 28,
                                  color: Colors.black,
                                ),
                                onTap: () {},
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: _SocialButton(
                                icon: const Icon(
                                  Icons.email_rounded,
                                  size: 23,
                                  color: Color(0xFF252A34),
                                ),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        const Text(
                          'By continuing, you agree to Kaamly\'s '
                              'Terms and our Privacy Policy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.45,
                            color: Color(0xFF4E535C),
                          ),
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// CLOSE BUTTON
// ------------------------------------------------------------

class _CloseButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CloseButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(.75),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 56,
          height: 56,
          child: Icon(
            Icons.close,
            size: 27,
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// LOGIN PLACEHOLDER
// ------------------------------------------------------------

class _LoginPlaceholder extends StatelessWidget {
  const _LoginPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 230,
        height: 230,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.45),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.handyman_rounded,
          size: 100,
          color: AppTheme.primary,
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// OR DIVIDER
// ------------------------------------------------------------

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFFE0E1E4),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Or continue with',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF626771),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFFE0E1E4),
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------
// SOCIAL BUTTON
// ------------------------------------------------------------

class _SocialButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF1F2F5),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 54,
          height: 54,
          child: Center(
            child: icon,
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// GOOGLE ICON
// ------------------------------------------------------------

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'G',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF4285F4),
      ),
    );
  }
}