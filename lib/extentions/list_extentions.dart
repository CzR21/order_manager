class Grouping<K, V> {

  final K key;
  final List<V> values;

  Grouping(this.key, this.values);
}

extension ListGrouping<T> on List<T> {

  List<Grouping<K, T>> groupBy<K>(K Function(T) keyFn) {

    Map<K, List<T>> groupedMap = {};

    for (var element in this) {
      var key = keyFn(element);

      groupedMap.containsKey(key) ? groupedMap[key]!.add(element) : groupedMap[key] = [element];
    }

    return groupedMap.entries
      .map((entry) => Grouping(entry.key, entry.value))
      .toList();
  }
}

extension ListSum<T> on List<T> {

  num sum(num Function(T) selector) => this.fold(0, (previousValue, element) => previousValue + selector(element));

}
