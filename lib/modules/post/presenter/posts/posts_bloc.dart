import 'package:bloc/bloc.dart';

import '../../../auth/domain/services/auth_store.dart';
import '../../application/delete_post.dart';
import '../../application/get_post.dart';
import '../../application/get_posts.dart';
import '../../application/publish_post.dart';
import '../../application/update_post.dart';
import 'posts_event.dart';
import 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPosts getPostsUsecase;
  final GetPost getPostUsecase;
  final DeletePost deletePostUsecase;
  final PublishPost publishPostUsecase;
  final UpdatePost updatePostUsecase;
  final AuthStore authStore;

  PostsBloc(
    this.getPostsUsecase,
    this.getPostUsecase,
    this.deletePostUsecase,
    this.publishPostUsecase,
    this.updatePostUsecase,
    this.authStore,
  ) : super(PostsStart()) {
    on<PostsLoad>((event, emit) async {
      emit(PostsLoading());
      final result = await getPostsUsecase();

      emit(
          result.fold((l) => PostsError(l), (r) => PostsLoadSuccess(posts: r)));
    });
    on<PostsChangePost>((event, emit) async {
      emit(PostsUpdateLoading());
      final result = await updatePostUsecase(
        currentUser: event.currentUser ?? authStore.getCurrentUser(),
        idPost: event.idPost,
        message: event.message,
      );
      result.fold((l) {
        emit(PostsError(l));
      }, (r) {
        emit(PostsUpdateSuccess(post: r));
        add(PostsLoad());
      });
    });
    on<PostsCreatePost>((event, emit) async {
      emit(PostsCreateLoading());
      await Future.delayed(const Duration(milliseconds: 300));
      final result = await publishPostUsecase(
        currentUser: event.currentUser ?? authStore.getCurrentUser(),
        message: event.message,
      );
      result.fold((l) {
        emit(PostsError(l));
      }, (r) {
        emit(PostsCreateSuccess(post: r));
        add(PostsLoad());
      });
    });
    on<PostsRemovePost>((event, emit) async {
      emit(PostsDeleteLoading());
      final result = await deletePostUsecase(
        currentUser: event.currentUser ?? authStore.getCurrentUser(),
        idPost: event.idPost,
      );
      result.fold((l) {
        emit(PostsError(l));
      }, (r) {
        emit(PostsDeleteSuccess(status: r));
        add(PostsLoad());
      });
    });
  }
}
