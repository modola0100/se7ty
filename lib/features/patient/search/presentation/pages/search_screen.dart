import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/inputs/custome_text_form_field%20copy.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/routes/navigator.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/patient/search/presentation/cubit/patient_search_cubit.dart';
import 'package:se7ety/features/patient/search/presentation/cubit/patient_search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

String search = '';

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PatientSearchCubit()..searchDoctor(search),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("search_doctor".tr(), style: TextStyles.semiBoldStyle.copyWith(color: AppColors.wightColor, fontSize: 25)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomeTextFormField(
                      onChanged: (String searchKey) {
                        setState(() {
                          search = searchKey;
                          context.read<PatientSearchCubit>().searchDoctor(searchKey);
                        });
                      },
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (String value) {
                        context.read<PatientSearchCubit>().searchDoctor(value);
                      },
                      hintText: "search_doctor".tr(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            context.read<PatientSearchCubit>().searchDoctor(search);
                          });
                        },
                        icon: Icon(Icons.search, color: AppColors.primaryColor),
                      ),
                    ),
                    Gap(30),
                    BlocBuilder<PatientSearchCubit, PatientSearchState>(
                      builder: (BuildContext context, state) {
                        if (state is PatientSearchSuccesState) {
                          final doctors = state.doctors;
                          if (doctors.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImages.searchSvg, height: 420),
                                  Text("no_doctor".tr(), style: TextStyles.semiBoldStyle),
                                ],
                              ),
                            );
                          }
                          return ListView.builder(
                            clipBehavior: Clip.none,
                            itemCount: doctors.length,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final doctor = doctors[index];

                              return Container(
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
