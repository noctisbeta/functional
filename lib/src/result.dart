// ignore_for_file: public_member_api_docs

import 'package:functional/functional.dart';

typedef Result<E, O> = Either<E, O>;
typedef Err<E, O> = Left<E, O>;
typedef Ok<E, O> = Right<E, O>;
