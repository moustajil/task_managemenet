import 'package:flutter/material.dart';
import 'package:taskmanagenet/core/constants/app_colors.dart';
import 'screen_nav/HomeTab.dart';
import 'screen_nav/SearchTab.dart';
import 'screen_nav/FavoritesTab.dart';
import 'screen_nav/ProfileTab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  final String userName = "John Doe";
  final String userAvatar = "https://i.pravatar.cc/150?img=3";

   List<Widget> screens =  [
    HomeTab(),
    Searchtab(),
    Favoritestab(),
    Profiletab(),
  ];

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [
          // Top profile section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(userAvatar),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello,',
                      style: TextStyle(
                        color: AppColors.background,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userName,
                      style: TextStyle(
                        color: AppColors.background,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Screens content
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 0.1),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: screens[_currentIndex],
                  ),
                ),
                // Floating bottom navigation
                Positioned(
                  bottom: 20 + bottomPadding,
                  left: 40,
                  right: 40,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem(Icons.home_outlined, Icons.home, 0),
                        _buildNavItem(Icons.search_outlined, Icons.search, 1),
                        _buildNavItem(Icons.favorite_border, Icons.favorite, 2),
                        _buildNavItem(Icons.person_outline, Icons.person, 3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, IconData activeIcon, int index) {
    bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 1.0, end: isSelected ? 1.2 : 1.0),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: isSelected
                  ? BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    )
                  : null,
              child: Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? AppColors.primary : AppColors.text,
                size: 28,
              ),
            ),
          );
        },
      ),
    );
  }
}
