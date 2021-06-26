import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nwl/modules/extract/extract_page.dart';
import 'package:nwl/modules/meus_boletos/meus_boletos_page.dart';
import 'package:nwl/shared/database/dao.dart';
import 'package:nwl/shared/models/boleto_model.dart';
import 'package:nwl/shared/models/user_model.dart';
import 'package:nwl/shared/theme/app_colors.dart';
import 'package:nwl/shared/theme/app_text_style.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(TextSpan(
                  text: 'Olá, ',
                  style: TextStyles.titleRegular,
                  children: [
                    TextSpan(
                        text: '${widget.user.name}', style: TextStyles.titleBoldBackground)
                  ])),
              subtitle: Text(
                'Mantenha suas contas em dia',
                style: TextStyles.captionShape,
              ),
              trailing: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: NetworkImage(widget.user.photoURL!)
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ),
      body: [
        MeusBoletosPage(
          key: UniqueKey(),
        ),
        ExtractPage(
          key: UniqueKey(),
        )
      ][controller.currentPage],
      bottomNavigationBar: Container(
        height: 111,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.setPage(0);
                      setState(() {});
                    },
                    icon: Icon(Icons.home),
                    color: controller.currentPage == 0? AppColors.primary : AppColors.body,
                  ),
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, "/barcode_scanner");
                        setState(() {

                        });
                      },
                      icon: Icon(Icons.add_box_outlined),
                      color: AppColors.background,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.setPage(1);
                      setState(() {});
                    },
                    icon: Icon(Icons.description_outlined),
                    color: controller.currentPage == 1? AppColors.primary : AppColors.body,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 5,
                width: 135,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.bottom
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<HomeController>('homeController', controller));
  }
}
