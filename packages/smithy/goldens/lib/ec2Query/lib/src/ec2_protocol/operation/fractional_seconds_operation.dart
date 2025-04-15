// Generated with smithy-dart 0.3.2. DO NOT MODIFY.
// ignore_for_file: avoid_unused_constructor_parameters,deprecated_member_use_from_same_package,non_constant_identifier_names,unnecessary_library_name

library ec2_query_v1.ec2_protocol.operation.fractional_seconds_operation; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i4;

import 'package:aws_common/aws_common.dart' as _i3;
import 'package:ec2_query_v1/src/ec2_protocol/common/endpoint_resolver.dart';
import 'package:ec2_query_v1/src/ec2_protocol/common/serializers.dart';
import 'package:ec2_query_v1/src/ec2_protocol/model/fractional_seconds_output.dart';
import 'package:smithy/smithy.dart' as _i1;
import 'package:smithy_aws/smithy_aws.dart' as _i2;

class FractionalSecondsOperation
    extends
        _i1.HttpOperation<
          _i1.Unit,
          _i1.Unit,
          FractionalSecondsOutput,
          FractionalSecondsOutput
        > {
  FractionalSecondsOperation({
    required String region,
    Uri? baseUri,
    List<_i1.HttpRequestInterceptor> requestInterceptors = const [],
    List<_i1.HttpResponseInterceptor> responseInterceptors = const [],
  }) : _region = region,
       _baseUri = baseUri,
       _requestInterceptors = requestInterceptors,
       _responseInterceptors = responseInterceptors;

  @override
  late final List<
    _i1.HttpProtocol<
      _i1.Unit,
      _i1.Unit,
      FractionalSecondsOutput,
      FractionalSecondsOutput
    >
  >
  protocols = [
    _i2.Ec2QueryProtocol(
      serializers: serializers,
      builderFactories: builderFactories,
      requestInterceptors:
          <_i1.HttpRequestInterceptor>[
            const _i1.WithHost(),
            const _i1.WithUserAgent('aws-sdk-dart/0.3.2'),
            const _i2.WithSdkInvocationId(),
            const _i2.WithSdkRequest(),
          ] +
          _requestInterceptors,
      responseInterceptors:
          <_i1.HttpResponseInterceptor>[] + _responseInterceptors,
      action: 'FractionalSeconds',
      version: '2020-01-08',
    ),
  ];

  late final _i2.AWSEndpoint _awsEndpoint = endpointResolver.resolve(
    sdkId,
    _region,
  );

  final String _region;

  final Uri? _baseUri;

  final List<_i1.HttpRequestInterceptor> _requestInterceptors;

  final List<_i1.HttpResponseInterceptor> _responseInterceptors;

  @override
  _i1.HttpRequest buildRequest(_i1.Unit input) => _i1.HttpRequest((b) {
    b.method = 'POST';
    b.path = r'/';
  });

  @override
  int successCode([FractionalSecondsOutput? output]) => 200;

  @override
  FractionalSecondsOutput buildOutput(
    FractionalSecondsOutput payload,
    _i3.AWSBaseHttpResponse response,
  ) => FractionalSecondsOutput.fromResponse(payload, response);

  @override
  List<_i1.SmithyError> get errorTypes => const [];

  @override
  String get runtimeTypeName => 'FractionalSeconds';

  @override
  _i2.AWSRetryer get retryer => _i2.AWSRetryer();

  @override
  Uri get baseUri => _baseUri ?? endpoint.uri;

  @override
  _i1.Endpoint get endpoint => _awsEndpoint.endpoint;

  @override
  _i1.SmithyOperation<FractionalSecondsOutput> run(
    _i1.Unit input, {
    _i3.AWSHttpClient? client,
    _i1.ShapeId? useProtocol,
  }) {
    return _i4.runZoned(
      () => super.run(input, client: client, useProtocol: useProtocol),
      zoneValues: {
        ...?_awsEndpoint.credentialScope?.zoneValues,
        ...{_i3.AWSHeaders.sdkInvocationId: _i3.uuid(secure: true)},
      },
    );
  }
}
