import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class HelloWorld {
  //GQL SUBSCRIPTION
  static final subscriptionDocument = gql(
    r'''
    subscription TestSubscription {
  temp{
    count
    id
  }
}
  ''',
  );

  //GQL LINK
  static final HttpLink httpLink = HttpLink(
    'https://psychologyfacts.joflee.com/v1/graphql',
  );

  //LINK SPLIT FOR SUBSCRIPTION
  static final link = Link.split(
    (request) => request.isSubscription,
    WebSocketLink(
      'wss://psychologyfacts.joflee.com/v1/graphql',
      config: const SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: Duration(seconds: 30),
      ),
    ),
    HttpLink('https://psychologyfacts.joflee.com/v1/graphql'),
  );

  //INIT CLIENT FOR GQL
  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    ),
  );
}
