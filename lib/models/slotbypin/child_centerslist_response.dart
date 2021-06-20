import 'package:equatable/equatable.dart';

import 'child_sessions_list_response.dart';

class ChildCentersListResponse extends Equatable
{
  final int center_id;
  final String name;
  final String address;
  final String stateName;
  final String districtName;
  final String blockName;
  final int pincode;
  final int lat;
  final int long;
  final String from;
  final String to;
  final String feesType;
  final List<ChildSessionsListResponse> sessions;

  ChildCentersListResponse(
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
        this.sessions
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
    feesType,
    sessions
  ];

  static ChildCentersListResponse fromJson(dynamic json)
  {
    return ChildCentersListResponse(
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
      sessions: (json['sessions'] != null) ? (json['sessions'] as List)
          .map((i) => ChildSessionsListResponse.fromJson(i))
          .toList() : null,

    );
  }
}
