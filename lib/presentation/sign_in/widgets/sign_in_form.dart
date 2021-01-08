import 'package:ddd/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        // TODO: implement listener
        state.authFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold((failure) {
                  // TODO: Implement Toast
                  Toast.show(
                      failure.map(
                        cancelledByUser: (_) => 'Cancelled By User',
                        serverError: (_) => 'Server Error',
                        emailAlreadyInUse: (_) => 'Email Already In Use',
                        invalidEmailAndPasswordCombination: (_) => 'Invalid Email and Pasword Combination',
                      ),
                      context,
                      duration: 4,
                      backgroundColor: Colors.redAccent);
                }, (_) {
                  // TODO: Implement Navigate To New Page
                  Toast.show('success', context,
                      duration: 4, backgroundColor: Colors.green);
                }));
      },
      builder: (context, state) {
        return Form(
          autovalidate: state.showErrorMessages,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                const Text(
                  'logo',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 130),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail_outline),
                    labelText: 'Email Address',
                  ),
                  autocorrect: false,
                  onChanged: (value) => context
                      .bloc<SignInFormBloc>()
                      .add(SignInFormEvent.emailChanged(value)),
                  validator: (_) => context
                      .bloc<SignInFormBloc>()
                      .state
                      .emailAddress
                      .value
                      .fold(
                        (f) => f.maybeMap(
                          invalidEmail: (_) => 'Invalid Email String',
                          orElse: () => null,
                        ),
                        (_) => null,
                      ),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.fingerprint),
                    labelText: 'Password',
                  ),
                  autocorrect: false,
                  obscureText: true,
                  onChanged: (value) => context
                      .bloc<SignInFormBloc>()
                      .add(SignInFormEvent.passwordChanged(value)),
                  validator: (_) =>
                      context.bloc<SignInFormBloc>().state.password.value.fold(
                            (f) => f.maybeMap(
                              shortPassword: (_) => 'Short Password String',
                              orElse: () => null,
                            ),
                            (_) => null,
                          ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: FlatButton(
                            onPressed: () {
                              context.bloc<SignInFormBloc>().add(
                                  const SignInFormEvent
                                      .signInWithEmailAndPasswordPressed());
                            },
                            child: const Text('SignIn'))),
                    Expanded(
                        child: FlatButton(
                            onPressed: () {
                              context.bloc<SignInFormBloc>().add(
                                  const SignInFormEvent
                                      .registerWithEmailAndPasswordPressed());
                            },
                            child: const Text('Register')))
                  ],
                ),
                RaisedButton(
                  onPressed: () {
                    context
                        .bloc<SignInFormBloc>()
                        .add(const SignInFormEvent.signInWithGooglePressed());
                  },
                  color: Colors.blue,
                  child: const Text(
                    'Sign in with google',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
