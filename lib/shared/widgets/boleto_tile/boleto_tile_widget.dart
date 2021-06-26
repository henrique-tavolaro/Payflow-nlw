import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nwl/shared/models/boleto_model.dart';
import 'package:nwl/shared/theme/app_colors.dart';
import 'package:nwl/shared/theme/app_text_style.dart';
import 'package:nwl/shared/widgets/dialog/dialog_button.dart';
import 'package:nwl/shared/widgets/dialog/DialogBottom.dart';

class BoletoTileWidget extends StatelessWidget {

  final BoletoModel data;
  const BoletoTileWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.right,
      child: GestureDetector(
        onTap: () {
          ShowBottomDialog(context, data);
        },
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            '${data.name}',
            style: TextStyles.titleListTile,
          ),
          subtitle: Text(
            'Vence em ${data.dueDate}',
            style: TextStyles.captionBody,
          ),
          trailing: Text.rich(
            TextSpan(
              text: "R\$ ",
              style: TextStyles.trailingRegular,
              children: [
                TextSpan(
                  text: "${data.value}",
                  style: TextStyles.trailingBold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void ShowBottomDialog(BuildContext context, BoletoModel data) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return DialogBottom(data: data);
    },
  );
}
