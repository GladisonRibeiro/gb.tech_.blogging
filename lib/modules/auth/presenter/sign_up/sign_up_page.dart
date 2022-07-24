import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

import '../../domain/exception/exception.dart';
import '../../shared/widgets/widgets.dart';
import 'sign_up_bloc.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final bloc = Modular.get<SignUpBloc>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.stream.listen((event) {
      if (event is SignUpSuccess) {
        Modular.to.navigate('/post/posts');
      }

      if (event is SignUpError) {
        String message = "Não foi possível realizar essa ação no momento!";

        if (event.exception is InvalidNameException) {
          message = "Verifique o nome digitado!";
        }
        if (event.exception is InvalidEmailException) {
          message = "Verifique o email digitado!";
        }
        if (event.exception is InvalidPasswordException) {
          message = "Verifique a senha digitada!";
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: accentColor,
          content: Text(message),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: GbHeadline(
          'Cadastre-se',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: -260,
            left: -260,
            child: Hero(
              tag: 'background',
              child: BackgroundHeroWidget(
                width: 300,
                height: 300,
              ),
            ),
          ),
          SafeAreaContainerWidget(
            children: [
              PaddingExtraLarge(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 700,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            GbInput(
                              controller: nameController,
                              label: 'Nome',
                              validator: (email) {
                                if (email?.isEmpty ?? false) {
                                  return 'Informe seu nome';
                                }
                                return null;
                              },
                            ),
                            SpacerMedium(),
                            GbInput(
                              controller: emailController,
                              label: 'E-mail',
                              validator: (email) {
                                if (email?.isEmpty ?? false) {
                                  return 'Informe um e-mail';
                                }
                                return null;
                              },
                            ),
                            SpacerMedium(),
                            GbInput(
                              controller: passwordController,
                              label: 'Senha',
                              validator: (senha) {
                                if (senha?.isEmpty ?? false) {
                                  return 'Informe uma senha';
                                }
                                return null;
                              },
                            ),
                            SpacerExtraLarge(),
                            StreamBuilder(
                              stream: bloc.stream,
                              builder: (context, snapshot) {
                                final state = bloc.state;

                                if (state is SignUpLoading) {
                                  return const CircularProgressIndicator();
                                }

                                return GbButton(
                                  label: 'Continuar',
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState?.save();
                                      if (_formKey.currentState!.validate()) {
                                        final email = emailController.text;
                                        final password =
                                            passwordController.text;
                                        final name = nameController.text;
                                        bloc.add(
                                          SignUpSubmitPressed(
                                            name,
                                            email,
                                            password,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
