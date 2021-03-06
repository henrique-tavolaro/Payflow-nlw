import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:nwl/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:nwl/shared/theme/app_colors.dart';
import 'package:nwl/shared/theme/app_text_style.dart';
import 'package:nwl/shared/widgets/input_text/input_text_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nwl/shared/widgets/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;

  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();

  final moneyInputController = MoneyMaskedTextController(
    leftSymbol: "R\$",
    decimalSeparator: ',',
  );
  final dueDataInputTextController = MaskedTextController(mask: "00/00/0000");
  final barcodeInputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 93),
                child: Text(
                  'Preencha os dados do boleto',
                  style: TextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Form(
                key: controller.formKey,
                  child: Column(
                children: [
                  InputTextWidget(
                    label: "Nome do boleto",
                    validator: controller.validateName,
                    icon: Icons.description_outlined,
                    onChanged: (String value) {
                      controller.onChange(name: value);
                    },
                  ),
                  InputTextWidget(
                    validator: controller.validateVencimento,
                    controller: dueDataInputTextController,
                    label: "Vencimento",
                    icon: FontAwesomeIcons.timesCircle,
                    onChanged: (String value) {
                      controller.onChange(dueDate: value);
                    },
                  ),
                  InputTextWidget(
                    validator: (_) => controller
                        .validateValor(moneyInputController.numberValue),
                    controller: moneyInputController,
                    label: "Valor",
                    icon: FontAwesomeIcons.wallet,
                    onChanged: (String value) {
                      controller.onChange(value: moneyInputController.numberValue);
                    },
                  ),
                  InputTextWidget(
                    validator: controller.validateCodigo,
                    controller: barcodeInputTextController,
                    label: "C??digo",
                    icon: FontAwesomeIcons.barcode,
                    onChanged: (String value) {
                      controller.onChange(barcode: value);
                    },
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        enableSecondaryColor: true,
        primaryLabel: 'Cancelar',
        primaryOnPressed: () async {
          Navigator.pop(context);
        },
        secondLabel: 'Cadastrar',
        secondOnPressed: () async {
          await controller.cadastrarBoleto();
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  void initState() {
    if (widget.barcode != null) {
      barcodeInputTextController.text = widget.barcode!;
    } else {
      barcodeInputTextController.text = '';
    }
    super.initState();
  }
}
