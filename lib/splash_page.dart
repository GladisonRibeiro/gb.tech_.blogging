import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';
import 'package:url_launcher/url_launcher.dart';

import 'modules/auth/shared/widgets/background_hero_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final urlGitHubRepository =
      Uri.parse('https://github.com/GladisonRibeiro/gb.tech_.blogging');

  @override
  void initState() {
    super.initState();
    openAuthModule();
  }

  openAuthModule() async {
    await Future.delayed(const Duration(seconds: 3));
    Modular.to.navigate('/auth/');
  }

  openGithubLink() async {
    await launchUrl(urlGitHubRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Hero(
              tag: 'background',
              child: BackgroundHeroWidget(
                shape: BoxShape.rectangle,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GbHeadline(
                  'gb.tech_ blogging',
                  style: const TextStyle(color: backgroundColor),
                ),
                SpacerExtraLarge(),
                GbText(
                  'por Gladison Ribeiro da Silva',
                  style: const TextStyle(color: backgroundColor),
                ),
                GbTextButton(
                  label: 'Veja no GitHub',
                  onTap: openGithubLink,
                ),
                SpacerExtraLarge(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
