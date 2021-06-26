import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nwl/modules/home/home_controller.dart';
import 'package:nwl/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:nwl/shared/models/boleto_model.dart';
import 'package:nwl/shared/theme/app_colors.dart';
import 'package:nwl/shared/theme/app_text_style.dart';
import 'package:nwl/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:nwl/shared/widgets/dialog/dialog_button.dart';

class DialogBottom extends StatefulWidget {
  final BoletoModel data;


  const DialogBottom({Key? key, required this.data, }) : super(key: key);

  @override
  _DialogBottomState createState() => _DialogBottomState();
}

class _DialogBottomState extends State<DialogBottom> {
  final controller = InsertBoletoController();
  final boletosNotifier = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      height: 293,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  height: 2,
                  width: 43,
                  color: AppColors.input,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 78, left: 78, top: 24),
                child: Text.rich(
                  TextSpan(
                    text: 'O boleto ',
                    style: TextStyles.titleDialog,
                    children: [
                      TextSpan(
                        text: '${widget.data.name} ',
                        style: TextStyles.titleBoldHeading,
                        children: [
                          TextSpan(
                            text: 'no valor de R\$ ',
                            style: TextStyles.titleDialog,
                            children: [
                              TextSpan(
                                text: '${widget.data.value} ',
                                style: TextStyles.titleBoldHeading,
                                children: [
                                  TextSpan(
                                    text: 'foi pago?',
                                    style: TextStyles.titleDialog,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DialogButton(
                      text: 'Ainda não',
                      style: TextStyles.buttonGray,
                      color: AppColors.shape,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    DialogButton(
                      text: 'Sim',
                      style: TextStyles.buttonBackground,
                      color: AppColors.primary,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: Divider(
                  thickness: 1,
                  height: 1,
                  color: AppColors.stroke,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showMyDialog(widget.data.name!);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 17.5),
                        child: Icon(
                          FontAwesomeIcons.trashAlt,
                          size: 15,
                        ),
                      ),
                      Text(
                        'Deletar boleto',
                        style: TextStyles.buttonDelete,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 6),
                child: Container(
                  height: 5,
                  width: 135,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.bottom),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog(String name) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir boleto $name?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirmar'),
              onPressed: () async {
                await boletosNotifier.deletarBoleto(widget.data.id).then((value) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }
}
