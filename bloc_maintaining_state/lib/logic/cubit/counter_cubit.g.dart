// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CounterState _$CounterStateFromJson(Map<String, dynamic> json) => CounterState(
      counter: json['counter'] as int?,
      wasIncremented: json['wasIncremented'] as bool?,
    );

Map<String, dynamic> _$CounterStateToJson(CounterState instance) =>
    <String, dynamic>{
      'counter': instance.counter,
      'wasIncremented': instance.wasIncremented,
    };
