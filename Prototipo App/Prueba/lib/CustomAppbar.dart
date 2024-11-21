import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isLoggedIn;
  final String? profileImageUrl;
  final VoidCallback onUserIconPressed;
  final VoidCallback onMenuPressed;

  CustomAppBar({
    required this.isLoggedIn,
    this.profileImageUrl,
    required this.onUserIconPressed,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("App Explora Calambeo - Ambalá"),
      actions: [
        isLoggedIn
            ? GestureDetector(
                onTap: onUserIconPressed,
                child: CircleAvatar(
                  backgroundImage: profileImageUrl != null
                      ? NetworkImage(profileImageUrl!)
                      : AssetImage("assets/default_profile.png")
                          as ImageProvider,
                ),
              )
            : IconButton(
                icon: Icon(Icons.login),
                onPressed: onUserIconPressed,
              ),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: onMenuPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
