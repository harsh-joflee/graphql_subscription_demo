import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_subscription_demo/core/graphql_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Subscription(
          options: SubscriptionOptions(
            document: HelloWorld.subscriptionDocument,
          ),
          builder: (result) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final count = result.data?["temp"][0]["count"];
            return Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 100,
              ),
            );
          }),
    ));
  }
}
