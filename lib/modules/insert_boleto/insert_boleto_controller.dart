import 'package:flutter/cupertino.dart';
import 'package:nwl/shared/database/dao.dart';
import 'package:nwl/shared/database/database.dart';
import 'package:nwl/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


class InsertBoletoController {
  var uuid = Uuid();

  final formKey = GlobalKey<FormState>();
  BoletoModel model = BoletoModel(id: '0');
  final BoletoDao dao = BoletoDao();

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;
  String? validateVencimento(String? value) =>
      value?.isEmpty ?? true ? "A data de vencimento não pode ser vazio" : null;
  String? validateValor(double value) =>
      value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  String? validateCodigo(String? value) =>
      value?.isEmpty ?? true ? "O código do boleto não pode ser vazio" : null;

  void onChange({
    String? name,
    String? dueDate,
    double? value,
    String? barcode,
  }) {
    String id = uuid.v1();
    model = model.copyWith(
      id: id,
      name: name,
      dueDate: dueDate,
      value: value,
      barcode: barcode,
    );
  }

  Future<void> saveBoletos() async {
    await dao.insertFavorite(model);
  }

  Future<void> saveBoleto() async {
    final instance = await SharedPreferences.getInstance();
    final boletos = instance.getStringList("boletos") ?? <String>[];
    boletos.add(model.toJson());
    await instance.setStringList("boletos", boletos);
    return;
  }

  Future<void> cadastrarBoleto() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      return await saveBoletos();
    }
  }


}
