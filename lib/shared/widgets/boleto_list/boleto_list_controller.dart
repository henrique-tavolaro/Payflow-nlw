
import 'package:flutter/material.dart';
import 'package:nwl/shared/database/dao.dart';
import 'package:nwl/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoletoListController {
  final boletosNotifier = ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);
  List<BoletoModel> get boletos => boletosNotifier.value;
  set boletos(List<BoletoModel> value) => boletosNotifier.value = value;
  final BoletoDao dao = BoletoDao();

  BoletoListController(){
    getBoletos();
  }

  Future<void> getBoletos() async {
    try {
      boletos = await dao.getBoletos();
    } catch (e){
      boletos = [];
    }
  }

  Future<void> deletarBoleto(String id) async {
    dao.deleteBoleto(id);
    boletos = await dao.getBoletos();
    boletosNotifier.value = boletos;
    boletosNotifier.notifyListeners();
    return;
  }

}
