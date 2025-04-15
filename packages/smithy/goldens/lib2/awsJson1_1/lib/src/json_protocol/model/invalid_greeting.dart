// Generated with smithy-dart 0.3.2. DO NOT MODIFY.
// ignore_for_file: avoid_unused_constructor_parameters,deprecated_member_use_from_same_package,non_constant_identifier_names,unnecessary_library_name

library aws_json1_1_v2.json_protocol.model.invalid_greeting; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i2;

part 'invalid_greeting.g.dart';

/// This error is thrown when an invalid greeting value is provided.
abstract class InvalidGreeting
    with _i1.AWSEquatable<InvalidGreeting>
    implements
        Built<InvalidGreeting, InvalidGreetingBuilder>,
        _i2.SmithyHttpException {
  /// This error is thrown when an invalid greeting value is provided.
  factory InvalidGreeting({String? message}) {
    return _$InvalidGreeting._(message: message);
  }

  /// This error is thrown when an invalid greeting value is provided.
  factory InvalidGreeting.build([
    void Function(InvalidGreetingBuilder) updates,
  ]) = _$InvalidGreeting;

  const InvalidGreeting._();

  /// Constructs a [InvalidGreeting] from a [payload] and [response].
  factory InvalidGreeting.fromResponse(
    InvalidGreeting payload,
    _i1.AWSBaseHttpResponse response,
  ) => payload.rebuild((b) {
    b.statusCode = response.statusCode;
    b.headers = response.headers;
  });

  static const List<_i2.SmithySerializer<InvalidGreeting>> serializers = [
    InvalidGreetingAwsJson11Serializer(),
  ];

  @override
  String? get message;
  @override
  _i2.ShapeId get shapeId => const _i2.ShapeId(
    namespace: 'aws.protocoltests.json',
    shape: 'InvalidGreeting',
  );

  @override
  _i2.RetryConfig? get retryConfig => null;

  @override
  @BuiltValueField(compare: false)
  int? get statusCode;
  @override
  @BuiltValueField(compare: false)
  Map<String, String>? get headers;
  @override
  Exception? get underlyingException => null;

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('InvalidGreeting')
      ..add('message', message);
    return helper.toString();
  }
}

class InvalidGreetingAwsJson11Serializer
    extends _i2.StructuredSmithySerializer<InvalidGreeting> {
  const InvalidGreetingAwsJson11Serializer() : super('InvalidGreeting');

  @override
  Iterable<Type> get types => const [InvalidGreeting, _$InvalidGreeting];

  @override
  Iterable<_i2.ShapeId> get supportedProtocols => const [
    _i2.ShapeId(namespace: 'aws.protocols', shape: 'awsJson1_1'),
  ];

  @override
  InvalidGreeting deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InvalidGreetingBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final value = iterator.current;
      if (value == null) {
        continue;
      }
      switch (key) {
        case 'Message':
          result.message =
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
    InvalidGreeting object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result$ = <Object?>[];
    final InvalidGreeting(:message) = object;
    if (message != null) {
      result$
        ..add('Message')
        ..add(
          serializers.serialize(message, specifiedType: const FullType(String)),
        );
    }
    return result$;
  }
}
