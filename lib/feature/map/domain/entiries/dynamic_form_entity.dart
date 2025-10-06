import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_enum.dart';

class DynamicFormEntity extends Equatable {
  final String key;
  final FieldType type;
  final List<String>? options;

  const DynamicFormEntity({
    required this.key,
    required this.type,
    this.options,
  });

  @override
  List<Object?> get props => [key, type, options];
}
