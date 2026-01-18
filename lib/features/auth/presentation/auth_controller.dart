import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {
    // nothing to initialize
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signInWithGoogle();
    });
  }

  Future<void> signInAnonymously() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signInAnonymously();
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).signOut(),
    );
  }

  Future<void> deleteAccount() async {
    state = const AsyncLoading();
    try {
      // Execute delete. If successful, auth state changes and router redirects.
      // We don't need to update state to 'data' because this provider will likely be disposed.
      await ref.read(authRepositoryProvider).deleteAccount();
    } catch (e, st) {
      // Only set error state if we are still valid (approximate check)
      // Since 'ref.mounted' is not directly available in generated AutoDisposeAsyncNotifier
      // without keeping track, we'll just try to set it.
      // However, to fix the specific crash "Cannot use ref... after it has been disposed",
      // we can't easily check.
      //
      // BUT: The crash happens because AsyncValue.guard TRIES to set state after the future completes.
      // By using try/catch and NOT setting state on success (when redirect happens), we avoid the race condition.
      // On error, we are likely still on the screen, so setting state is safer.
      state = AsyncValue.error(e, st);
    }
  }
}
