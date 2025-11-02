import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/features/auth/models/enum_user_type.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/login/login_screen.dart';
import 'package:se7ety/features/auth/presentation/register/register_complete_screen.dart';
import 'package:se7ety/features/auth/presentation/register/register_screen.dart';
import 'package:se7ety/features/patient/home/presentation/patient_home_screen.dart';
import 'package:se7ety/features/patient/main/patient_main_screen.dart';
import 'package:se7ety/features/intro/onBoarding/onboarding_screen.dart';
import 'package:se7ety/features/intro/splash/splash_screen.dart';
import 'package:se7ety/features/intro/welcome/welcome_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String registerComplete = '/registerComplete';
  static const String patientMain = '/patientMain';
  static const String patientHome = '/patientHome';

  static GoRouter route = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(path: onboarding, builder: (context, state) => OnboardingScreen()),
      GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),
      GoRoute(
        path: login,
        builder: (context, state) {
          return BlocProvider(
            create: (BuildContext context) => AuthCubit(),
            child: LoginScreen(userType: state.extra as EnumUserType),
          );
        },
      ),
      GoRoute(
        path: register,
        builder: (context, state) {
          return BlocProvider(
            create: (BuildContext context) => AuthCubit(),
            child: RegisterScreen(userType: state.extra as EnumUserType),
          );
        },
      ),
      GoRoute(
        path: registerComplete,
        builder: (context, state) => BlocProvider(create: (BuildContext context) => AuthCubit(), child: RegisterCompleteScreen()),
      ),
      GoRoute(path: patientMain, builder: (context, state) => PatientMainScreen()),
      GoRoute(path: patientHome, builder: (context, state) => PatientHomeScreen()),
    ],
  );
}
