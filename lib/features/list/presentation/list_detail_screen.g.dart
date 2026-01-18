// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_detail_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(itemsStream)
final itemsStreamProvider = ItemsStreamFamily._();

final class ItemsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ShoppingItem>>,
          List<ShoppingItem>,
          Stream<List<ShoppingItem>>
        >
    with
        $FutureModifier<List<ShoppingItem>>,
        $StreamProvider<List<ShoppingItem>> {
  ItemsStreamProvider._({
    required ItemsStreamFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'itemsStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$itemsStreamHash();

  @override
  String toString() {
    return r'itemsStreamProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<ShoppingItem>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ShoppingItem>> create(Ref ref) {
    final argument = this.argument as (String, String);
    return itemsStream(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemsStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$itemsStreamHash() => r'b0e103d564350a1ec37f4d5ff80f23913e968b27';

final class ItemsStreamFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<List<ShoppingItem>>,
          (String, String)
        > {
  ItemsStreamFamily._()
    : super(
        retry: null,
        name: r'itemsStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ItemsStreamProvider call(String groupId, String listId) =>
      ItemsStreamProvider._(argument: (groupId, listId), from: this);

  @override
  String toString() => r'itemsStreamProvider';
}
