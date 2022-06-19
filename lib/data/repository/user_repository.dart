import 'dart:async';

import 'package:delivery_app/src/utils/loger/console_loger.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../src/models/models.dart';

class UserRepository {
  final GraphQLClient gqlClient;

  UserRepository({required this.gqlClient});

  Future signupUser(variables) async {
    String signupMutation = r'''
     mutation AuthPhoneAndRegister($token: PhoneSignupInput) {
        authPhoneAndRegister(token: $token) {
          user {
            id
            firstName
            lastName
            phone
            role
          }
          token
        }
     }
      ''';

    final response = await gqlClient
        .mutate(MutationOptions(
      document: gql(signupMutation),
      variables: variables,
      fetchPolicy: FetchPolicy.noCache,
    ))
        .timeout(const Duration(seconds: 30), onTimeout: () {
      throw TimeoutException('request timed out', const Duration(seconds: 30));
    });

    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print(response);
    return User.fromJson(response.data!['authPhoneAndRegister']['user'],
        token: response.data!['authPhoneAndRegister']['token']);
  }

  Future reset(String password, String token) async {
    String signupMutation = r'''
     mutation AuthPhoneAndResetPwd($token: resetPwdInput) {
        authPhoneAndResetPwd(token: $token) {
          user {
            id
            firstName
            lastName
            role
          }
          token
        }
    }
     ''';
    final response = await gqlClient.mutate(MutationOptions(
      document: gql(signupMutation),
      variables: {
        "token": {
          "password": password,
          "confirmPassword": password,
          "idToken": token
        }
      },
      fetchPolicy: FetchPolicy.noCache,
    ));

    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    } else {
      print(response);
    }

    return User.fromJson(response.data!['authPhoneAndResetPwd']['user'],
        token: response.data!['authPhoneAndResetPwd']['token']);
  }

  Future<Address> updateUserAddress(Address address) async {
    final response = await gqlClient.mutate(MutationOptions(
      document: gql(r'''
        mutation Mutation($input: UserAddressUpdateInput!) {
          updateUserAddress(input: $input) {
            id
            role
            address {
              subCity
              city
              addressName
              country
            }
          }
        }
        '''),
      variables: {
        "input": {
          "subCity": address.subCity,
          "city": address.city,
          "addressName": address.addressName,
          "country": address.country,
        }
      },
      fetchPolicy: FetchPolicy.noCache,
    ));

    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print(response);
    return Address.fromJson(
      response.data!['updateUserAddress']['address'],
    );
  }

  Future signInUser(variables) async {
    String signInMutation = r'''
       mutation Login($input: loginInput!) {
          login(input: $input) {
            user {
              image {
                imageCover
              }
              id
              firstName
              lastName
              phone
              shopId
              role
              address {
                addressName
                city
                country
                subCity
              }
            }
            token
          }
      }
      ''';
    final response = await gqlClient
        .mutate(
      MutationOptions(
        document: gql(signInMutation),
        variables: variables,
        fetchPolicy: FetchPolicy.noCache,
      ),
    )
        .timeout(const Duration(seconds: 30), onTimeout: () {
      throw TimeoutException('request timed out', const Duration(seconds: 30));
    });

    if (response.hasException) {
      logTrace("response exception", response.exception);
      for (var element in response.exception!.graphqlErrors) {
        if (element.message == 'info or password wrong') {
          throw Exception("Username or Password Incorrect");
        }
        // if (response.exception!.graphqlErrors[0].message ==
        //     'info or password wrong') {
        throw Exception("Error Happened");
      }
      throw Exception("Error Happened");
    }

    if (response.data!['login']['user'] != null) {
      logTrace("new key", response);
      return User.fromJson(response.data!['login']['user'],
          token: response.data!['login']['token']);
    }
  }

  Future<User> getMe() async {
    String queryGetMe = r'''
       query GetMe {
          getMe {
            id
            role
            shopId
            image {
              imageCover
            }
            address {
                subCity
                city
                addressName
                country
            }
          }
      }
      ''';

    final response = await gqlClient.query(
      QueryOptions(
        document: gql(queryGetMe),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print(response);
    return User.fromJson(response.data!['getMe']);
  }

  Future<bool> updateProfile(variable) async {
    print(variable);
    final response = await gqlClient.mutate(MutationOptions(
      document: gql(r'''
            mutation UpdateMe($input: UserUpdateInput) {
                  updateMe(input: $input) {
                    id
                    firstName
                    lastName
                    phone
                    role
                    image {
                        imageCover
                    }
              }
            }
      '''),
      variables: variable,
      fetchPolicy: FetchPolicy.noCache,
    ));
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print('responce $response');
    return (response.data!['updateMe']['id']) != null;
  }

  Future<bool> updatePassword(variable) async {
    // print(variable);
    final response = await gqlClient.mutate(MutationOptions(
      document: gql(r'''
            mutation ChangePassword($input: changePwdInput) {
                changePassword(input: $input) {
                  id
               }
}
      '''),
      variables: variable,
      fetchPolicy: FetchPolicy.noCache,
    ));
    if (response.hasException) {
      for (var element in response.exception!.graphqlErrors) {
        if (element.message == 'User credentials not correct') {
          throw Exception("Incorrect old password");
        }
      }
      throw Exception("Error Happened");
    }
    return (response.data!['changePassword']['id']) != null;
  }
}
