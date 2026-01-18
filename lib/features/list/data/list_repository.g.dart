// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(listRepository)
final listRepositoryProvider = ListRepositoryProvider._();

final class ListRepositoryProvider
    extends $FunctionalProvider<ListRepository, ListRepository, ListRepository>
    with $Provider<ListRepository> {
  ListRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listRepositoryHash();

  @$internal
  @override
  $ProviderElement<ListRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ListRepository create(Ref ref) {
    return listRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListRepository>(value),
    );
  }
}

String _$listRepositoryHash() => r'3d124657ef97300e392cf3135ed94b18a5488657';
