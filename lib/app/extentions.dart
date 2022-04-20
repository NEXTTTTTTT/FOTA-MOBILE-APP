
const EMPTY = "";
const ZERO =0;

// extension on String? class to make orEmpty method return "" instead of null
extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return EMPTY;
    } else {
      return this!;
    }
  }
}

// extension on Int? class to make orZero method return 0 instead of null
extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return ZERO;
    } else {
      return this!;
    }
  }
}