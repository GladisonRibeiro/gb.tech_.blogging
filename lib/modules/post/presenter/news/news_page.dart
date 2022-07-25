import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  final bloc = Modular.get<NewsBloc>();
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    bloc.add(NewsLoad());

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 600));
      scrollToBottom();
    });

    bloc.stream.listen((event) async {
      if (event is NewsSuccess) {
        Future.delayed(const Duration(milliseconds: 300), () {
          scrollToBottom(const Duration(milliseconds: 300));
        });
      }
    });
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
      body: PaddingLarge(
        child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            final state = bloc.state;

            if (state is NewsLoading || state is NewsStart) {
              return const LoadingWidget();
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
              controller: scrollController,
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
