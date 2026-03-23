import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foryou/features/widgets/inputs/auth_input.dart';

import '../../../core/app_style.dart';
import '../../widgets/animation_widgets/wave_widget.dart';
import '../../widgets/switches/animated_switch.dart';
import '../../widgets/hud/app_bar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, this.isRegistering = true});

  final bool isRegistering;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  late bool isRegistering = widget.isRegistering;

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  String? emailError;
  String? passwordError;
  String? confirmError;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  bool validate() {
    final email = _emailController.text.trim();
    final pass = _passwordController.text;
    final confirm = _confirmPasswordController.text;

    emailError = null;
    passwordError = null;
    confirmError = null;

    if (!email.contains('@') || !email.contains('.')) {
      emailError = "Invalid email";
    }

    if (pass.length < 6) {
      passwordError = "Min 6 characters";
    }

    if (isRegistering && pass != confirm) {
      confirmError = "Passwords do not match";
    }

    setState(() {});

    return emailError == null && passwordError == null && confirmError == null;
  }

  void submit() {
    FocusScope.of(context).unfocus();

    if (!validate()) return;

    setState(() {
      emailError = null;
      passwordError = null;
      confirmError = null;
    });

    // TODO: auth logic
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(title: isRegistering ? "Register" : "Login"),
      body: Stack(
        children: [
          WaveWidget(size: size, yOffset: size.height * 0.8),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 160),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 600),
                            alignment: Alignment.topCenter,
                            curve: Curves.easeInOut,
                            child: Focus(
                              onKeyEvent: (node, event) {
                                if (event is! KeyDownEvent) {
                                  return KeyEventResult.ignored;
                                }

                                if (event.logicalKey ==
                                    LogicalKeyboardKey.arrowDown) {
                                  FocusScope.of(context).nextFocus();
                                  return KeyEventResult.handled;
                                }

                                if (event.logicalKey ==
                                    LogicalKeyboardKey.arrowUp) {
                                  FocusScope.of(context).previousFocus();
                                  return KeyEventResult.handled;
                                }

                                return KeyEventResult.ignored;
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppPaddingsHeight().medium(),
                                  Text(
                                    isRegistering
                                        ? "Create Account"
                                        : "Welcome Back",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall,
                                  ),

                                  AppPaddingsHeight().small(),

                                  Text(
                                    isRegistering
                                        ? "Sign up to continue"
                                        : "Login to your account",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  AppPaddingsHeight().medium(),
                                  AnimatedSwitch(
                                    value: isRegistering,
                                    onChanged: (value) {
                                      setState(() {
                                        isRegistering = value;
                                      });
                                    },
                                    leftText: "Login",
                                    rightText: "Register",
                                  ),

                                  AppPaddingsHeight().medium(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const FaIcon(
                                          FontAwesomeIcons.google,
                                          size: 18,
                                        ),
                                        label: const Text(
                                          "Continue with Google",
                                        ),
                                      ),
                                      AppPaddingsWidth().medium(),
                                      ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const FaIcon(
                                          FontAwesomeIcons.github,
                                          size: 18,
                                        ),
                                        label: const Text(
                                          "Continue with GitHub",
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppPaddingsHeight().medium(),
                                  AuthInput(
                                    label: "Email",
                                    hint: "Enter your email",
                                    controller: _emailController,
                                    focusNode: _emailFocus,
                                    textInputAction: TextInputAction.next,
                                    errorText: emailError,
                                    onSubmitted: (_) => FocusScope.of(
                                      context,
                                    ).requestFocus(_passwordFocus),
                                  ),
                                  AppPaddingsHeight().small(),
                                  AuthInput(
                                    label: "Password",
                                    hint: "Enter your password",
                                    controller: _passwordController,
                                    isPassword: true,
                                    focusNode: _passwordFocus,
                                    textInputAction: isRegistering
                                        ? TextInputAction.next
                                        : TextInputAction.done,
                                    errorText: passwordError,
                                    onSubmitted: (_) => {
                                      if (isRegistering)
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(_confirmPasswordFocus)
                                      else
                                        submit(),
                                    },
                                  ),
                                  AppPaddingsHeight().small(),
                                  if (isRegistering)
                                    AuthInput(
                                      label: "Confirm Password",
                                      hint: "Repeat password",
                                      controller: _confirmPasswordController,
                                      isPassword: true,
                                      focusNode: _confirmPasswordFocus,
                                      textInputAction: TextInputAction.done,
                                      errorText: confirmError,
                                      onSubmitted: (_) => submit(),
                                    ),
                                  if (isRegistering)
                                    AppPaddingsHeight().medium(),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: submit,
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        elevation: 5,
                                      ),
                                      child: Text(
                                        isRegistering
                                            ? "Create Account"
                                            : "Login",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  AppPaddingsHeight().small(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
