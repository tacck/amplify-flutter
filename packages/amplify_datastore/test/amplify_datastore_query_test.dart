// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_test/amplify_test.dart';
import 'package:amplify_test/test_models/ModelProvider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel dataStoreChannel = MethodChannel(
    'com.amazonaws.amplify/datastore',
  );

  AmplifyDataStore dataStore = AmplifyDataStore(
    modelProvider: ModelProvider.instance,
  );

  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      dataStoreChannel,
      null,
    );
  });

  test('query returns nested model result', () async {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(dataStoreChannel, (
      MethodCall methodCall,
    ) async {
      if (methodCall.method == "query") {
        return getJsonFromFile('query_api/response/nested_results.json');
      }
      return null;
    });
    List<Comment> comments = await dataStore.query(Comment.classType);
    expect(comments.length, 1);
    expect(
      comments[0],
      Comment(
        id: '39c3c0e6-8726-436e-8cdf-bff38e9a62da',
        content: 'Loving Amplify Datastore!',
        post: Post(
          id: 'e50ffa8f-783b-4780-89b4-27043ffc35be',
          title: "some title",
          rating: 10,
          created: TemporalDateTime.fromString("2020-11-25T01:28:49Z"),
        ),
      ),
    );
  });

  test('query returns 2 sucessful results', () async {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(dataStoreChannel, (
      MethodCall methodCall,
    ) async {
      if (methodCall.method == "query") {
        return getJsonFromFile('query_api/response/2_results.json');
      }
      return null;
    });
    List<Post> posts = await dataStore.query(Post.classType);
    expect(posts.length, 2);
    expect(
      posts[0],
      Post(
        id: '4281dfba-96c8-4a38-9a8e-35c7e893ea47',
        created: TemporalDateTime.fromString("2020-02-20T20:20:20+03:50"),
        rating: 4,
        title: 'Title 1',
      ),
    );
    expect(
      posts[1],
      Post(
        id: '43036c6b-8044-4309-bddc-262b6c686026',
        created: TemporalDateTime.fromString("2020-02-20T20:20:20-08:00"),
        rating: 6,
        title: 'Title 2',
      ),
    );
  });

  test('query returns 0 sucessful results', () async {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(dataStoreChannel, (
      MethodCall methodCall,
    ) async {
      if (methodCall.method == "query") {
        return [];
      }
      return null;
    });
    List<Post> posts = await dataStore.query(Post.classType);
    expect(posts.length, 0);
  });

  test(
    'method channel is called with empty query parameters and correct model name',
    () async {
      binding.defaultBinaryMessenger.setMockMethodCallHandler(
        dataStoreChannel,
        (MethodCall methodCall) async {
          if (methodCall.method == "query") {
            expect(
              methodCall.arguments,
              await getJsonFromFile('query_api/request/only_model_name.json'),
            );
            return [];
          }
          return null;
        },
      );
      List<Post> posts = await dataStore.query(Post.classType);
      expect(posts.length, 0);
    },
  );

  test(
    'method channel is called with all query parameters and model name',
    () async {
      binding.defaultBinaryMessenger.setMockMethodCallHandler(
        dataStoreChannel,
        (MethodCall methodCall) async {
          if (methodCall.method == "query") {
            expect(
              methodCall.arguments,
              await getJsonFromFile(
                'query_api/request/model_name_with_all_query_parameters.json',
              ),
            );
            return [];
          }
          return null;
        },
      );
      List<Post> posts = await dataStore.query(
        Post.classType,
        where: Post.ID
            .eq("123")
            .or(
              Post.RATING
                  .ge(4)
                  .and(not(Post.CREATED.eq("2020-02-20T20:20:20-08:00"))),
            ),
        sortBy: [Post.ID.ascending(), Post.CREATED.descending()],
        pagination: QueryPagination(page: 2, limit: 8),
      );
      expect(posts.length, 0);
    },
  );

  test('method channel throws a known PlatformException', () async {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(dataStoreChannel, (
      MethodCall methodCall,
    ) async {
      if (methodCall.method == "query") {
        throw PlatformException(
          code: 'DataStoreException',
          details: {
            'message': 'Query failed for whatever known reason',
            'recoverySuggestion': 'some insightful suggestion',
            'underlyingException': 'Act of God',
          },
        );
      }
      return null;
    });
    expect(
      () => dataStore.query(Post.classType),
      throwsA(
        isA<DataStoreException>()
            .having(
              (exception) => exception.message,
              'message',
              'Query failed for whatever known reason',
            )
            .having(
              (exception) => exception.recoverySuggestion,
              'recoverySuggestion',
              'some insightful suggestion',
            )
            .having(
              (exception) => exception.underlyingException,
              'underlyingException',
              'Act of God',
            ),
      ),
    );
  });
}
