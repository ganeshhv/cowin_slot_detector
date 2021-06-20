import 'package:equatable/equatable.dart';


class ChildSlotByLatLongResponse extends Equatable
{
  final int center_id;
  final String name;
  final String address;
  final String stateName;
  final String districtName;
  final String blockName;
  final int pincode;
  final double lat;
  final double long;
  final String from;
  final String to;
  final String feesType;

  ChildSlotByLatLongResponse(
      {
        this.center_id,
        this.name,
        this.address,
        this.stateName,
        this.districtName,
        this.blockName,
        this.pincode,
        this.lat,
        this.long,
        this.from,
        this.to,
        this.feesType,
      });

  @override
  // TODO: implement props
  List<Object> get props => [
    center_id,
    name,
    address,
    stateName,
    districtName,
    blockName,
    pincode,
    lat,
    long,
    from,
    to,
    feesType
  ];

  static ChildSlotByLatLongResponse fromJson(dynamic json)
  {
    return ChildSlotByLatLongResponse(
      center_id: json['center_id'] == null ? 0 : json['center_id'],
      name: json['name'] == null ? '' : json['name'],
      address: json['address'] == null ? '' : json['address'],
      stateName: json['state_name'] == null ? '' : json['state_name'],
      districtName: json['district_name'] == null ? '' : json['district_name'],
      blockName: json['nablock_nameme'] == null ? '' : json['block_name'],
      pincode: json['pincode'] == null ? 0 : json['pincode'],
      lat: json['lat'] == null ? 0.0 : json['lat'],
      long: json['long'] == null ? 0.0 : json['long'],
      from: json['from'] == null ? '' : json['from'],
      to: json['to'] == null ? '' : json['to'],
      feesType: json['fee_type'] == null ? '' : json['fee_type'],

    );
  }
}
