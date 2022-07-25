import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

import '../../../shared/widgets/loading_widget.dart';
import '../../shared/widgets/widgets.dart';
import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final bloc = Modular.get<LoginBloc>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.stream.listen((event) {
      if (event is LoginSuccess) {
        Modular.to.navigate('/post/posts');
      }
      if (event is LoginError) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: accentColor,
          content: Text("Verifique suas credenciais!"),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: -150,
            left: -150,
            child: Hero(
              tag: 'background',
              child: BackgroundHeroWidget(
                width: 300,
                height: 300,
                alignment: Alignment.bottomRight,
                padding: 60,
              ),
            ),
          ),
          SafeAreaContainerWidget(
            children: [
              PaddingExtraLarge(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpacerExtraLarge(),
                    GbHeadline(
                      'gb.tech_ blogging',
                      semanticsLabel: 'Nome do apicativo',
                    ),
                    SpacerExtraLarge(),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 700,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            GbInput(
                              semanticsLabel: 'Input para informar o e-mail',
                              controller: emailController,
                              label: 'E-mail',
                              validator: (email) {
                                if (email?.isEmpty ?? false) {
                                  return 'Informe um e-mail';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                            ),
                            SpacerMedium(),
                            GbPasswordInput(
                              semanticsLabel: 'Input para informar a senha',
                              controller: passwordController,
                              label: 'Senha',
                              validator: (senha) {
                                if (senha?.isEmpty ?? false) {
                                  return 'Informe uma senha';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.done,
                            ),
                            SpacerExtraLarge(),
                            StreamBuilder(
                              stream: bloc.stream,
                              builder: (context, snapshot) {
                                final state = bloc.state;

                                if (state is LoginLoading) {
                                  return const LoadingWidget();
                                }

                                return GbButton(
                                  semanticsLabel:
                                      'Botão para confirmar credênciais e entrar',
                                  label: 'Entrar',
                                  onTap: () {
                                    _formKey.currentState?.save();
                                    if (_formKey.currentState!.validate()) {
                                      final email = emailController.text;
                                      final password = passwordController.text;
                                      bloc.add(
                                          LoginSubmitPressed(email, password));
                                    }
                                  },
                                );
                              },
                            ),
                            SpacerLarge(),
                            GbTextButton(
                              semanticsLabel:
                                  'Botão para abrir página de cadastro',
                              label: 'Cadastre-se',
                              onTap: () {
                                Modular.to.pushNamed('./sign_up');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
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
