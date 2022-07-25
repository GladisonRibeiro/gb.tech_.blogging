import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

import '../../../shared/widgets/loading_widget.dart';
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
  late NewsBloc bloc;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<NewsBloc>();
    bloc.add(NewsLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PaddingLarge(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: GbHeadline('Novidades'),
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
              ),
              StreamBuilder(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  final state = bloc.state;

                  if (state is NewsLoading || state is NewsStart) {
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 300,
                        alignment: Alignment.center,
                        child: const LoadingWidget(),
                      ),
                    );
                  }

                  if (state is NewsError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: GbLabel(
                          'Não foi possível carregar as novidades...',
                        ),
                      ),
                    );
                  }

                  if (state is NewsSuccess) {
                    final posts = state.posts;
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final post = posts[index];
                          return PaddingSmall(child: PostCard(post: post));
                        },
                        childCount: posts.length,
                      ),
                    );
                  }

                  return const SliverToBoxAdapter();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
