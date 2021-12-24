import 'dart:math';

class Address {
  final String? postcode;
  final String? name;
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? iso;

  Address(
      {this.postcode,
      this.street,
      this.city,
      this.name,
      this.state,
      this.country,
      this.iso});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        postcode: json["postcode"],
        name: json["name"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        iso: json["countrycode"],
      );

  @override
  String toString() {
    String addr = "";
    if (name != null && name!.isNotEmpty) {
      addr = addr + "$name,";
    }
    if (street != null && street!.isNotEmpty) {
      addr = addr + "$street,";
    }
    if (postcode != null && postcode!.isNotEmpty) {
      addr = addr + "$postcode,";
    }
    if (city != null && city!.isNotEmpty) {
      addr = addr + "$city,";
    }
    if (state != null && state!.isNotEmpty) {
      addr = addr + "$state,";
    }
    if (country != null && country!.isNotEmpty) {
      addr = addr + "$country";
    }

    return addr;
  }
}

class SearchInfo {
  final GeoPoint? point;
  final Address? address;

  SearchInfo({
    this.point,
    this.address,
  });

  SearchInfo.fromPhotonAPI(Map data)
      : point = GeoPoint(
            latitude: data["geometry"]["coordinates"][1],
            longitude: data["geometry"]["coordinates"][0]),
        address = Address.fromJson(data["properties"]);
}

///[GeoPoint]:class contain longitude and latitude of geographic position
/// [longitude] : (double)
/// [latitude] : (double)
class GeoPoint {
  final double longitude;
  final double latitude;

  GeoPoint({
    required this.latitude,
    required this.longitude,
  });

  GeoPoint.fromMap(Map m)
      : latitude = m["lat"],
        longitude = m["lon"];

  Map<String, double> toMap() {
    return {
      "lon": longitude,
      "lat": latitude,
    };
  }

  @override
  String toString() {
    return 'GeoPoint{latitude: $latitude , longitude: $longitude}';
  }
}

class GeoPointWithOrientation extends GeoPoint {
  final double angle;

  GeoPointWithOrientation({
    this.angle = 0.0,
    required double latitude,
    required double longitude,
  }) : super(
          latitude: latitude,
          longitude: longitude,
        );

  @override
  Map<String, double> toMap() {
    return super.toMap()
      ..putIfAbsent(
        "angle",
        () => angle * (180 / pi),
      );
  }
}
