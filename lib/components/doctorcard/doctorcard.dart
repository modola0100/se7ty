import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/functions/dialog.dart';
import 'package:se7ety/core/routes/navigator.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/patient/home/presentation/cubit/patient_home_cubit.dart';
import 'package:se7ety/features/patient/home/presentation/cubit/patient_home_state.dart';

class Doctorcard extends StatefulWidget {
  const Doctorcard({super.key});

  @override
  State<Doctorcard> createState() => _DoctorcardState();
}

class _DoctorcardState extends State<Doctorcard> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientHomeCubit, PatientHomeState>(
      listener: (context, state) {
        if (state is PatientHomeLoadingState) {
          Future.microtask(() => showLoadingDialog(context));
        } else if (state is PatientHomeErrorState) {
          Future.microtask(() => showErrorDialog(context, 'حدث خطأ ما'));
        } else if (state is PatientHomeSuccesState) {
          if (Navigator.canPop(context)) {
            final currentRoute = ModalRoute.of(context);
            if (currentRoute?.isCurrent ?? false) return;
            pop(context);
          }
        }
      },
      builder: (context, state) {
        if (state is PatientHomeSuccesState) {
          final doctors = state.doctors;
          if (doctors.isEmpty) {
            return Column(
              children: [
                SvgPicture.asset(AppImages.searchSvg),
                Text("no_doctor".tr(), style: TextStyles.semiBoldStyle),
              ],
            );
          }
          return ListView.builder(
            key: const ValueKey("doctors_list"),
            clipBehavior: Clip.none,
            itemCount: doctors.length,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final doctor = doctors[index];

              return Container(
                key: ValueKey(doctor.uid ?? index),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: AppColors.inputColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(offset: const Offset(4, 4), blurRadius: 10, color: AppColors.darkColor.withValues(alpha: .1))],
                ),
                child: ListTile(
                  leading: CircleAvatar(radius: 30, backgroundColor: AppColors.wightColor, backgroundImage: NetworkImage(doctor.image ?? '')),
                  title: Text(doctor.name ?? '', style: TextStyles.semiBoldStyle.copyWith(color: AppColors.primaryColor)),
                  subtitle: Text(doctor.specialization ?? '', style: TextStyles.mediumStyle),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(doctor.rating.toString(), style: TextStyles.semiBoldStyle.copyWith(color: AppColors.primaryColor)),
                      Icon(Icons.star, color: Colors.amber),
                    ],
                  ),
                  onTap: () {
                    pushTo(context, Routes.doctorProfile, extra: doctor);
                  },
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
