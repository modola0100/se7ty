import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/features/auth/models/doctor_model.dart';
import 'package:se7ety/features/auth/models/enum_user_type.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/domain/repositories/auth_repository.dart';
import 'package:se7ety/features/auth/presentation/login/login_screen.dart';
import 'package:se7ety/features/auth/presentation/register/register_complete_screen.dart';
import 'package:se7ety/features/auth/presentation/register/register_screen.dart';

import 'package:se7ety/features/intro/welcome/welcome_screen.dart';
import 'package:se7ety/features/onBoarding/onboarding_screen.dart';
import 'package:se7ety/features/patient/home/data/specialization.dart';
import 'package:se7ety/features/patient/home/presentation/cubit/patient_home_cubit.dart';
import 'package:se7ety/features/patient/home/presentation/pages/doctor_profile_screen.dart';
import 'package:se7ety/features/patient/home/presentation/pages/doctor_search_screen.dart';
import 'package:se7ety/features/patient/home/presentation/pages/patient_home_screen.dart';
import 'package:se7ety/features/patient/home/presentation/pages/specialization_docror_screen.dart';
import 'package:se7ety/features/patient/main/patient_main_screen.dart';
import 'package:se7ety/features/patient/search/presentation/pages/search_screen.dart';
import 'package:se7ety/features/splash/splash_screen.dart';

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
  static const String patientsearch = '/patientsearch';
  static const String specializationDoctor = '/specializationDoctor';
  static const String doctorProfile = '/doctorProfile';
  static const String doctorSearch = '/doctorSearch';

  static GoRouter route = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),
      GoRoute(
        path: login,
        builder: (context, state) {
          return BlocProvider(
            create: (BuildContext context) => AuthCubit(AuthRepository()),
            child: LoginScreen(userType: state.extra as EnumUserType),
          );
        },
      ),
      GoRoute(
        path: register,
        builder: (context, state) {
          return BlocProvider(
            create: (BuildContext context) => AuthCubit(AuthRepository()),
            child: RegisterScreen(userType: state.extra as EnumUserType),
          );
        },
      ),
      GoRoute(
        path: registerComplete,
        builder: (context, state) => BlocProvider(
          create: (BuildContext context) => AuthCubit(AuthRepository()),
          child: RegisterCompleteScreen(),
        ),
      ),
      GoRoute(
        path: patientMain,
        builder: (context, state) => PatientMainScreen(),
      ),
      GoRoute(
        path: patientHome,
        builder: (context, state) => PatientHomeScreen(),
      ),
      GoRoute(path: patientsearch, builder: (context, state) => SearchScreen()),
      GoRoute(
        path: specializationDoctor,
        builder: (context, state) => BlocProvider(
          create: (BuildContext context) => PatientHomeCubit()
            ..filterBySpecialization(
              (state.extra as SpecializationCardModel).name,
            ),
          child: SpecializationDocrorScreen(
            model: state.extra as SpecializationCardModel,
          ),
        ),
      ),
      GoRoute(
        path: doctorProfile,
        builder: (context, state) =>
            DoctorProfileScreen(doctorModel: state.extra as DoctorModel),
      ),
      GoRoute(
        path: doctorSearch,
        builder: (context, state) =>
            DoctorSearchScreen(searchKey: state.extra as String),
      ),
    ],
  );
}
