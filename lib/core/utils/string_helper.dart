class StringHelper {
  /// Convert snake_case or lower_case_with_underscores to a readable label
  static String toLabel(String key) {
    if (key.isEmpty) return '';

    return key
        .split('_') // split by underscores
        .map(
          (word) =>
              word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1),
        )
        .join(' ');
  }
}
