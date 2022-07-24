import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

import '../posts/posts_bloc.dart';
import '../posts/posts_event.dart';
import '../posts/posts_state.dart';

class PostInput extends StatefulWidget {
  const PostInput({Key? key}) : super(key: key);

  @override
  State<PostInput> createState() => _PostInputState();
}

class _PostInputState extends State<PostInput> {
  final bloc = Modular.get<PostsBloc>();
  final messageController = TextEditingController();

  onSubmitMessage() {
    if (messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: accentColor,
        content: Text("Digite uma mensagem!"),
      ));
      return;
    }
    bloc.add(
      PostsCreatePost(currentUser: null, message: messageController.text),
    );
    messageController.clear();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return PaddingLarge(
      child: Form(
        key: const Key('form_post_input'),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: PaddingMedium(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: GbInput(
                    label: 'Compartilhe uma mensagem:',
                    controller: messageController,
                  ),
                ),
                SpacerSmall(),
                StreamBuilder<Object>(
                  stream: bloc.stream,
                  builder: (context, snapshot) {
                    final state = bloc.state;

                    if (state is PostsCreateLoading) {
                      return PaddingSmall(
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: buttonBackgroundColor,
                          ),
                        ),
                      );
                    }

                    return GestureDetector(
                      onTap: onSubmitMessage,
                      child: Container(
                        height: 46,
                        width: 46,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.send_rounded,
                          color: buttonBackgroundColor,
                          size: 32,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}