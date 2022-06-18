import 'package:graphql_flutter/graphql_flutter.dart';

import '../../src/app.dart';

class CartRepository {
  final GraphQLClient gqlClient;

  CartRepository({required this.gqlClient});

  Future<List<Cart>> getCart() async {
    final response = await gqlClient.query(
      QueryOptions(
        document: gql(r'''
            query GetCartByUserId {
              getCartByUserId {
                id
                itemId
                name
                amount
                price
                status
                userId
                shopId
              }
            }
      '''),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print(response);
    return (response.data!['getCartByUserId'] as List)
        .map((json) => Cart.fromJson(json))
        .toList();
  }

  Future addToCart(Cart cart) async {
    final response = await gqlClient.mutate(MutationOptions(
      document: gql(r'''
            mutation AddToCart($input: CartItemsInput!) {
              addToCart(input: $input) {
                id
              }
            }
      '''),
      variables: {
        "input": {
          "name": cart.name,
          "shopId": cart.shopId,
          "itemId": cart.itemId,
          "price": cart.price,
          "amount": cart.amount,
        }
      },
      fetchPolicy: FetchPolicy.noCache,
    ));
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print(response);
  }

  Future deleteCart(cartId) async {
    final response = await gqlClient.mutate(MutationOptions(
      document: gql(r'''
            mutation Mutation($deleteCartId: ID!) {
              deleteCart(id: $deleteCartId) {
                id
              }
            }
      '''),
      variables: {"deleteCartId": cartId},
      fetchPolicy: FetchPolicy.noCache,
    ));
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print(response);
  }
}
