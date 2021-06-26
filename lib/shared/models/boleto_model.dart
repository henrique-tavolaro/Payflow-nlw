
  import 'dart:convert';

class BoletoModel {
    final String id;
    final String? name;
    final String? dueDate;
    final double? value;
    final String? barcode;

    BoletoModel({
      required this.id,
      this.name,
      this.dueDate,
      this.value,
      this.barcode,
    });

    BoletoModel copyWith({
      required String id,
      String? name,
      String? dueDate,
      double? value,
      String? barcode,
    }) {
      return BoletoModel(
        id: id,
        name: name ?? this.name,
        dueDate: dueDate ?? this.dueDate,
        value: value ?? this.value,
        barcode: barcode ?? this.barcode,
      );
    }

    Map<String, dynamic> toMap() {
      return {
        'id' : id,
        'name': name,
        'due_date': dueDate,
        'value': value,
        'barcode': barcode,
      };
    }

    factory BoletoModel.fromMap(Map<String, dynamic> map) {
      return BoletoModel(
        id: map['id'],
        name: map['name'],
        dueDate: map['due_date'],
        value: map['value'],
        barcode: map['barcode'],
      );
    }

    String toJson() => json.encode(toMap());

    factory BoletoModel.fromJson(String source) =>
        BoletoModel.fromMap(json.decode(source));

    @override
    String toString() {
      return 'BoletoModel(id: $id, name: $name, dueDate: $dueDate, value: $value, barcode: $barcode)';
    }

    @override
    bool operator ==(Object other) {
      if (identical(this, other)) return true;

      return other is BoletoModel &&
          other.id == id &&
          other.name == name &&
          other.dueDate == dueDate &&
          other.value == value &&
          other.barcode == barcode;
    }

    @override
    int get hashCode {
      return name.hashCode ^ dueDate.hashCode ^ value.hashCode ^ barcode
          .hashCode;
    }
  }
