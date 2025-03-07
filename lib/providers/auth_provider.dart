import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/api/muscle_track_api.dart';
import 'package:muscletrack_admin_dashboard/models/remote/response/auth_response.dart';
import 'package:muscletrack_admin_dashboard/router/router.dart';
import 'package:muscletrack_admin_dashboard/services/local_storage.dart';
import 'package:muscletrack_admin_dashboard/services/navigation_service.dart';
import 'package:muscletrack_admin_dashboard/services/notification_service.dart';

enum AuthStatus { checking, authenticated, unauthenticated }

class AuthProvider extends ChangeNotifier {
  String? token;
  AuthStatus authStatus = AuthStatus.checking;
  User? user;

  AuthProvider() {
    isAuthenticated();
  }

  login(String email, String password) {
    final data = {
      'email': email,
      'password': password,
    };

    MuscleTrackApi.httpPost('/admin/login', data).then((response) {
      final authResponse = AuthResponse.fromJson(response);

      user = authResponse.user;

      LocalStorage.prefs!.setString('token', authResponse.token);

      authStatus = AuthStatus.authenticated;

      NavigationService.replaceTo(AppRouter.dashboardRoute);

      MuscleTrackApi.configureDio();

      notifyListeners();
    }).catchError((error) {
      NotificationService.showSnackBarError(
          'Login was not successful. Please try again.');
    });
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs!.getString('token');

    if (token == null) {
      authStatus = AuthStatus.unauthenticated;

      notifyListeners();

      return false;
    }

    try {
      final response = await MuscleTrackApi.httpGet('/admin/me');

      final authResponse = AuthResponse.fromJson(response);

      LocalStorage.prefs!.setString('token', authResponse.token);

      user = authResponse.user;

      authStatus = AuthStatus.authenticated;

      notifyListeners();

      return true;
    } catch (e) {
      authStatus = AuthStatus.unauthenticated;

      notifyListeners();

      return false;
    }
  }

  logout() {
    LocalStorage.prefs!.remove('token');
    authStatus = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
