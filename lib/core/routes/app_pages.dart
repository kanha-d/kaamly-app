import 'package:get/get.dart';

import '../../login_screen.dart';
import '../../onboarding_screen.dart';
import '../../otp_screen.dart';
import '../../role_selection_screen.dart';
import '../../splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
    // GetPage(
    //   name: AppRoutes.otp,
    //   page: () => const OtpScreen(),
    // ),
    // GetPage(
    //   name: AppRoutes.roleSelection,
    //   page: () => const RoleSelectionScreen(),
    // ),
  ];
}