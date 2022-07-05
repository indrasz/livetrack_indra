part of 'example_bloc.dart';

abstract class ExampleState extends Equatable {
  const ExampleState(this.clients);

  final List<Example> clients;

  @override
  List<Object?> get props => [clients];
}

class ExampleInitial extends ExampleState {
  ExampleInitial() : super([]);
}

class ExampleLoading extends ExampleState {
  ExampleLoading(ExampleState state) : super(state.clients);
}

class ExampleLoaded extends ExampleState {
  const ExampleLoaded(List<Example> clients) : super(clients);
}

class ExampleError extends ExampleState {
  ExampleError(ExampleState state) : super(state.clients);
}
