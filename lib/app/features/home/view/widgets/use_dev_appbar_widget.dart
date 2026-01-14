import 'package:flutter/material.dart';

class UseDevAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const UseDevAppBar({super.key}) : preferredSize = const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0.0,
      leading: IconButton(
        icon: const Icon(Icons.menu, size: 50),
        onPressed: () {},
      ),
      title: Row(
        children: [
          const Spacer(flex: 3),
          Image.asset(
            'assets/logo/logo_usedev.png',
            height: 40,
          ),
          const Spacer(),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.person_2_outlined,
            size: 50,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.shopping_cart_outlined,
            size: 50,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
