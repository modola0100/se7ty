import 'package:flutter/material.dart';
import 'package:se7ety/components/doctorcard/doctorcard.dart';
import 'package:se7ety/core/routes/navigator.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/patient/home/data/specialization.dart';

class SpecializationDocrorScreen extends StatelessWidget {
  const SpecializationDocrorScreen({super.key, required this.model});
  final SpecializationCardModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.wightColor),
        ),
        title: Text(model.name, style: TextStyles.semiBoldStyle.copyWith(color: AppColors.wightColor, fontSize: 25)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [Doctorcard()]),
        ),
      ),
    );
  }
}
