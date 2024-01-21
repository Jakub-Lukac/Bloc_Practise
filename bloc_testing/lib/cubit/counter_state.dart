// ignore_for_file: must_be_immutable

part of 'counter_cubit.dart';

class CounterState extends Equatable{
  int? counter;
  bool? wasIncremented;
  CounterState({
    required this.counter,
    this.wasIncremented
  });
  
  @override
  List<Object?> get props => [counter, wasIncremented];
}
