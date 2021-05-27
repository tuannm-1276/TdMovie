extension IterableExt<E> on Iterable<E> {
  Iterable<R> mapIndexed<R>(R Function(int index, E item) f) sync* {
    var index = 0;
    for(final item in this) {
      yield f(index, item);
      index += 1;
    }
  }
}
