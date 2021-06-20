import 'package:equatable/equatable.dart';

import 'child_centerslist_response.dart';

class OneweekSlotByPinResponse extends Equatable
{
  final List<ChildCentersListResponse> centers;

  const OneweekSlotByPinResponse({this.centers});

  @override
  // TODO: implement props
  List<Object> get props => [centers];

  static OneweekSlotByPinResponse fromJson(dynamic json) {
    return OneweekSlotByPinResponse(
        centers: (json['centers'] == null) ? [] : (json['centers'] as List)
            .map((i) => ChildCentersListResponse.fromJson(i))
            .toList()
    );
  }

    @override
    String toString() => 'OneweekSlotByPinResponse: {$centers)';


}

