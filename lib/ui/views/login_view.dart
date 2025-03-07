import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletrack_admin_dashboard/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:muscletrack_admin_dashboard/providers/login_form_provider.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/buttons/custom_outlined_button.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/inputs/custom_text_form_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of<AuthProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: Builder(
        builder: (context) {
          final loginFormProvider = Provider.of<LoginFormProvider>(context);

          return Container(
            margin: const EdgeInsets.only(top: 19),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Let’s',
                            style: GoogleFonts.urbanist(
                              fontSize: 25.0,
                              color: AppColors.blueDarkColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: ' Sign In',
                            style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.w800,
                              color: AppColors.blueDarkColor,
                              fontSize: 25.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Hey, Enter your details to get sign in \nto your account.',
                      style: GoogleFonts.urbanist(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Email',
                              style: GoogleFonts.urbanist(
                                fontSize: 12.0,
                                color: AppColors.blueDarkColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomTextFormField(
                            onChanged: (value) {
                              loginFormProvider.onEmailChange(value);
                            },
                            errorMessage: loginFormProvider.email.errorMessage,
                            hint: 'Enter your email',
                            prefixIcon: Icons.email_outlined,
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Password',
                              style: GoogleFonts.urbanist(
                                fontSize: 12.0,
                                color: AppColors.blueDarkColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomTextFormField(
                            onChanged: (value) {
                              loginFormProvider.onPasswordChange(value);
                            },
                            isPassword: true,
                            errorMessage:
                                loginFormProvider.password.errorMessage,
                            hint: 'Enter your password',
                            prefixIcon: Icons.lock_outline,
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: CustomOutlinedButton(
                              onPressed: () {
                                if (loginFormProvider.isValid) {
                                  auth.login(
                                    loginFormProvider.email.value,
                                    loginFormProvider.password.value,
                                  );
                                }
                              },
                              text: 'Login',
                              isFilled: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
