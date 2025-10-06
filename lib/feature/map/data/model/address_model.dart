class AddressModel {
  AddressModel({
    num? placeId,
    String? licence,
    String? osmType,
    num? osmId,
    List<String>? boundingbox,
    String? lat,
    String? lon,
    String? displayName,
    String? type,
    num? importance,
    Address? address,
  }) {
    _placeId = placeId;
    _licence = licence;
    _osmType = osmType;
    _osmId = osmId;
    _boundingbox = boundingbox;
    _lat = lat;
    _lon = lon;
    _displayName = displayName;
    _type = type;
    _importance = importance;
    _address = address;
  }

  AddressModel.fromJson(dynamic json) {
    _placeId = json['place_id'];
    _licence = json['licence'];
    _osmType = json['osm_type'];
    _osmId = json['osm_id'];
    _boundingbox = json['boundingbox'] != null
        ? json['boundingbox'].cast<String>()
        : [];
    _lat = json['lat'];
    _lon = json['lon'];
    _displayName = json['display_name'];
    _type = json['type'];
    _importance = json['importance'];
    _address = json['address'] != null
        ? Address.fromJson(json['address'])
        : null;
  }
  num? _placeId;
  String? _licence;
  String? _osmType;
  num? _osmId;
  List<String>? _boundingbox;
  String? _lat;
  String? _lon;
  String? _displayName;
  String? _type;
  num? _importance;
  Address? _address;
  AddressModel copyWith({
    num? placeId,
    String? licence,
    String? osmType,
    num? osmId,
    List<String>? boundingbox,
    String? lat,
    String? lon,
    String? displayName,
    String? type,
    num? importance,
    Address? address,
  }) => AddressModel(
    placeId: placeId ?? _placeId,
    licence: licence ?? _licence,
    osmType: osmType ?? _osmType,
    osmId: osmId ?? _osmId,
    boundingbox: boundingbox ?? _boundingbox,
    lat: lat ?? _lat,
    lon: lon ?? _lon,
    displayName: displayName ?? _displayName,
    type: type ?? _type,
    importance: importance ?? _importance,
    address: address ?? _address,
  );
  num? get placeId => _placeId;
  String? get licence => _licence;
  String? get osmType => _osmType;
  num? get osmId => _osmId;
  List<String>? get boundingbox => _boundingbox;
  String? get lat => _lat;
  String? get lon => _lon;
  String? get displayName => _displayName;
  String? get type => _type;
  num? get importance => _importance;
  Address? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['place_id'] = _placeId;
    map['licence'] = _licence;
    map['osm_type'] = _osmType;
    map['osm_id'] = _osmId;
    map['boundingbox'] = _boundingbox;
    map['lat'] = _lat;
    map['lon'] = _lon;
    map['display_name'] = _displayName;
    map['type'] = _type;
    map['importance'] = _importance;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    return map;
  }
}

/// city : "Berlin"
/// state : "Berlin"
/// country : "Germany"
/// country_code : "de"

class Address {
  Address({String? city, String? state, String? country, String? countryCode}) {
    _city = city;
    _state = state;
    _country = country;
    _countryCode = countryCode;
  }

  Address.fromJson(dynamic json) {
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
    _countryCode = json['country_code'];
  }
  String? _city;
  String? _state;
  String? _country;
  String? _countryCode;
  Address copyWith({
    String? city,
    String? state,
    String? country,
    String? countryCode,
  }) => Address(
    city: city ?? _city,
    state: state ?? _state,
    country: country ?? _country,
    countryCode: countryCode ?? _countryCode,
  );
  String? get city => _city;
  String? get state => _state;
  String? get country => _country;
  String? get countryCode => _countryCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    map['country_code'] = _countryCode;
    return map;
  }
}
