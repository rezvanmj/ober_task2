class RoutePathModel {
  RoutePathModel({
    String? code,
    List<Routes>? routes,
    List<Waypoints>? waypoints,
  }) {
    _code = code;
    _routes = routes;
    _waypoints = waypoints;
  }

  RoutePathModel.fromJson(dynamic json) {
    _code = json['code'];
    if (json['routes'] != null) {
      _routes = [];
      json['routes'].forEach((v) {
        _routes?.add(Routes.fromJson(v));
      });
    }
    if (json['waypoints'] != null) {
      _waypoints = [];
      json['waypoints'].forEach((v) {
        _waypoints?.add(Waypoints.fromJson(v));
      });
    }
  }
  String? _code;
  List<Routes>? _routes;
  List<Waypoints>? _waypoints;
  RoutePathModel copyWith({
    String? code,
    List<Routes>? routes,
    List<Waypoints>? waypoints,
  }) => RoutePathModel(
    code: code ?? _code,
    routes: routes ?? _routes,
    waypoints: waypoints ?? _waypoints,
  );
  String? get code => _code;
  List<Routes>? get routes => _routes;
  List<Waypoints>? get waypoints => _waypoints;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    if (_routes != null) {
      map['routes'] = _routes?.map((v) => v.toJson()).toList();
    }
    if (_waypoints != null) {
      map['waypoints'] = _waypoints?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// hint : "..."
/// name : "Street A"
/// location : [13.38886,52.51704]

class Waypoints {
  Waypoints({String? hint, String? name, List<num>? location}) {
    _hint = hint;
    _name = name;
    _location = location;
  }

  Waypoints.fromJson(dynamic json) {
    _hint = json['hint'];
    _name = json['name'];
    _location = json['location'] != null ? json['location'].cast<num>() : [];
  }
  String? _hint;
  String? _name;
  List<num>? _location;
  Waypoints copyWith({String? hint, String? name, List<num>? location}) =>
      Waypoints(
        hint: hint ?? _hint,
        name: name ?? _name,
        location: location ?? _location,
      );
  String? get hint => _hint;
  String? get name => _name;
  List<num>? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hint'] = _hint;
    map['name'] = _name;
    map['location'] = _location;
    return map;
  }
}

/// geometry : {"coordinates":[[13.38886,52.51704],[13.39763,52.52941],[13.42855,52.52322]],"type":"LineString"}
/// legs : [{"steps":[],"distance":1884.2,"duration":300.5,"summary":""}]
/// distance : 1884.2
/// duration : 300.5
/// weight : 300.5
/// weight_name : "routability"

class Routes {
  Routes({
    Geometry? geometry,
    List<Legs>? legs,
    num? distance,
    num? duration,
    num? weight,
    String? weightName,
  }) {
    _geometry = geometry;
    _legs = legs;
    _distance = distance;
    _duration = duration;
    _weight = weight;
    _weightName = weightName;
  }

  Routes.fromJson(dynamic json) {
    _geometry = json['geometry'] != null
        ? Geometry.fromJson(json['geometry'])
        : null;
    if (json['legs'] != null) {
      _legs = [];
      json['legs'].forEach((v) {
        _legs?.add(Legs.fromJson(v));
      });
    }
    _distance = json['distance'];
    _duration = json['duration'];
    _weight = json['weight'];
    _weightName = json['weight_name'];
  }
  Geometry? _geometry;
  List<Legs>? _legs;
  num? _distance;
  num? _duration;
  num? _weight;
  String? _weightName;
  Routes copyWith({
    Geometry? geometry,
    List<Legs>? legs,
    num? distance,
    num? duration,
    num? weight,
    String? weightName,
  }) => Routes(
    geometry: geometry ?? _geometry,
    legs: legs ?? _legs,
    distance: distance ?? _distance,
    duration: duration ?? _duration,
    weight: weight ?? _weight,
    weightName: weightName ?? _weightName,
  );
  Geometry? get geometry => _geometry;
  List<Legs>? get legs => _legs;
  num? get distance => _distance;
  num? get duration => _duration;
  num? get weight => _weight;
  String? get weightName => _weightName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_geometry != null) {
      map['geometry'] = _geometry?.toJson();
    }
    if (_legs != null) {
      map['legs'] = _legs?.map((v) => v.toJson()).toList();
    }
    map['distance'] = _distance;
    map['duration'] = _duration;
    map['weight'] = _weight;
    map['weight_name'] = _weightName;
    return map;
  }
}

/// steps : []
/// distance : 1884.2
/// duration : 300.5
/// summary : ""

class Legs {
  Legs({List<dynamic>? steps, num? distance, num? duration, String? summary}) {
    _steps = steps;
    _distance = distance;
    _duration = duration;
    _summary = summary;
  }

  Legs.fromJson(dynamic json) {
    // if (json['steps'] != null) {
    //   _steps = [];
    //   json['steps'].forEach((v) {
    //     _steps?.add(Dynamic.fromJson(v));
    //   });
    // }
    _distance = json['distance'];
    _duration = json['duration'];
    _summary = json['summary'];
  }
  List<dynamic>? _steps;
  num? _distance;
  num? _duration;
  String? _summary;
  Legs copyWith({
    List<dynamic>? steps,
    num? distance,
    num? duration,
    String? summary,
  }) => Legs(
    steps: steps ?? _steps,
    distance: distance ?? _distance,
    duration: duration ?? _duration,
    summary: summary ?? _summary,
  );
  List<dynamic>? get steps => _steps;
  num? get distance => _distance;
  num? get duration => _duration;
  String? get summary => _summary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_steps != null) {
      map['steps'] = _steps?.map((v) => v.toJson()).toList();
    }
    map['distance'] = _distance;
    map['duration'] = _duration;
    map['summary'] = _summary;
    return map;
  }
}

/// coordinates : [[13.38886,52.51704],[13.39763,52.52941],[13.42855,52.52322]]
/// type : "LineString"

class Geometry {
  Geometry({List<List<num>>? coordinates, String? type}) {
    _coordinates = coordinates;
    _type = type;
  }

  Geometry.fromJson(dynamic json) {
    if (json['coordinates'] != null) {
      _coordinates = (json['coordinates'] as List)
          .map((e) => (e as List).map((v) => v as num).toList())
          .toList();
    } else {
      _coordinates = [];
    }
    _type = json['type'];
  }
  List<List<num>>? _coordinates;
  String? _type;
  Geometry copyWith({List<List<num>>? coordinates, String? type}) =>
      Geometry(coordinates: coordinates ?? _coordinates, type: type ?? _type);
  List<List<num>>? get coordinates => _coordinates;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinates'] = _coordinates;
    map['type'] = _type;
    return map;
  }
}
