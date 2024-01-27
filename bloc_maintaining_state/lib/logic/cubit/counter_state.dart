part of 'counter_cubit.dart';

@JsonSerializable()
class CounterState {
  int? counter;
  bool? wasIncremented;
  CounterState({
    required this.counter,
    this.wasIncremented
  });

  factory CounterState.fromJson(Map<String, dynamic> json) => _$CounterStateFromJson(json);

  Map<String, dynamic> toJson() => _$CounterStateToJson(this);
}
