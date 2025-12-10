import 'package:flutter/material.dart';

class Profiletab extends StatelessWidget {
  const Profiletab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
          children: [
            // ---- PROFILE CARD ----
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage("assets/images/user.png"),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Aimad Moustajil",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "aimad@example.com",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ---- MENU LIST ----
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  profileItem(Icons.person_rounded, "Edit Profile"),
                  profileItem(Icons.notifications_rounded, "Notifications"),
                  profileItem(Icons.language_rounded, "Language"),
                  profileItem(Icons.lock_rounded, "Change Password"),
                  profileItem(Icons.help_outline_rounded, "Help & Support"),
                  profileItem(Icons.privacy_tip_outlined, "Privacy Policy"),
                  profileItem(Icons.logout_rounded, "Logout",
                      color: Colors.red),
                ],
              ),
            ),
          ],
        ),
      );
  }

  Widget profileItem(IconData icon, String title, {Color color = Colors.black}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: color, size: 26),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
