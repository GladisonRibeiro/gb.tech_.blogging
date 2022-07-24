import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

import '../widgets/post_card.dart';
import 'news_bloc.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final bloc = Modular.get<NewsBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(NewsLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaddingLarge(
        child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            final state = bloc.state;

            if (state is NewsLoading || state is NewsStart) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is NewsError) {
              return Center(
                child: GbLabel(
                  'Não foi possível carregar as novidades...',
                ),
              );
            }

            final posts = (state as NewsSuccess).posts;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PaddingSmall(child: PostCard(post: post));
              },
            );
          },
        ),
      ),
    );
  }
}
