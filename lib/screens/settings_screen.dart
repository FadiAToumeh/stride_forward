import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stride_forward/constants/app_theme.dart';
import 'package:stride_forward/providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05,
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: MediaQuery.sizeOf(context).height * 0.03,
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.025),
                Row(
                  spacing: 20,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text('Settings', style: AppTypography.headlineSmall),
                  ],
                ),

                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                _buildDarkModeTile(
                  context: context,
                  isDarkMode: settings.isDarkMode,
                  onTap: () =>
                      ref.read(settingsProvider.notifier).toggleDarkMode(),
                ),
                _buildSettingsTile(
                  context: context,
                  title: 'Change Username',
                  subTitle: settings.username,
                  icon: Icons.person,
                  onTap: () {
                    final controller = TextEditingController(
                      text: settings.username,
                    );
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return Dialog(
                          alignment: Alignment.center,
                          child: _buildDialog(
                            context: ctx,
                            title: 'New Username',
                            label: 'Enter your name',
                            controller: controller,
                            keyboardType: TextInputType.name,
                            onTap: () {
                              if (controller.text.trim().isNotEmpty) {
                                ref
                                    .read(settingsProvider.notifier)
                                    .setUsername(controller.text.trim());
                                Navigator.of(ctx).pop();
                              }
                            },
                          ),
                        );
                      },
                    );
                  },
                ),

                _buildSettingsTile(
                  context: context,
                  title: 'Change your daily goal',
                  subTitle: '${settings.goal} steps',
                  icon: Icons.rocket_launch_rounded,
                  onTap: () {
                    final controller = TextEditingController(
                      text: settings.goal.toString(),
                    );
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return Dialog(
                          alignment: Alignment.center,
                          child: _buildDialog(
                            context: ctx,
                            title: 'New Goal',
                            label: 'Enter daily step goal',
                            controller: controller,
                            keyboardType: TextInputType.number,
                            onTap: () {
                              final goal = int.tryParse(controller.text);
                              if (goal != null && goal > 0) {
                                ref
                                    .read(settingsProvider.notifier)
                                    .setGoal(goal);
                                Navigator.of(ctx).pop();
                              }
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                Center(
                  child: Text(
                    'Made by fadifadi992\nall rights reserved for 992®',
                    textAlign: .center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDarkModeTile({
    required BuildContext context,
    required bool isDarkMode,
    required void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.1,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: context.adaptiveShadow, blurRadius: 0.5),
          ],
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isDarkMode ? 'Dark Mode' : 'Light Mode',
                    style: AppTypography.headlineSmall.copyWith(fontSize: 20),
                  ),
                  Text(
                    'Turn on / off dark mode',
                    style: AppTypography.labelSmall.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: AppColors.primary,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSettingsTile({
  required BuildContext context,
  required String title,
  required String subTitle,
  required IconData icon,
  required void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: MediaQuery.sizeOf(context).height * 0.1,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: context.adaptiveShadow, blurRadius: 0.5)],
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.headlineSmall.copyWith(fontSize: 20),
                ),
                Text(
                  subTitle,
                  style: AppTypography.labelSmall.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Icon(icon, color: AppColors.primary, size: 30),
          ],
        ),
      ),
    ),
  );
}

Widget _buildDialog({
  required BuildContext context,
  required String title,
  required String label,
  required Function() onTap,
  TextEditingController? controller,
  TextInputType? keyboardType,
}) {
  return Container(
    height: MediaQuery.sizeOf(context).height * 0.3,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      boxShadow: [BoxShadow(color: context.adaptiveShadow)],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Text(title, style: AppTypography.headlineSmall),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              labelText: label,
            ),
          ),
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: context.adaptiveInvert),
                ),
              ),
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
