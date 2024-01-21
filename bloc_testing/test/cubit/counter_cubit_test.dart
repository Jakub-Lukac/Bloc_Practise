import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_testing/cubit/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // group - organazing multiple test or features
  group("Counter Cubit", () {
    CounterCubit? counterCubit;
    setUp(() {
      counterCubit = CounterCubit();
    });
    // tearDown - function that will be called after all the tests run
    tearDown(() {
      counterCubit!.close();
    });

    test("The initial state for the CounterCubit is CounterState(counter: 0)",
        () {
      // featureOutput == expectedOutput
      // need equatable package
      // dart by default compares the location in memort of the objects!
      expect(counterCubit!.state, CounterState(counter: 0));
    });

    // for checking the functionality of function of the Cubit
    blocTest<CounterCubit, dynamic>(
      "The cubit should emit a CounterState(counter: 1, wasIncremented: true) when cubit.increment() is called",
      // build will return current instance of CounterCubit
      build: () => counterCubit!,
      //act will take a cubit and return function applied on it
      act: (cubit) => cubit.increment(),
      expect: () => [CounterState(counter: 1, wasIncremented: true)],
    );

    blocTest<CounterCubit, dynamic>(
      "The cubit should emit a CounterState(counter: -1, wasIncremented: false) when cubit.decrement() is called",
      // build will return current instance of CounterCubit
      build: () => counterCubit!,
      //act will take a cubit and return function applied on it
      act: (cubit) => cubit.decrement(),
      expect: () => [CounterState(counter: -1, wasIncremented: false)],
    );
  });
}
