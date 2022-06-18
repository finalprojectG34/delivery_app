import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink _httpLink = HttpLink('http://192.168.0.196:8000/graphql');

Link concat() {
  const storage = FlutterSecureStorage();
  final AuthLink authLink = AuthLink(getToken: () async {
    var token = await storage.read(key: "token");
    return 'Bearer ${token.toString()}';
  });
  return authLink.concat(_httpLink);
}

class Client {
  static final Client _client = Client._internal();

  factory Client() => _client;

  Client._internal();

  GraphQLClient connect = GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: concat(),
  );
}
