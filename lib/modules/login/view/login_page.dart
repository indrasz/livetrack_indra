// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livetrack_indra/gen/assets.gen.dart';
import 'package:livetrack_indra/gen/colors.gen.dart';
import 'package:livetrack_indra/modules/login/bloc/login_bloc.dart';
import 'package:livetrack_indra/modules/login/cubit/form_values_cubit.dart';
import 'package:livetrack_indra/modules/top_level_bloc/cubit/form_key_cubit.dart';
import 'package:livetrack_indra/utils/screen_size.dart';

class VisibilityPasswordCubit extends Cubit<bool> {
  VisibilityPasswordCubit() : super(false);

  void toggle() => emit(!state);
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
          child: Column(
            children: [
              Container(
                alignment: ScreenSize.isBelowExtraLargeScreen(context)
                    ? Alignment.center
                    : Alignment.topLeft,
                child: Assets.images.logoTranstrack.image(width: 180),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  runSpacing: 40,
                  spacing: 40,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        width: ScreenSize.isBelowExtraLargeScreen(context)
                            ? double.infinity
                            : MediaQuery.of(context).size.width * 0.3,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(34),
                        ),
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => VisibilityPasswordCubit(),
                            ),
                            BlocProvider(
                              create: (context) => LoginBloc(),
                            ),
                            BlocProvider(
                              create: (context) => FormValuesCubit(),
                            ),
                            BlocProvider(
                              create: (context) => FormKeyCubit(),
                            ),
                          ],
                          child: const _FormBodyWidget(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SizedBox(
                            width: ScreenSize.isBelowExtraLargeScreen(context)
                                ? double.infinity
                                : MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                SelectableText(
                                  'RegisT',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),
                                const SelectableText(
                                  'Pengelolaan device dan pemantauan pemasangan device\nTranstrack.ID',
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Assets.images.illustrationLogin.svg(width: 120)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: ColorName.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          height: 48,
          child: Text(
            '© 2019-${DateTime.now().year}. PT. Indo Trans Teknologi. All rights reserved',
            style: const TextStyle(color: ColorName.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _FormBodyWidget extends StatelessWidget {
  const _FormBodyWidget({Key? key}) : super(key: key);

  void _submit(BuildContext context) {
    final formKey = context.read<FormKeyCubit>().state;

    if (!formKey.currentState!.validate()) return;

    final values = context.read<FormValuesCubit>().state;

    context.read<LoginBloc>().add(
          LoginSubmitEvent(
            email: values.email,
            password: values.password,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = context.watch<VisibilityPasswordCubit>().state;

    return Form(
      key: context.read<FormKeyCubit>().state,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                      top: 8,
                    ),
                    child: const Text(
                      'Email ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue: context.read<FormValuesCubit>().state.email,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Masukan email anda...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                    ),
                    onChanged: (email) {
                      context.read<FormValuesCubit>().setEmail(email);
                    },
                    onFieldSubmitted: (value) => _submit(context),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    initialValue:
                        context.read<FormValuesCubit>().state.password,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      return null;
                    },
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      hintText: 'Masukkan password anda...',
                      //counterText: "Lupa Password?",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          context.read<VisibilityPasswordCubit>().toggle();
                        },
                        child: Icon(
                          !isVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: !isVisible ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                    onChanged: (password) {
                      context.read<FormValuesCubit>().setPassword(password);
                    },
                    onFieldSubmitted: (value) => _submit(context),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MaterialButton(
                      child: const Text(
                        'Lupa Password?',
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 28),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return const SizedBox(
                          height: 55,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 10,
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () => _submit(context),
                          style: ElevatedButton.styleFrom(
                            primary: ColorName.primary,
                            onPrimary: ColorName.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: Center(child: Text('Login')),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
