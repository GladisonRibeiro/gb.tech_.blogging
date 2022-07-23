import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

import '../../shared/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

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
                    GbHeadline('gb.tech_ blogging'),
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
                              label: 'Senha',
                              validator: (senha) {
                                if (senha?.isEmpty ?? false) {
                                  return 'Informe uma senha';
                                }
                                return null;
                              },
                            ),
                            SpacerExtraLarge(),
                            GbButton(
                              label: 'Entrar',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // Is Valid
                                }
                              },
                            ),
                            SpacerLarge(),
                            GbTextButton(
                              label: 'Cadastre-se',
                              onTap: () {
                                Modular.to.pushNamed('/auth/sign_up');
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
