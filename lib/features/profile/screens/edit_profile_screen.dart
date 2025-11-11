import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../models/user_model.dart';
import '../services/firebase_profile_service.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _cityController;
  late TextEditingController _bioController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _phoneController = TextEditingController(text: widget.user.phone);
    _cityController = TextEditingController(text: widget.user.city);
    _bioController = TextEditingController(text: widget.user.bio);
    _ageController = TextEditingController(
      text: widget.user.age?.toString() ?? '',
    ); // Assuming age is part of UserModel
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _bioController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final updatedUser = UserModel(
        uid: widget.user.uid,
        name: _nameController.text,
        email: widget.user.email,
        phone: _phoneController.text,
        city: _cityController.text,
        bio: _bioController.text,
        image: widget.user.image,
        // age: int.tryParse(_ageController.text), // Assuming age is part of UserModel
      );

      await FirebaseProfileService().updateUserData(updatedUser);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تعديل الحساب'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'الاسم',
                hint: 'ادخل الاسم',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الاسم';
                  }
                  return null;
                },
              ),
              const Gap(20),
              _buildTextField(
                controller: _phoneController,
                label: 'رقم الهاتف',
                hint: 'ادخل رقم الهاتف',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال رقم الهاتف';
                  }
                  return null;
                },
              ),
              const Gap(20),
              _buildTextField(
                controller: _cityController,
                label: 'المدينة',
                hint: 'ادخل المدينة',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال المدينة';
                  }
                  return null;
                },
              ),
              const Gap(20),
              _buildTextField(
                controller: _bioController,
                label: 'نبذة تعريفية',
                hint: 'ادخل نبذة تعريفية',
                maxLines: 3,
              ),
              const Gap(20),
              _buildTextField(
                controller: _ageController,
                label: 'العمر',
                hint: 'ادخل العمر',
                keyboardType: TextInputType.number,
              ),
              const Gap(30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'حفظ التعديل',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.semiBoldStyle.copyWith(fontSize: 16)),
        const Gap(8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
