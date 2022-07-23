import 'package:bloc/bloc.dart';

import '../../application/get_news.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNews getNewsUsecase;

  NewsBloc(this.getNewsUsecase) : super(NewsStart()) {
    on<NewsLoad>((event, emit) async {
      emit(NewsLoading());
      final result = await getNewsUsecase();
      emit(result.fold((l) => NewsError(l), (r) => NewsSuccess(r)));
    });
  }
}
