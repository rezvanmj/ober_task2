import 'package:equatable/equatable.dart';
import 'package:task2/feature/map/data/model/address_model.dart';

abstract class SearchAddressStatus extends Equatable {}

class SearchAddressSuccess extends SearchAddressStatus {
  final List<AddressModel>? searchedAddresses;
  final AddressModel? selectedAddress;
  final String? searchQuery;

  SearchAddressSuccess({
    this.searchedAddresses,
    this.selectedAddress,
    this.searchQuery,
  });
  @override
  List<Object?> get props => [
    searchedAddresses,
    searchedAddresses,
    searchQuery,
  ];
}

class SearchAddressLoading extends SearchAddressStatus {
  @override
  List<Object?> get props => [];
}

class SearchAddressInit extends SearchAddressStatus {
  @override
  List<Object?> get props => [];
}

class SearchAddressFailed extends SearchAddressStatus {
  @override
  List<Object?> get props => [];
}
