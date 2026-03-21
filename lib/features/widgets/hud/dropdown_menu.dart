import 'package:flutter/material.dart';

class AnimatedMenu extends StatefulWidget {
  const AnimatedMenu({super.key});

  @override
  State<AnimatedMenu> createState() => _AnimatedMenuState();
}

class _AnimatedMenuState extends State<AnimatedMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isOpen = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  void toggle() {
    setState(() {
      isOpen = !isOpen;
      isOpen ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(icon: const Icon(Icons.menu), onPressed: toggle),

        Positioned(
          top: 40,
          right: 0,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOutBack,
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: const [
                  Text("Profile"),
                  SizedBox(height: 8),
                  Text("Settings"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
