
const EMPTY = "";
const ZERO =0;
const FALSE = false;
const EMPTY_MAP = {};

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

// extension on bool? class to make orFalse method return false instead of null
extension NonNullBoolean on bool? {
  bool orFalse() {
    if (this == null) {
      return FALSE;
    } else {
      return this!;
    }
  }
}

// extension on bool? class to make orFalse method return false instead of null
extension NonNullMap on Map? {
  Map orEmptyMap() {
    if (this == null) {
      return EMPTY_MAP;
    } else {
      return this!;
    }
  }
}

