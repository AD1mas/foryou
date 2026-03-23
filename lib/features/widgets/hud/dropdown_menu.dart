import 'package:flutter/material.dart';
import 'package:foryou/core/app_style.dart';
import 'package:provider/provider.dart';
import '../../../providers/theme_provider.dart';
import '../switches/fancy_switch.dart';

class AnimatedMenu extends StatefulWidget {
  const AnimatedMenu({super.key});

  @override
  State<AnimatedMenu> createState() => _AnimatedMenuState();
}

class _AnimatedMenuState extends State<AnimatedMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  OverlayEntry? _overlayEntry;
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void toggleMenu() {
    if (isOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _controller.reverse();
    } else {
      _overlayEntry = _createOverlay();
      Overlay.of(context).insert(_overlayEntry!);
      _controller.forward();
    }
    setState(() => isOpen = !isOpen);
  }

  Widget _menuButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OverlayEntry _createOverlay() {
    final themeProvider = context.read<ThemeProvider>();

    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: toggleMenu,
                child: Container(color: AppColors.darkGreyColor.withAlpha(30)),
              ),
            ),

            Positioned(
              top: 60,
              right: 12,
              child: Material(
                color: AppColors.transparentColor,
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _controller,
                    curve: Curves.easeOut,
                  ),
                  child: ScaleTransition(
                    scale: CurvedAnimation(
                      parent: _controller,
                      curve: Curves.easeOutCubic,
                    ),
                    alignment: Alignment.topRight,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 220,
                        maxWidth: 260,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: themeProvider.isDarkMode
                              ? AppColors.blackColor
                              : AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.darkGreyColor.withValues(
                                alpha: 0.2,
                              ),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _menuButton(
                              icon: Icons.login,
                              text: "Login",
                              onTap: () {
                                toggleMenu();
                                Navigator.pushNamed(context, '/auth');
                              },
                            ),

                            _menuButton(
                              icon: Icons.person_add,
                              text: "Register",
                              onTap: () {
                                toggleMenu();
                                Navigator.pushNamed(context, '/auth');
                              },
                            ),

                            const SizedBox(height: 10),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.darkGreyColor.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Dark mode",
                                      style: TextStyle(
                                        color: themeProvider.isDarkMode
                                            ? AppColors.whiteColor
                                            : AppColors.blackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: FancySwitch(
                                        value: themeProvider.isDarkMode,
                                        onChanged: (v) =>
                                            themeProvider.toggleTheme(v),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: const Icon(Icons.menu), onPressed: toggleMenu);
  }
}
