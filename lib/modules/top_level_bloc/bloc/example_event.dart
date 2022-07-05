part of 'example_bloc.dart';

abstract class ExampleEvent extends Equatable {
  const ExampleEvent();
}

class SearchExample extends ExampleEvent {
  const SearchExample({required this.key});

  final String key;

  @override
  List<Object> get props => [key];
}

class CreateExample extends ExampleEvent {
  const CreateExample({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}