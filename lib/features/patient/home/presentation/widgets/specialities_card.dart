import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/routes/navigator.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/patient/home/data/specialization.dart';

class SpecialitiesCard extends StatelessWidget {
  const SpecialitiesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final model = cards[index];
          return GestureDetector(
            onTap: () {
              pushTo(context, Routes.specializationDoctor, extra: cards[index]);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 15, bottom: 15, top: 10),
              width: 190,
              decoration: BoxDecoration(
                color: model.cardBackground,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(offset: const Offset(4, 4), blurRadius: 10, color: model.cardLightColor.withValues(alpha: .8))],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(top: -20, right: -20, child: CircleAvatar(backgroundColor: AppColors.wightColor.withValues(alpha: 0.3), radius: 60)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset('assets/images/doctor-card.svg', width: 140),
                        const Gap(10),
                        Text(
                          model.name,
                          textAlign: TextAlign.center,
                          style: TextStyles.semiBoldStyle.copyWith(color: AppColors.wightColor, fontSize: 14),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: cards.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
