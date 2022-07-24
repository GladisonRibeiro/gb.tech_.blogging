import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

import '../widgets/post_card.dart';
import 'posts_bloc.dart';
import 'posts_event.dart';
import 'posts_state.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final bloc = Modular.get<PostsBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(PostsLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaddingLarge(
        child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            final state = bloc.state;

            if (state is PostsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PostsError) {
              return Center(
                child: GbLabel(
                  'Não foi possível carregar as novidades...',
                ),
              );
            }

            if (state is PostsLoadSuccess) {
              final posts = (state).posts;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PaddingSmall(child: PostCard(post: post));
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
