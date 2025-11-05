import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/doctorcard/doctorcard.dart';
import 'package:se7ety/core/routes/navigator.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/patient/home/presentation/cubit/patient_home_cubit.dart';

class DoctorSearchScreen extends StatelessWidget {
  const DoctorSearchScreen({super.key, required this.searchKey});

  final String searchKey;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PatientHomeCubit()..searchDoctor(searchKey),

      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new, color: AppColors.wightColor),
          ),
          title: Text("search_doctor".tr(), style: TextStyles.semiBoldStyle.copyWith(color: AppColors.wightColor, fontSize: 25)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(child: Column(children: [Gap(30), Doctorcard()])),
        ),
      ),
    );
  }
}
