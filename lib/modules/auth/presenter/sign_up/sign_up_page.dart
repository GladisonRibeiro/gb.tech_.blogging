import 'package:flutter/material.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

import '../../shared/widgets/widgets.dart';

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignUpPage({Key? key}) : super(key: key);

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
              PaddingMedium(
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
                              label: 'Continuar',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // Is Valid
                                }
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
