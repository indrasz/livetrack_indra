import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:livetrack_indra/helpers/navigation_helper.dart';
import 'package:livetrack_indra/helpers/user_helper.dart';
import 'package:livetrack_indra/repositories/auth_repository.dart';
import 'package:livetrack_indra/utils/enums.dart';
import 'package:livetrack_indra/utils/wrappers/error_wrapper.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitEvent>(_loginSubmit);
  }

  final _repo = AuthRepository();

  Future _loginSubmit(LoginSubmitEvent event, Emitter emit) async {
    emit(LoginLoading());
    await ErrorWrapper.asyncGuard(
      () => _repo.submitLogin(event.email, event.password),
      onError: (e) {
        emit(LoginInitial());
      },
    );

    final user = GetIt.I<UserHelper>().getUser();

    
    //TODO: Add logic to navigate to dashboard
  }
}
