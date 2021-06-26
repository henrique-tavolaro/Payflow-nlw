import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nwl/shared/theme/app_colors.dart';
import 'package:nwl/shared/theme/app_text_style.dart';
import 'package:nwl/shared/widgets/divider/divider_vertical.dart';
import 'package:nwl/shared/widgets/label_button/label_button.dart';

class SetLabelButtons extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback primaryOnPressed;
  final String secondLabel;
  final VoidCallback secondOnPressed;
  final bool enablePrimaryColor;
  final bool enableSecondaryColor;

  const SetLabelButtons({Key? key,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secondLabel,
    required this.secondOnPressed,
    this.enablePrimaryColor = false,
    this.enableSecondaryColor = false,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      height: 57,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.stroke
          ),
          Container(
            height: 56,
            child: Row(
              children: [
                Expanded(
                  child: LabelButton(
                    label: primaryLabel,
                    onPressed: primaryOnPressed,
                    style: enablePrimaryColor ? TextStyles.buttonPrimary : null,
                  ),
                ),
                DividerVertical(),
                Expanded(
                  child: LabelButton(
                    label: secondLabel,
                    onPressed: secondOnPressed,
                    style: enableSecondaryColor ? TextStyles.buttonPrimary : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
