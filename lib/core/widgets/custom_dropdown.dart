// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
//
// import '../constants/app_colors.dart';
// import '../constants/app_dimensions.dart';
//
// class CustomDropDown extends StatelessWidget {
//   final List<String> items;
//   final String? hintText;
//   final PopupProps<String>? popupProps;
//   final Function(String value) onChange;
//   final bool? showSearchBox;
//
//   final bool enabled;
//   final String? label;
//   final String? value;
//   final bool? isRequired;
//   final bool? isDisable;
//
//   const CustomDropDown({
//     super.key,
//     required this.items,
//     required this.onChange,
//     this.hintText,
//     this.isDisable,
//     this.label,
//     this.isRequired,
//     this.value,
//     this.popupProps,
//
//     this.showSearchBox,
//
//     this.enabled = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return IgnorePointer(
//       ignoring: isDisable ?? false,
//       child: DropdownSearch<String>(
//         items: (filter, loadProps) {
//           final filtered = filter.isEmpty
//               ? items
//               : items.where((String e) {
//                   String? title = e;
//                   return title.toLowerCase().contains(filter.toLowerCase());
//                 }).toList();
//
//           return filtered;
//         },
//         compareFn: (item, selectedItem) => item == selectedItem,
//
//         selectedItem: value,
//         enabled: enabled,
//         itemAsString: (item) => item.toString(),
//         onChanged: (value) {
//           if (value != null) {
//             onChange(value);
//           }
//         },
//         decoratorProps: DropDownDecoratorProps(
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Theme.of(context).colorScheme.tertiary,
//
//             contentPadding: const EdgeInsets.symmetric(
//               vertical: 16,
//               horizontal: 12,
//             ),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(width: 6, color: AppColors.shadowColor),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(AppDimensions.buttonRadius),
//               ),
//             ),
//
//             labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
//               color: Theme.of(context).colorScheme.onSurface,
//             ),
//             hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
//               color: Theme.of(context).colorScheme.onSurface,
//             ),
//             alignLabelWithHint: true,
//             hintText: label == null ? 'Select' : label.toString(),
//           ),
//         ),
//
//         popupProps:
//             popupProps ??
//             PopupProps.menu(
//               searchFieldProps: TextFieldProps(
//                 padding: const EdgeInsets.all(5),
//                 decoration: InputDecoration(
//                   hintText: 'Search',
//                   hintStyle: Theme.of(context).textTheme.bodySmall,
//                 ),
//               ),
//               showSearchBox: showSearchBox ?? true,
//               fit: FlexFit.tight,
//
//               itemBuilder: (context, item, isSelected, val) {
//                 return Container(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 12,
//                     horizontal: 16,
//                   ),
//                   decoration: BoxDecoration(
//                     color: isSelected
//                         ? Theme.of(context).colorScheme.tertiary
//                         : Colors.transparent,
//                   ),
//                   child: Text(
//                     item,
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                 );
//               },
//               menuProps: MenuProps(
//                 backgroundColor: Theme.of(context).colorScheme.onPrimary,
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(AppDimensions.buttonRadius),
//                 ),
//               ),
//               listViewProps: const ListViewProps(clipBehavior: Clip.antiAlias),
//             ),
//       ),
//     );
//   }
// }
