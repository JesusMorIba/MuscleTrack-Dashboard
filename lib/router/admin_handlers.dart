import 'package:fluro/fluro.dart';
import 'package:muscletrack_admin_dashboard/providers/auth_provider.dart';
import 'package:muscletrack_admin_dashboard/ui/views/dashboard_view.dart';
import 'package:muscletrack_admin_dashboard/ui/views/login_view.dart';
import 'package:provider/provider.dart';

class AdminHandlers {
  static Handler login = Handler(handlerFunc: (context, params) {
    if (context == null) return null;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.authStatus == AuthStatus.unauthenticated) {
      return LoginView();
    }

    return DashboardView();
  });
}
