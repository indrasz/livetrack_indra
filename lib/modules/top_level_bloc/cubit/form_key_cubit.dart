import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


class FormKeyCubit extends Cubit<GlobalKey<FormState>> {
  FormKeyCubit() : super(GlobalKey<FormState>());

  void change() => emit(GlobalKey<FormState>());
}
