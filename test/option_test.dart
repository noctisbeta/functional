import 'package:flutter_test/flutter_test.dart';
import 'package:functional/functional.dart';

void main() {
  test('Testing equality of None', () {
    const n1 = None();
    const n2 = None();
    expect(n1 == n2, true);

    // ignore: prefer_const_constructors
    final n3 = None();
    // ignore: prefer_const_constructors
    final n4 = None();
    expect(n3 == n4, true);

    // ignore: prefer_const_constructors
    final n5 = None<int>();
    // ignore: prefer_const_constructors
    final n6 = None<int>();
    expect(n5 == n6, true);

    // ignore: prefer_const_constructors
    final n7 = None<String>();
    // ignore: prefer_const_constructors
    final n8 = None<int>();
    // ignore: unrelated_type_equality_checks
    expect(n7 == n8, true);

    const n9 = None<int>();
    const n10 = None<String>();
    // ignore: unrelated_type_equality_checks
    expect(n9 == n10, true);

    const n11 = None<int>();
    const n12 = None<int>();
    expect(n11 == n12, true);
  });

  test('Testing equality of Some', () {
    const s1 = Some(1);
    const s2 = Some(1);
    expect(s1 == s2, true);

    // ignore: prefer_const_constructors
    final s3 = Some(1);
    // ignore: prefer_const_constructors
    final s4 = Some(1);
    expect(s3 == s4, true);

    // ignore: prefer_const_constructors
    final s5 = Some(1);
    // ignore: prefer_const_constructors
    final s6 = Some(2);
    expect(s5 == s6, false);

    // ignore: prefer_const_constructors
    final s7 = Some(1);
    // ignore: prefer_const_constructors
    final s8 = Some(1);
    expect(s7 == s8, true);

    // ignore: prefer_const_constructors
    final s9 = Some(1);
    // ignore: prefer_const_constructors
    final s10 = Some(2);
    expect(s9 == s10, false);

    const s13 = Some(1);
    const s14 = Some(2);
    expect(s13 == s14, false);
  });

  test('Testing equality of Option', () {
    final o1 = Option.of(1);
    final o2 = Option.of(1);
    expect(o1 == o2, true);

    final o5 = Option.of(1);
    final o6 = Option.of(2);
    expect(o5 == o6, false);

    final o7 = Option.of(1);
    final o8 = Option.of(null);
    expect(o7 == o8, false);

    final o9 = Option.of(null);
    final o10 = Option.of(null);
    expect(o9 == o10, true);
  });
}
