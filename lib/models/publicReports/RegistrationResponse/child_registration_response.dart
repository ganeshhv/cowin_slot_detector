import 'package:equatable/equatable.dart';

class ChildRegistrationResponse extends Equatable
{
  final int total;
  final int city_below45;
  final int city_above45;
  final int today;

  const ChildRegistrationResponse({
    this.total,
    this.city_below45,
    this.city_above45,
    this.today
  });
  @override
  List<Object> get props => [total, city_below45, city_above45, today];

  static ChildRegistrationResponse fromJson(dynamic json)
  {
    return ChildRegistrationResponse(
        total: json['total'] == null ? 0 : json['total'],
        city_below45: json['cit_18_45'] == null ? 0 : json['cit_18_45'],
        city_above45: json['cit_45_above'] == null ? 0 : json['cit_45_above'],
        today: json['today'] == null ? 0 : json['today']
    );
  }
  @override
  String toString() => '';
}