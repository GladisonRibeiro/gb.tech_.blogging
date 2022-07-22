# gbtech_blogging_ds

---

Design System para o projeto gbtech_blogging.


## Conteúdo

|Nome da Pasta| Conteúdo|
|:--|:--|
|tokens| colors, spacings, typography|
|components| button, textField|
|patterns| card, input |

## Como usar

### Importar no projeto
```yaml
  gbtech_blogging_ds:
    path: ./packages/gbtech_blogging_ds

```

### Exemplo
```dart
import 'package:flutter/material.dart';

import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

class Example extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
```

---

[![Linkedin Badge](https://img.shields.io/badge/-LinkedIn-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/gladisonribeirodasilva)](https://www.linkedin.com/in/gladisonribeirodasilva) [![Gmail Badge](https://img.shields.io/badge/Gmail-D14836?style=flat-square&logo=gmail&logoColor=white&link=mailto:gladison.ti@gmail.com)](mailto:gladison.ti@gmail.com)