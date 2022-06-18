import 'package:graphql_flutter/graphql_flutter.dart';

import '../../src/models/order.dart';

class OrderRepository {
  final GraphQLClient gqlClient;

  OrderRepository({required this.gqlClient});

  Future<List<Order>> getOrder(String status) async {
    String getOrderByDelivery = r'''
       query GetOrderByDelivery($deliveryStatus: OrderDeliveryStatus){
          getOrderByDelivery(deliveryStatus: $deliveryStatus) {
            id
            deliveryStatus
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
            actions {
              type
              date
              messages
            }
            sellerActions {
              type
              date
              messages
            }
          }
        }
      ''';
    final response = await gqlClient.query(
      QueryOptions(
        document: gql(getOrderByDelivery),
        variables: {"deliveryStatus": "REQUESTED"},
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    List<Order> newOrders = [];
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    } else {
      print(response);
      for (var element in (response.data!["getOrderByDelivery"] as List)) {
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
            deliveryStatus
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
              type
              date
              messages
            }
            sellerActions {
              type
              date
              messages
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
              deliveryStatus
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
              sellerActions {
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

  Future<Order> assignDelivery(String orderId, String shopId) async {
    String orderAction = r'''
        mutation Mutation($orderId: ID, $action: OrderActionsTypesInput) {
          orderAction(orderId: $orderId, action: $action) {
            id
            deliveryStatus
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
              type
              date
              messages
            }
            sellerActions {
              type
              date
              messages
            }
          }
        }
      ''';
    final response = await gqlClient.query(
      QueryOptions(
        document: gql(orderAction),
        variables: {
          "orderId": orderId,
          "action": {"actionType": "RequestDelivery", "deliveryId": shopId}
        },
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print(response);
    return Order.fromJson(response.data!["orderAction"]);
  }

  Future<Order> removeDelivery(String orderId) async {
    String orderAction = r'''
        mutation Mutation($orderId: ID, $action: OrderActionsTypesInput) {
          orderAction(orderId: $orderId, action: $action) {
            id
            deliveryStatus
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
              type
              date
              messages
            }
            sellerActions {
              type
              date
              messages
            }
          }
        }
      ''';
    final response = await gqlClient.query(
      QueryOptions(
        document: gql(orderAction),
        variables: {
          "orderId": orderId,
          "action": const {"actionType": "DeclinedByDelivery"}
        },
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print(response);
    return Order.fromJson(response.data!["orderAction"]);
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
