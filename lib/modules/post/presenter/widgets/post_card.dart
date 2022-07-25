import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

import '../../../auth/domain/services/auth_store.dart';
import '../../../shared/utils/formart_date.dart';
import '../../domain/entities/post.dart';
import '../posts/posts_bloc.dart';
import '../posts/posts_event.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final authStore = Modular.get<AuthStore>();
  final bloc = Modular.get<PostsBloc>();
  final messageController = TextEditingController();

  late final isPostOfCurrentUser;

  @override
  void initState() {
    super.initState();
    isPostOfCurrentUser =
        widget.post.idUser == authStore.getCurrentUser().idUser;
  }

  void updateMessage(context) {
    final message = messageController.text;

    if (message.isNotEmpty) {
      Navigator.of(context).pop();
      bloc.add(
        PostsChangePost(
          idPost: widget.post.idPost!,
          message: message,
          currentUser: null,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: errorColor,
        content: Text("Digite uma mensagem!"),
      ));
    }
  }

  showUpdateMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Editar Mensagem"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                GbInput(
                  label: 'Nova mensagem',
                  controller: messageController,
                ),
              ],
            ),
          ),
          actions: [
            GbTextButton(
              onTap: () => updateMessage(context),
              label: 'Atualizar',
            ),
          ],
        );
      },
    );
  }

  void removeMessage(context) {
    Navigator.of(context).pop();
    bloc.add(
      PostsRemovePost(
        idPost: widget.post.idPost!,
        currentUser: null,
      ),
    );
  }

  showRemoveMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Apagar Mensagem"),
          content: const Text('Cuidado essa ação não pode ser revertida!'),
          actions: [
            GbTextButton(
              onTap: () => removeMessage(context),
              label: 'Confirmar',
            ),
          ],
        );
      },
    );
  }

  Widget actions() {
    if (!isPostOfCurrentUser) return const SizedBox();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          label: 'Botão para editar essa postagem',
          child: GestureDetector(
            child: Container(
              alignment: Alignment.center,
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: secondaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit,
                size: 16,
                color: backgroundColor,
              ),
            ),
            onTap: () {
              showUpdateMessageDialog(context);
            },
          ),
        ),
        SpacerMedium(),
        Semantics(
          label: 'Botão para apagar essa postagem',
          child: GestureDetector(
            child: Container(
              alignment: Alignment.center,
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: errorColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 16,
                color: backgroundColor,
              ),
            ),
            onTap: () {
              showRemoveMessageDialog(context);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GbCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.post.userUrlPicture != null &&
                      widget.post.userUrlPicture!.isNotEmpty
                  ? CircleAvatar(
                      foregroundImage:
                          NetworkImage(widget.post.userUrlPicture!),
                    )
                  : CircleAvatar(
                      backgroundColor: primaryColor,
                      child: Text((widget.post.userName.isNotEmpty
                              ? widget.post.userName
                              : ' ')
                          .characters
                          .first),
                    ),
              SpacerMedium(),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: GbLabel(widget.post.userName)),
                    actions()
                  ],
                ),
              ),
            ],
          ),
          SpacerMedium(),
          GbText(widget.post.message),
          SpacerMedium(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GbText(
                formatDate(widget.post.createdDate),
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
