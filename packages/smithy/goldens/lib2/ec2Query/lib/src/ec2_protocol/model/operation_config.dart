// Generated with smithy-dart 0.3.2. DO NOT MODIFY.
// ignore_for_file: avoid_unused_constructor_parameters,deprecated_member_use_from_same_package,non_constant_identifier_names,unnecessary_library_name

library ec2_query_v2.ec2_protocol.model.operation_config; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ec2_query_v2/src/ec2_protocol/model/s3_config.dart';
import 'package:smithy/smithy.dart' as _i2;

part 'operation_config.g.dart';

/// Configuration that is set for the scope of a single operation.
abstract class OperationConfig
    with _i1.AWSEquatable<OperationConfig>
    implements Built<OperationConfig, OperationConfigBuilder> {
  /// Configuration that is set for the scope of a single operation.
  factory OperationConfig({S3Config? s3}) {
    return _$OperationConfig._(s3: s3);
  }

  /// Configuration that is set for the scope of a single operation.
  factory OperationConfig.build([
    void Function(OperationConfigBuilder) updates,
  ]) = _$OperationConfig;

  const OperationConfig._();

  static const List<_i2.SmithySerializer<OperationConfig>> serializers = [
    OperationConfigEc2QuerySerializer(),
  ];

  /// Configuration specific to S3.
  S3Config? get s3;
  @override
  List<Object?> get props => [s3];

  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('OperationConfig')
      ..add('s3', s3);
    return helper.toString();
  }
}

class OperationConfigEc2QuerySerializer
    extends _i2.StructuredSmithySerializer<OperationConfig> {
  const OperationConfigEc2QuerySerializer() : super('OperationConfig');

  @override
  Iterable<Type> get types => const [OperationConfig, _$OperationConfig];

  @override
  Iterable<_i2.ShapeId> get supportedProtocols => const [
    _i2.ShapeId(namespace: 'aws.protocols', shape: 'ec2Query'),
  ];

  @override
  OperationConfig deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OperationConfigBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final value = iterator.current;
      if (value == null) {
        continue;
      }
      switch (key) {
        case 's3':
          result.s3.replace(
            (serializers.deserialize(
                  value,
                  specifiedType: const FullType(S3Config),
                )
                as S3Config),
          );
      }
    }

    return result.build();
  }

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    OperationConfig object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result$ = <Object?>[
      const _i2.XmlElementName(
        'OperationConfigResponse',
        _i2.XmlNamespace('https://example.com/'),
      ),
    ];
    final OperationConfig(:s3) = object;
    if (s3 != null) {
      result$
        ..add(const _i2.XmlElementName('S3'))
        ..add(
          serializers.serialize(s3, specifiedType: const FullType(S3Config)),
        );
    }
    return result$;
  }
}
