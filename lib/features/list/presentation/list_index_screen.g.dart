// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_index_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(listsStream)
final listsStreamProvider = ListsStreamFamily._();

final class ListsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ShoppingList>>,
          List<ShoppingList>,
          Stream<List<ShoppingList>>
        >
    with
        $FutureModifier<List<ShoppingList>>,
        $StreamProvider<List<ShoppingList>> {
  ListsStreamProvider._({
    required ListsStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'listsStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$listsStreamHash();

  @override
  String toString() {
    return r'listsStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<ShoppingList>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ShoppingList>> create(Ref ref) {
    final argument = this.argument as String;
    return listsStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ListsStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$listsStreamHash() => r'c4cc2fe59a0014edd995804c4b8d5c8b728abc29';

final class ListsStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<ShoppingList>>, String> {
  ListsStreamFamily._()
    : super(
        retry: null,
        name: r'listsStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ListsStreamProvider call(String groupId) =>
      ListsStreamProvider._(argument: groupId, from: this);

  @override
  String toString() => r'listsStreamProvider';
}
