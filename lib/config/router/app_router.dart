import 'package:atiempo_mobile_app/config/router/app_routes.dart';
import 'package:atiempo_mobile_app/config/router/placeholder_screen.dart';
import 'package:atiempo_mobile_app/features/access/presentation/screens/activate_access_screen.dart';
import 'package:atiempo_mobile_app/features/access/presentation/screens/consent_screen.dart';
import 'package:atiempo_mobile_app/features/access/presentation/screens/create_account_screen.dart';
import 'package:atiempo_mobile_app/features/access/presentation/screens/invitation_screen.dart';
import 'package:atiempo_mobile_app/features/access/presentation/screens/sign_in_screen.dart';
import 'package:atiempo_mobile_app/features/access/presentation/screens/welcome_screen.dart';
import 'package:atiempo_mobile_app/features/alarm/presentation/screens/alarm_screen.dart';
import 'package:atiempo_mobile_app/features/alarm/presentation/screens/delegated_dose_screen.dart';
import 'package:atiempo_mobile_app/features/alarm/presentation/screens/dose_confirmed_screen.dart';
import 'package:atiempo_mobile_app/features/alarm/presentation/screens/pre_alert_screen.dart';
import 'package:atiempo_mobile_app/features/alarm/presentation/screens/still_pending_screen.dart';
import 'package:atiempo_mobile_app/features/flows/presentation/flows_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Every screen hangs from the flows index, so going anywhere keeps it underneath for the back button.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.flows,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.flows,
      builder: (BuildContext context, GoRouterState state) => const FlowsScreen(),
      routes: <RouteBase>[
        _screen(AppRoutes.welcome, (_) => const WelcomeScreen()),
        _screen(AppRoutes.signIn, (_) => const SignInScreen()),
        _screen(AppRoutes.createAccount, (_) => const CreateAccountScreen()),
        _screen(AppRoutes.invitation, (_) => const InvitationScreen()),
        _screen(AppRoutes.expiredInvitation, (_) => const InvitationScreen(isExpired: true)),
        _screen(AppRoutes.activateAccess, (_) => const ActivateAccessScreen()),
        _screen(AppRoutes.consent, (_) => const ConsentScreen()),
        _screen(AppRoutes.preAlert, (_) => const PreAlertScreen()),
        _screen(AppRoutes.alarm, (_) => const AlarmScreen()),
        _screen(AppRoutes.doseConfirmed, (_) => const DoseConfirmedScreen()),
        _screen(AppRoutes.doseConfirmedOffline, (_) => const DoseConfirmedScreen(isOffline: true)),
        _screen(AppRoutes.delegatedDose, (_) => const DelegatedDoseScreen()),
        _screen(AppRoutes.stillPending, (_) => const StillPendingScreen()),
        _screen(AppRoutes.today, (_) => const PlaceholderScreen(title: 'Hoy: el día del tratamiento')),
        _screen(AppRoutes.blockDetailPattern, (_) => const PlaceholderScreen(title: 'Detalle del bloque')),
        _screen(AppRoutes.delegateBlockPattern, (_) => const PlaceholderScreen(title: 'Elegir a quién delegar')),
        _screen(AppRoutes.blockDelegationPattern, (_) => const PlaceholderScreen(title: 'Esperando el acuse')),
      ],
    ),
  ],
);

GoRoute _screen(String location, Widget Function(GoRouterState state) build) {
  return GoRoute(
    path: location.substring(1),
    pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage<void>(
      key: state.pageKey,
      child: build(state),
      transitionDuration: const Duration(milliseconds: 250),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (_, Animation<double> animation, _, Widget child) => FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child,
      ),
    ),
  );
}
