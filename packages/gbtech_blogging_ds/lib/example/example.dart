import 'package:flutter/material.dart';

import '../src/components/components.dart';
import '../src/patterns/patterns.dart';
import '../src/tokens/tokens.dart';

class Example extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gb.tech_ Blogging',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: PaddingExtraLarge(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpacerSmall(),
              GbHeadline('HEADLINE headline'),
              GbSubTitle('SUBTITLE subtitle'),
              GbText('BODY body'),
              GbLabel('LABEL label'),
              SpacerMedium(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    GbInput(
                      keyInput: const Key('input_email'),
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
                      keyInput: const Key('input_password'),
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
                      key: const Key('button_submit'),
                      label: 'Entrar',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // Is Valid
                        }
                      },
                    ),
                    SpacerLarge(),
                    const GbTextButton(label: 'Cadastre-se'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
