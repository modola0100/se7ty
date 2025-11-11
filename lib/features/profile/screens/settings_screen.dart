import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/routes.dart';
import 'edit_profile_screen.dart';
import '../models/user_model.dart';
import '../services/firebase_profile_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildSettingsItem(
              context,
              title: 'إعدادات الحساب',
              icon: Icons.person,
              onTap: () async {
                print('Account Settings tapped');
                UserModel? user = await FirebaseProfileService().getUserData();
                if (user != null && context.mounted) {
                  context.push('/editProfile', extra: user);
                }
              },
            ),
            _buildSettingsItem(
              context,
              title: 'كلمة السر',
              icon: Icons.lock,
              onTap: () {
                print('Password tapped');
                // TODO: Navigate to change password screen
              },
            ),
            _buildSettingsItem(
              context,
              title: 'إعدادات الإشعارات',
              icon: Icons.notifications,
              onTap: () {
                print('Notification Settings tapped');
                // TODO: Navigate to notification settings screen
              },
            ),
            _buildSettingsItem(
              context,
              title: 'الخصوصية',
              icon: Icons.privacy_tip,
              onTap: () {
                print('Privacy tapped');
                // TODO: Navigate to privacy policy screen
              },
            ),
            _buildSettingsItem(
              context,
              title: 'المساعدة والدعم',
              icon: Icons.help,
              onTap: () {
                print('Help and Support tapped');
                // TODO: Navigate to help and support screen
              },
            ),
            _buildSettingsItem(
              context,
              title: 'دعوة صديق',
              icon: Icons.person_add,
              onTap: () {
                print('Invite Friend tapped');
                // TODO: Implement invite friend functionality
              },
            ),
            const Gap(50),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  print('Logout button pressed');
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    context.go(Routes.login);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'تسجيل خروج',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.primaryColor),
          title: Text(
            title,
            style: TextStyles.semiBoldStyle.copyWith(fontSize: 18),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
        Divider(color: Colors.grey[300]),
      ],
    );
  }
}
