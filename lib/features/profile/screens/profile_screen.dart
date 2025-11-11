import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../services/firebase_profile_service.dart';
import '../models/user_model.dart';
import 'package:go_router/go_router.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<UserModel?> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = FirebaseProfileService().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحساب الشخصي'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.push('/settings');
            },
            icon: const Icon(Icons.settings, color: AppColors.wightColor),
          ),
        ],
      ),
      body: FutureBuilder<UserModel?>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user data found.'));
          }

          final user = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: user.image != null && user.image!.isNotEmpty
                      ? NetworkImage(user.image!) as ImageProvider
                      : null,
                  child: user.image == null || user.image!.isEmpty
                      ? const Icon(Icons.person, size: 60, color: Colors.grey)
                      : null,
                ),
                const Gap(10),
                Text(
                  user.name,
                  style: TextStyles.semiBoldStyle.copyWith(fontSize: 22),
                ),
                const Gap(5),
                Text(
                  user.city,
                  style: TextStyles.regularStyle.copyWith(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const Gap(30),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('نبذه تعريفيه', style: TextStyles.semiBoldStyle),
                ),
                const Gap(10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    user.bio ?? 'لم تضاف',
                    style: TextStyles.regularStyle.copyWith(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const Gap(30),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'معلومات التواصل',
                    style: TextStyles.semiBoldStyle,
                  ),
                ),
                const Gap(10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.inputColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor,
                                border: Border.all(
                                  width: 4,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              child: Icon(
                                Icons.mail,
                                color: AppColors.wightColor,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              user.email,
                              style: TextStyles.regularStyle.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const Gap(30),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor,
                                border: Border.all(
                                  width: 4,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              child: Icon(
                                Icons.phone,
                                color: AppColors.wightColor,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              user.phone,
                              style: TextStyles.regularStyle.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(30),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('حجوزاتي', style: TextStyles.semiBoldStyle),
                ),
                const Gap(10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'لا يوجد حجوزات سابقة', // TODO: Replace with actual user appointments
                    style: TextStyles.regularStyle.copyWith(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
