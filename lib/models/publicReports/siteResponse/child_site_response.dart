import 'package:equatable/equatable.dart';

class ChildSitesResponse extends Equatable
{
  final int total;
  final int govt;
  final int pvt;
  final int today;

  const ChildSitesResponse({
    this.total,
    this.govt,
    this.pvt,
    this.today
  });
  @override
  List<Object> get props => [total, govt, pvt, today];

  static ChildSitesResponse fromJson(dynamic json)
  {

    return ChildSitesResponse(
        total: json['total'] == null ? 0 : json['total'],
        govt: json['govt'] == null ? 0 : json['govt'],
        pvt: json['pvt'] == null ? 0 : json['pvt'],
        today: json['today'] == null ? 0 : json['today']
    );
  }
  @override
  String toString() => 'ChildSitesResponse response total:$total';
}