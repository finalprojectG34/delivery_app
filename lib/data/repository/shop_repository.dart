import 'dart:async';

import 'package:delivery_app/src/models/shop.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../src/models/user.dart';

class ShopRepository {
  final GraphQLClient gqlClient;

  ShopRepository({required this.gqlClient});

  Future<List<Shop>> getShops(int pageSize, int pageIndex) async {
    // final response = await gqlClient.query(
    //   QueryOptions(document: gql(r'''
    //     query GetOrderByUserId($status: String) {
    //       getOrderByUserId(status: $status) {
    //         id
    //         status
    //         userId
    //         shopId
    //         orderItems {
    //           id
    //           name
    //           price
    //           amount
    //         }
    //         subTotal
    //       }
    //     }
    //   '''), variables: {"pageIndex": pageIndex, "pageSize": pageSize}),
    // );
    // List<Shop> newOrders = [];
    // if (response.hasException) {
    //   print(response.exception);
    // } else {
    //   print(response);
    //   for (var element in (response.data!["getOrderByUserId"] as List)) {
    //     newOrders.add(Shop.fromJson(element));
    //   }
    // }
    // return newOrders;
    return getMockShops();
  }

  Future<List<Shop>> getShopByRole(String role) async {
    String getAllCompanies = r'''
        query GetAllCompanies($input: CompanyFilter) {
          getAllCompanies(input: $input) {
            id
            name
            description
            phoneNumber
            image {
              bgImage
              imageCover
            }
            tinNumber
            address {
              subCity
              city
              addressName
              country
            }
            ownerId
            status
            role
          }
        }
      ''';
    final response = await gqlClient.query(
      QueryOptions(
        document: gql(getAllCompanies),
        variables: {
          "input": {"role": role, "status": "Verified"}
        },
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    List<Shop> shops = [];
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    } else {
      print(response);
      for (var element in (response.data!["getAllCompanies"] as List)) {
        print(element);
        shops.add(Shop.fromJson(element));
      }
    }
    return shops;
  }

  Future<List<Shop>> getMockShops() {
    return Future.delayed(const Duration(seconds: 4), () {
      return List.generate(30, (i) {
        return Shop(
          id: "$i",
          phoneNumber: "+2519499494",
          image:
              "https://www.shutterstock.com/image-photo/young-student-watching-lesson-online-studying-1676998306",
          name: "Shop $i",
          address: Address(addressName: "Jemo"),
          description: "Shop $i sells shoes",
        );
      });
    });
  }

  Future<Shop> getShopById(String shopId) async {
    String orderAction = r'''
       query Query($getOneCompanyId: String!) {
        getOneCompany(id: $getOneCompanyId) {
            id
            name
            description
            phoneNumber
            image {
              bgImage
              imageCover
            }
            tinNumber
            address {
              subCity
              city
              addressName
              country
            }
            ownerId
            status
            role
          }
        }
      ''';
    final response = await gqlClient.query(
      QueryOptions(
        document: gql(orderAction),
        variables: {"getOneCompanyId": shopId},
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print(response);
    return Shop.fromJson(response.data!["getOneCompany"]);
  }

  Future<Shop> addShop({name, description, subCity, city, imageCover}) async {
    String addItemMutation = r'''
     mutation CreateCompany($input: CompanyInput!) {
        createCompany(input: $input) {
          id
          slug
          name
          ownerId
          status
        }
      }
      ''';

    final response = await gqlClient.query(QueryOptions(
      document: gql(addItemMutation),
      variables: {
        "input": {
          "name": name,
          "description": description,
          "address": {"subCity": subCity, "city": city},
          "image": {"imageCover": imageCover},
          "role": "DELIVERY",
        }
      },
      fetchPolicy: FetchPolicy.noCache,
    ));
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print(response);
    return Shop.fromJson(response.data!['createCompany']);
  }

  Future<bool> getUserShop(String userId) async {
    final response = await gqlClient
        .query(
      QueryOptions(
        document: gql(r'''
          query GetCompanyByUserId($getCompanyByUserIdId: ID) {
              getCompanyByUserId(id: $getCompanyByUserIdId) {
                id
              }
          }
  '''),
        fetchPolicy: FetchPolicy.noCache,
      ),
    )
        .timeout(Duration(seconds: 30), onTimeout: () {
      throw TimeoutException('request timed out', const Duration(seconds: 30));
    });
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print((response.data!['getCompanyByUserId'] as List));
    return (response.data!['getCompanyByUserId'] as List).isNotEmpty;
  }
}

final mockShop = Shop(
  id: "1",
  phoneNumber: "+2519499494",
  image:
      "https://www.shutterstock.com/image-photo/young-student-watching-lesson-online-studying-1676998306",
  name: "Shop 1",
  address: Address(addressName: "Jemo"),
  description: "Shop 1 sells shoes",
);
