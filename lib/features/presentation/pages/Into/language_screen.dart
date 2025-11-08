import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:taskmanagenet/core/constants/app_colors.dart';
import 'package:taskmanagenet/features/presentation/pages/auth/regester_screen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final List<Map<String, String>> languages = [
    {'name': 'English', 'flag': 'https://flagcdn.com/w80/gb.png'},
    {'name': 'French', 'flag': 'https://flagcdn.com/w80/fr.png'},
    {'name': 'Spanish', 'flag': 'https://flagcdn.com/w80/es.png'},
    {'name': 'German', 'flag': 'https://flagcdn.com/w80/de.png'},
    {'name': 'Arabic', 'flag': 'https://flagcdn.com/w80/sa.png'},
    {'name': 'Chinese', 'flag': 'https://flagcdn.com/w80/cn.png'},
    {'name': 'Japanese', 'flag': 'https://flagcdn.com/w80/jp.png'},
    {'name': 'Russian', 'flag': 'https://flagcdn.com/w80/ru.png'},
    {'name': 'Portuguese', 'flag': 'https://flagcdn.com/w80/pt.png'},
    {'name': 'Italian', 'flag': 'https://flagcdn.com/w80/it.png'},
  ];

  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary, // calm background
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              'Choose Your Language',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: languages.map((lang) {
                    final isSelected = selectedLanguage == lang['name'];
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.accent : AppColors.background,
                        border: Border.all(
                          color: isSelected ? AppColors.primary : Colors.grey[300]!,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          if (!isSelected)
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                        ],
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          setState(() {
                            selectedLanguage = lang['name'];
                          });
                        },
                        child: SizedBox(
                          width: 140,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(lang['flag']!, width: 60, height: 60),
                              const SizedBox(height: 10),
                              Text(
                                lang['name']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? AppColors.primary : AppColors.text,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            if (selectedLanguage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Navigate to next screen
                      /*ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Selected: $selectedLanguage')),
                      );*/
                      Get.offAll(UserInfoScreen());
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
