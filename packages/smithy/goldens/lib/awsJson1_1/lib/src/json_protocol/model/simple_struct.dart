// Generated with smithy-dart 0.3.2. DO NOT MODIFY.
// ignore_for_file: avoid_unused_constructor_parameters,deprecated_member_use_from_same_package,non_constant_identifier_names,unnecessary_library_name

library aws_json1_1_v1.json_protocol.model.simple_struct; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i2;

part 'simple_struct.g.dart';

abstract class SimpleStruct
    with _i1.AWSEquatable<SimpleStruct>
    implements Built<SimpleStruct, SimpleStructBuilder> {
  factory SimpleStruct({String? value}) {
    return _$SimpleStruct._(value: value);
  }

  factory SimpleStruct.build([void Function(SimpleStructBuilder) updates]) =
      _$SimpleStruct;

  const SimpleStruct._();

  static const List<_i2.SmithySerializer<SimpleStruct>> serializers = [
    SimpleStructAwsJson11Serializer(),
  ];

  String? get value;
  @override
  List<Object?> get props => [value];

  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('SimpleStruct')
      ..add('value', value);
    return helper.toString();
  }
}

class SimpleStructAwsJson11Serializer
    extends _i2.StructuredSmithySerializer<SimpleStruct> {
  const SimpleStructAwsJson11Serializer() : super('SimpleStruct');

  @override
  Iterable<Type> get types => const [SimpleStruct, _$SimpleStruct];

  @override
  Iterable<_i2.ShapeId> get supportedProtocols => const [
    _i2.ShapeId(namespace: 'aws.protocols', shape: 'awsJson1_1'),
  ];

  @override
  SimpleStruct deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SimpleStructBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final value = iterator.current;
      if (value == null) {
        continue;
      }
      switch (key) {
        case 'Value':
          result.value =
              (serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String);
      }
    }

    return result.build();
  }

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    SimpleStruct object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result$ = <Object?>[];
    final SimpleStruct(:value) = object;
    if (value != null) {
      result$
        ..add('Value')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result$;
  }
}
