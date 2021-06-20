import 'package:equatable/equatable.dart';

import 'child_slot_by_latlong_response.dart';

class SlotByLatLongResponse extends Equatable
{
  final List<ChildSlotByLatLongResponse> centers;
  final int ttl;

  const SlotByLatLongResponse({this.centers, this.ttl});

  @override
  // TODO: implement props
  List<Object> get props => [centers];

  static SlotByLatLongResponse fromJson(dynamic json) {
    return SlotByLatLongResponse(
        centers: (json['centers'] as List)
            .map((i) => ChildSlotByLatLongResponse.fromJson(i))
            .toList(),
        ttl: json['ttl'] == null ? 0 : json['ttl']
    );
  }

  @override
  String toString() => 'SlotByLatLongResponse: {$centers $ttl)';


}

