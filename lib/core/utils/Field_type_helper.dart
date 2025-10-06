import '../constants/app_enum.dart';

class FieldTypeHelper {
  static FieldType fromString(String type) {
    switch (type) {
      case 'text':
        return FieldType.text;
      case 'date':
        return FieldType.date;
      case 'radio':
        return FieldType.radio;
      case 'checkbox':
        return FieldType.checkbox;
      case 'dropdown':
        return FieldType.dropdown;
      default:
        throw Exception('Unknown field type: $type'); // error handling
    }
  }
}
