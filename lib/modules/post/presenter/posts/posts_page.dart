import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

import '../../../shared/widgets/loading_widget.dart';
import '../../domain/entities/post.dart';
import '../widgets/post_card.dart';
import '../widgets/post_input.dart';
import 'posts_bloc.dart';
import 'posts_event.dart';
import 'posts_state.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late PostsBloc bloc;
  late final ScrollController scrollController;
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    bloc = Modular.get<PostsBloc>();
    bloc.add(PostsLoad());

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 600));
      scrollToBottom();
    });

    bloc.stream.listen((event) async {
      if (event is PostsLoadSuccess) {
        Future.delayed(const Duration(microseconds: 300), () {
          scrollToBottom(const Duration(microseconds: 300));
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom([Duration duration = const Duration(milliseconds: 10)]) {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: duration,
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PaddingLarge(
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                title: GbHeadline('Postagens'),
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
              ),
              StreamBuilder(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  final state = bloc.state;

                  if (state is PostsStart) {
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 300,
                        alignment: Alignment.center,
                        child: const LoadingWidget(),
                      ),
                    );
                  }

                  if (state is PostsError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: GbLabel(
                          'Não foi possível carregar as novidades...',
                        ),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter();
                },
              ),
              StreamBuilder(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  final state = bloc.state;

                  if (state is PostsLoadSuccess) {
                    posts = state.posts;
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final post = posts[index];
                        return PaddingSmall(child: PostCard(post: post));
                      },
                      childCount: posts.length,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [PostInput()],
      ),
    );
  }
}
