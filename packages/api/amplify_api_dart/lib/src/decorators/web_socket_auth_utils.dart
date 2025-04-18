// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

@internal
library;

import 'dart:convert';

import 'package:amplify_api_dart/src/decorators/authorize_http_request.dart';
import 'package:amplify_api_dart/src/graphql/web_socket/types/web_socket_types.dart';
import 'package:amplify_core/amplify_core.dart';
// ignore: implementation_imports
import 'package:amplify_core/src/config/amplify_outputs/api_outputs.dart';
import 'package:meta/meta.dart';

const _appSyncHostPortion = 'appsync-api';
const _appSyncRealtimeHostPortion = 'appsync-realtime-api';
const _appSyncHostSuffix = 'amazonaws.com';
const _appSyncPath = 'graphql';
const _customDomainPath = 'graphql/realtime';

// Constants for header values as noted in https://docs.aws.amazon.com/appsync/latest/devguide/real-time-websocket-client.html.
const _requiredHeaders = {
  AWSHeaders.accept: 'application/json, text/javascript',
  AWSHeaders.contentEncoding: 'amz-1.0',
  AWSHeaders.contentType: 'application/json; charset=utf-8',
};

/// The default payload to include to AppSync.
///
/// AppSync expects "{}" encoded in the URI as the payload during handshake.
@internal
const appSyncDefaultPayload = <String, dynamic>{};

/// Generate a URI for the connection and all subscriptions.
///
/// See https://docs.aws.amazon.com/appsync/latest/devguide/real-time-websocket-client.html#handshake-details-to-establish-the-websocket-connection=
Future<Uri> generateConnectionUri(ApiOutputs config) async {
  final authQueryParameters = {
    'payload': base64.encode(utf8.encode(json.encode(appSyncDefaultPayload))),
  };
  // Conditionally format the URI for a) AppSync domain b) custom domain.
  var endpointUriHost = Uri.parse(config.url).host;
  String path;
  if (endpointUriHost.contains(_appSyncHostPortion) &&
      endpointUriHost.endsWith(_appSyncHostSuffix)) {
    // AppSync domain that contains "appsync-api" and ends with "amazonaws.com."
    // Replace "appsync-api" with "appsync-realtime-api," append "/graphql."
    endpointUriHost = endpointUriHost.replaceFirst(
      _appSyncHostPortion,
      _appSyncRealtimeHostPortion,
    );
    path = _appSyncPath;
  } else {
    // Custom domain, append "graphql/realtime" to the path like on https://docs.aws.amazon.com/appsync/latest/devguide/custom-domain-name.html.
    path = _customDomainPath;
  }
  // Return wss URI with auth query parameters.
  return Uri(
    scheme: 'wss',
    host: endpointUriHost,
    path: path,
  ).replace(queryParameters: authQueryParameters);
}

/// Generate websocket message with authorized payload to register subscription.
///
/// See https://docs.aws.amazon.com/appsync/latest/devguide/real-time-websocket-client.html#subscription-registration-message
Future<WebSocketSubscriptionRegistrationMessage>
generateSubscriptionRegistrationMessage<T>(
  ApiOutputs config, {
  required String id,
  required AmplifyAuthProviderRepository authRepo,
  required GraphQLRequest<T> request,
}) async {
  final body = {'variables': request.variables, 'query': request.document};
  final authorizationHeaders = await generateAuthorizationHeaders(
    config,
    isConnectionInit: false,
    authRepo: authRepo,
    body: body,
    authorizationMode: request.authorizationMode,
    customHeaders: request.headers,
  );

  return WebSocketSubscriptionRegistrationMessage(
    id: id,
    payload: SubscriptionRegistrationPayload(
      request: request,
      config: config,
      authorizationHeaders: authorizationHeaders,
    ),
  );
}

/// For either connection URI or subscription registration, authorization headers
/// are formatted correctly to be either encoded into URI query params or subscription
/// registration payload headers.
///
/// If `isConnectionInit` true then headers are formatted like connection URI.
/// Otherwise body will be formatted as subscription registration. This is done by creating
/// a canonical HTTP request that is authorized but never sent. The headers from
/// the HTTP request are reformatted and returned. This logic applies for all auth
/// modes as determined by [authRepo] parameter.
@internal
Future<Map<String, String>> generateAuthorizationHeaders(
  ApiOutputs config, {
  required bool isConnectionInit,
  required AmplifyAuthProviderRepository authRepo,
  required Map<String, dynamic> body,
  APIAuthorizationType? authorizationMode,
  Map<String, String>? customHeaders,
}) async {
  final endpointHost = Uri.parse(config.url).host;
  // Create canonical HTTP request to authorize but never send.
  //
  // The canonical request URL is a little different depending on if authorizing
  // connection URI or start message (subscription registration).
  final maybeConnect = isConnectionInit ? '/connect' : '';
  final canonicalHttpRequest = AWSStreamedHttpRequest.post(
    Uri.parse('${config.url}$maybeConnect'),
    headers: {...?customHeaders, ..._requiredHeaders},
    body: HttpPayload.json(body),
  );
  final authorizedHttpRequest = await authorizeHttpRequest(
    canonicalHttpRequest,
    endpointConfig: config,
    authProviderRepo: authRepo,
    authorizationMode: authorizationMode,
  );

  // Take authorized HTTP headers as map with "host" value added.
  return {...authorizedHttpRequest.headers, AWSHeaders.host: endpointHost};
}
