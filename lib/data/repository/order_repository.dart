import 'package:graphql_flutter/graphql_flutter.dart';

import '../../src/models/order.dart';

class OrderRepository {
  final GraphQLClient gqlClient;

  OrderRepository({required this.gqlClient});

  Future<List<Order>> getOrder(String status) async {
    String getOrderByUserId = r'''
        query GetOrderByUserId($status: String) {
          getOrderByUserId(status: $status) {
            id
            status
            userId
            shopId
            createdAt
            orderItems {
              id
              name
              price
              amount
            }
            subTotal
            deliveryAddress {
              addressName
              city
              subCity
              country
            }
          }
        }
      ''';
    final response = await gqlClient.query(
      QueryOptions(
        document: gql(getOrderByUserId),
        variables: {"status": status},
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    List<Order> newOrders = [];
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    } else {
      print(response);
      for (var element in (response.data!["getOrderByUserId"] as List)) {
        print(element);
        newOrders.add(Order.fromJson(element));
      }
    }
    return newOrders;
  }

  Future<Order> getOrderById(String orderId) async {
    String getOneOrder = r'''
        query GetOneOrder($getOneOrderId: String!) {
          getOneOrder(id: $getOneOrderId) {
            id
            status
            userId
            shopId
            createdAt
            deliveryId
            orderItems {
              id
              name
              price
              amount
            }
            subTotal
            deliveryAddress {
              subCity
              city
              addressName
              country
            }
            actions {
              date
              messages
              type
            }
          }
        }
      ''';
    final response = await gqlClient.query(
      QueryOptions(
        document: gql(getOneOrder),
        variables: {"getOneOrderId": orderId},
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print(response);
    Order newOrder = Order.fromJson(response.data!["getOneOrder"]);
    return newOrder;
  }

  Future<List<Order>> createOrder(List<Order> orders) async {
    final response = await gqlClient.mutate(MutationOptions(
      document: gql(r'''
        mutation CreateManyOrders($input: [OrderCreateInput!]!) {
          createManyOrders(input: $input) {
            id
          }
        }
      '''),
      variables: {
        "input": orders
            .map((order) => {
                  "name": "name",
                  "description": "description",
                  "shopId": order.shopId,
                  "deliveryAddress": {
                    "subCity": order.deliveryAddress?.subCity,
                    "city": order.deliveryAddress?.city,
                    "addressName": order.deliveryAddress?.addressName,
                    "country": order.deliveryAddress?.country,
                  },
                  "orderItems": order.orderItems
                      ?.map((orderItem) => {
                            "id": orderItem.id,
                            "name": orderItem.name,
                            "price": orderItem.price,
                            "amount": orderItem.amount,
                          })
                      .toList()
                })
            .toList(),
      },
      fetchPolicy: FetchPolicy.noCache,
    ));
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print(response);
    List<Order> newOrders = [];
    for (var element in (response.data!["createManyOrders"] as List)) {
      newOrders.add(Order.fromJson(element));
    }
    return newOrders;
  }

  Future<Order> updateOrderStatus(String orderId, String action) async {
    String updateOrderStatus = r'''
          mutation OrderAction($orderId: ID, $action: OrderActionsTypesInput) {
            orderAction(orderId: $orderId, action: $action) {
              id
              status
              userId
              shopId
              deliveryId
              createdAt
              orderItems {
                id
                name
                price
                amount
              }
              subTotal
              deliveryAddress {
                subCity
                city
                addressName
              }
              actions {
                type
                date
                messages
              }
            }
          }
      ''';
    final response = await gqlClient.mutate(MutationOptions(
      document: gql(updateOrderStatus),
      variables: {
        "orderId": orderId,
        "action": {"actionType": action}
      },
      fetchPolicy: FetchPolicy.noCache,
    ));
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print(response);
    Order newOrder = Order.fromJson(response.data!["orderAction"]);
    return newOrder;
  }

  Future deleteOrder(String orderId) async {
    final response = await gqlClient.mutate(MutationOptions(
      document: gql(r'''
            mutation Mutation($deleteCartId: ID!) {
              deleteCart(id: $deleteCartId) {
                id
              }
            }
      '''),
      variables: {"deleteCartId": orderId},
      fetchPolicy: FetchPolicy.noCache,
    ));
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
  }
}
